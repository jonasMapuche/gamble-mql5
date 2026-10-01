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
#include "../Target/MACDStick.mqh"
#include "../Gauge/MovingAverage.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class MACD : MACDStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      MACDStick *mACDStick[];
      
    public:
      MACD(const int value,const string inpattern,const int inmme);
      ~MACD();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
      bool MMHigh(const int value,const string intimenow,const bool save);      
      bool MMLow(const int value,const string intimenow,const bool save);      
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
MACD::MACD(const int value,const string inpattern,const int inmme)
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
    ArrayResize(mACDStick,quantity);
    MovingAverage *movingAverage;
    movingAverage=new MovingAverage(quantity,"MACD");
    int mme9_value=inmme;
    for(int i=quantity; i>=0; i--) {
      double macd_cumulate=movingAverage.MACD(quantity,i,mme9_value);
      double mme9_cumulate=movingAverage.MME(quantity,i,mme9_value);
      double histogram_cumulate=macd_cumulate-mme9_cumulate;
      mACDStick[i]=new MACDStick();
      mACDStick[i].Add(i,macd_cumulate,histogram_cumulate,mme9_cumulate);
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
//---

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
      if(i==value1) if(histogramnegative(mACDStick[i].histogram)) account[1]=TRUE; else account[1]=FALSE;
      if(i==value3) if(histogrampositive(mACDStick[i].histogram)) account[3]=TRUE; else account[3]=FALSE;
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
//---

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
      if(i==value1) if(histogrampositive(mACDStick[i].histogram)) account[1]=TRUE; else account[1]=FALSE;
      if(i==value3) if(histogramnegative(mACDStick[i].histogram)) account[3]=TRUE; else account[3]=FALSE;
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
