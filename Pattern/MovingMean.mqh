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
#include "../Target/MovingMeanStick.mqh"
#include "../Gauge/MovingAverage.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class MovingMean : MovingMeanStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      MovingMeanStick *movingMeanStick[];

    public:
      MovingMean(const int value,const string inpattern,const int inmms21,const int inmms200);
      ~MovingMean();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);      
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
MovingMean::MovingMean(const int value,const string inpattern,const int inmms21,const int inmms200)
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
    ArrayResize(movingMeanStick,quantity);
    MovingAverage *movingAverage;
    movingAverage=new MovingAverage(quantity,"MOVING MEAN");
    int mms21_value=inmms21;
    int mms200_value=inmms200;
    for(int i=quantity; i>=0; i--) {
      double mms21_cumulate=movingAverage.MMS(quantity,i,mms21_value);
      double mms200_cumulate=movingAverage.MMS(quantity,i,mms200_value);
      movingMeanStick[i]=new MovingMeanStick();
      movingMeanStick[i].Add(i,mms21_cumulate,mms200_cumulate);
    }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
MovingMean::~MovingMean()
  {
  }
//+------------------------------------------------------------------+
//| Write                                                            |
//+------------------------------------------------------------------+
void MovingMean::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
//---

  }
//+------------------------------------------------------------------+
//| Verify moving average high                                       |
//+------------------------------------------------------------------+
bool MovingMean::High(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(movingmeanhigh(movingMeanStick[i].mms21,movingMeanStick[i].mms200)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
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
//| Verify moving average low                                        |
//+------------------------------------------------------------------+
bool MovingMean::Low(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(movingmeanlow(movingMeanStick[i].mms21,movingMeanStick[i].mms200)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
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
