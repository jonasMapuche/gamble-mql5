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
#include "../Target/MovingAverageStick.mqh"
#include "../Gauge/MovingAverage.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class MACD : MovingAverageStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      MovingAverageStick *movingAverageStick[];
      
    public:
      MACD(const int value,const string inpattern);
      ~MACD();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
MACD::MACD(const int value,const string inpattern)
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
    ArrayResize(movingAverageStick,quantity);
    MovingAverage *movingAverage;
    movingAverage=new MovingAverage(quantity,"MACD");
    int init=1;
    int index26=26;
    int index12=12;
    int index9=9;
    for(int i=0; i<quantity; i++) {
      double inmme26=movingAverage.MME(index26);
      double inmme12=movingAverage.MME(index12);
      double inmme9=movingAverage.MME(index9);
      double inmacd=inmme26/inmme12;
      double inhistogram=inmacd-inmme9;
      movingAverageStick[i]=new MovingAverageStick();
      movingAverageStick[i].Add(i,inmacd,inhistogram,inmme9);
    }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
MACD::~MACD()
  {
  }
//+------------------------------------------------------------------+
//| Write                                                            |
//+------------------------------------------------------------------+
void MACD::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify low                                                       |
//+------------------------------------------------------------------+
bool MACD::Low(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int value2=value+1;
    int value3=value2+1;
    int account_max=3+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(histogramnegative(movingAverageStick[i].histogram)) account[1]=TRUE; else account[1]=FALSE;
      if(i==value3) if(histogrampositive(movingAverageStick[i].histogram)) account[3]=TRUE; else account[3]=FALSE;
//---
      if((account[1]==TRUE) && (account[3]==TRUE)) {
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
//| Verify high                                                      |
//+------------------------------------------------------------------+
bool MACD::High(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int value2=value+1;
    int value3=value2+1;
    int account_max=3+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(histogrampositive(movingAverageStick[i].histogram)) account[1]=TRUE; else account[1]=FALSE;
      if(i==value3) if(histogramnegative(movingAverageStick[i].histogram)) account[3]=TRUE; else account[3]=FALSE;
//---
      if((account[1]==TRUE) && (account[3]==TRUE)) {
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
