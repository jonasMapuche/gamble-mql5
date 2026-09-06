//+------------------------------------------------------------------+
//|                                                       Hammer.mqh |
//|             Copyright 2026, César Cardoso Silva & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "../Target/CandleStick.mqh"
#include "../Golang.mqh"
#include "../SQlite.mqh"
#include "../Target/BandBollingerStick.mqh"
#include "../Gauge/MovingAverage.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class BandBollinger : BandBollingerStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      BandBollingerStick *bandBollingerStick[];
      
    public:
      BandBollinger(const int value,const string inpattern);
      ~BandBollinger();
      void Write(const int value);
      bool Open(const int value,const string intimenow,const bool save);
      bool Close(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
BandBollinger::BandBollinger(const int value,const string inpattern)
  {
//---
    int quantity=value+1;
//---
    ArrayResize(candlestick,quantity);
    for(int i=0; i<=value; i++) {
      candlestick[i]=new CandleStick();
      candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
//---
    ArrayResize(bandBollingerStick,quantity);
    MovingAverage *movingAverage;
    movingAverage=new MovingAverage(quantity,"BANDBOLLINGER");
    int inmms=21;
    int indeviation=2;
    for(int i=0; i<quantity; i++) {
      double inmms21=movingAverage.MMS(inmms,i);
      double inbandup=movingAverage.BandUp(inmms,i,indeviation);
      double inbanddown=movingAverage.BandDown(inmms,i,indeviation);
      bandBollingerStick[i]=new BandBollingerStick();
      bandBollingerStick[i].Add(i,inbandup,inmms21,inbanddown);
    }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
BandBollinger::~BandBollinger()
  {
  }
//+------------------------------------------------------------------+
//| Write                                                            |
//+------------------------------------------------------------------+
void BandBollinger::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify opening                                                   |
//+------------------------------------------------------------------+
bool BandBollinger::Open(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int value2=value+1;
    int value3=value2+1;
    int account_max=3+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=0;
//---    
    for(int i=value1; i<=value3; i++) {
      if(i==value1) account[1]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
      if(i==value2) account[2]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
      if(i==value3) account[3]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
//---
      if((account[1]>account[2]) && (account[2]>account[3])) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify closing                                                   |
//+------------------------------------------------------------------+
bool BandBollinger::Close(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int value2=value+1;
    int value3=value2+1;
    int account_max=3+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=0;
//---    
    for(int i=value1; i<=value3; i++) {
      if(i==value1) account[1]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
      if(i==value2) account[2]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
      if(i==value3) account[3]=bollingermean(bandBollingerStick[i].bandup,bandBollingerStick[i].mms);
//---
      if((account[1]<account[2]) && (account[2]<account[3])) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---
    return false;
  }
//+------------------------------------------------------------------+
