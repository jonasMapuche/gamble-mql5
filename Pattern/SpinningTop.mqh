//+------------------------------------------------------------------+
//|                                                  SpinningTop.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Trade/SymbolInfo.mqh>
#include "../CandleStick.mqh"
#include "../Golang.mqh"
#include "../SQlite.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class SpinningTop : public CandleStick
  {
    private:
      double Mean();

    protected:
      CandleStick *candlestick[];  

    public:
      SpinningTop(const int value,const string inpattern);
      ~SpinningTop();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
SpinningTop::SpinningTop(const int value,const string inpattern)
  {
    ArrayResize(candlestick,value+1);
    for(int i=0; i<=value; i++) {
      candlestick[i]=new CandleStick();
      candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
SpinningTop::~SpinningTop()
  {
  }
//+------------------------------------------------------------------+
//| Write marubozu base                                              |
//+------------------------------------------------------------------+
void SpinningTop::Write(const int value)
  {
    for(int i=1; i<=value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i),candlestick[i].getTime(),DoubleToString(candlestick[i].getVolume()),candlestick[i].getPattern(),candlestick[i].getSymbol());
  }
//+------------------------------------------------------------------+
//| Verify spinning top green (high)                                 |
//+------------------------------------------------------------------+
bool SpinningTop::High(const int value,const string intimenow,const bool save,const double average)
  {
    double percent50=0.50;
    int value1=value;
    int div=5;
    int account_max=1+1;
    double inHigh1,inLow1,inOpen1,inClose1,meanbody,meanpercent50=0;
    string inTime,inPattern,inSymbol="";
//---
    const double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    if(green(candlestick[value1].getOpen(),candlestick[value1].getClose())) account[1]=TRUE;
//---
    if(account[1]==TRUE){
      inHigh1=candlestick[value1].getHigh();
      inLow1=candlestick[value1].getLow();
      inOpen1=candlestick[value1].getOpen();
      inClose1=candlestick[value1].getClose();
      meanbody=(inHigh1-inLow1)/div;
      meanpercent50=meanbody*percent50;
      inTime=candlestick[value1].getTime();
      inPattern=candlestick[value1].getPattern();
      inSymbol=candlestick[value1].getSymbol();
      if(
          ((inHigh1-inLow1)>=mean)
          &&
          (
            ((inClose1-inOpen1)<=meanbody)
            &&
            ((inClose1-inOpen1)>=meanpercent50)
          )
        ){
//--- 
        if(save){
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;          
      }
    }
    return false;
  }
//+------------------------------------------------------------------+
//| Verify spinning top red (low)                                    |
//+------------------------------------------------------------------+
bool SpinningTop::Low(const int value,const string intimenow,const bool save,const double average)
  {
    double percent50=0.50;
    int value1=value;
    int div=5;
    int account_max=1+1;
    double inHigh1,inLow1,inOpen1,inClose1,meanbody,meanpercent50=0;
    string inTime,inPattern,inSymbol="";
//---
    const double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    if(red(candlestick[value1].getOpen(),candlestick[value1].getClose())) account[1]=TRUE;
//---
    if(account[1]==TRUE){
      inHigh1=candlestick[value1].getHigh();
      inLow1=candlestick[value1].getLow();
      inOpen1=candlestick[value1].getOpen();
      inClose1=candlestick[value1].getClose();
      meanbody=(inHigh1-inLow1)/div;
      meanpercent50=meanbody*percent50;
      inTime=candlestick[value1].getTime();
      inPattern=candlestick[value1].getPattern();
      inSymbol=candlestick[value1].getSymbol();
      if(
          ((inHigh1-inLow1)>=mean)
          &&
          (
            ((inOpen1-inClose1)<=meanbody)
            &&
            ((inOpen1-inClose1)>=meanpercent50)
          )
        ){
//---   
        if(save){
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;          
      }
    }
    return false;
  }
//+------------------------------------------------------------------+
