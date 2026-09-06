//+------------------------------------------------------------------+
//|                                                 AdvancedLock.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
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
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class AdvancedLock : public CandleStick
  {
    private:
      double Mean();

    protected:
      CandleStick *candlestick[];   

    public:
      AdvancedLock(const int value,const string inpattern);
      ~AdvancedLock();
      void Write(const int value);
      bool Main(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
AdvancedLock::AdvancedLock(const int value,const string inpattern)
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
AdvancedLock::~AdvancedLock()
  {
  }
//+------------------------------------------------------------------+
//| Write advanced lock red (low)                                    |
//+------------------------------------------------------------------+
void AdvancedLock::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify advanced lock low                                         |
//+------------------------------------------------------------------+
bool AdvancedLock::Main(const int value,const string intimenow,const bool save,const double average)
  {
//---
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int value6=value+5;
    int account_max=6+1;
//---
    double inHigh1=0,inLow1=0;
    double inHigh2=0,inLow2=0;
    double inHigh3=0,inOpen3=0,inClose3=0,inLow3=0;
    string inTime="",inPattern="",inSymbol="";
//---
    const double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value6; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
      if(i==value4) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
      if(i==value5) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE; else account[5]=TRUE;
      if(i==value6) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[6]=TRUE; else account[6]=TRUE;
      if((account[6]==TRUE) && (account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---        
        inHigh1=candlestick[value1].getHigh();
        inLow1=candlestick[value1].getLow();
//---
        inHigh2=candlestick[value2].getHigh();
        inLow2=candlestick[value2].getLow();
//---
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
        inHigh3=candlestick[value3].getHigh();
        inLow3=candlestick[value3].getLow();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=5+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---        
        if(green(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2002));
          thrut[0]=TRUE;
        };
//---
        if(inHigh2>inHigh3){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2143));
          thrut[1]=TRUE;
        };
//---
        if(inLow2>inLow3){                      
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2173));
          thrut[2]=TRUE;
        };
//---
        if(inHigh1>inHigh2){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2142));
          thrut[3]=TRUE;
        };
//---
        if(inLow1>inLow2){                      
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2172));
          thrut[4]=TRUE;
        };
//---
        if((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE) && (thrut[4]==TRUE)){
          if(save) sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
          return true;
//---
        } else if(save) sqlite.SaveFault(intimenow,inPattern,inSymbol,inTime);
      }
    }
//---    
    return false;
  }
//+------------------------------------------------------------------+
  