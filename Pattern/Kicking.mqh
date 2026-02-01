//+------------------------------------------------------------------+
//|                                                  KickingHigh.mqh |
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
class Kicking : public CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];   

    public:
      Kicking(const int value,const string inpattern);
      ~Kicking();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
Kicking::Kicking(const int value,const string inpattern)
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
Kicking::~Kicking()
  {
  }
//+------------------------------------------------------------------+
//| Write kicking high and low                                       |
//+------------------------------------------------------------------+
void Kicking::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify kicking high                                              |
//+------------------------------------------------------------------+
bool Kicking::High(const int value,const string intimenow,const bool save,const double average)
  {
//---
    double percent3=0.0003;
    double percent9=0.0009;
    int value1=value;
    int value2=value+1;
    int account_max=2+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0,inLow1=0;
    double inHigh2=0,inOpen2=0,inClose2=0,inLow2=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value2; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if((account[2]==TRUE) && (account[1]==TRUE)) {
//---        
        inHigh1=candlestick[value1].getHigh();
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
        inLow1=candlestick[value1].getLow();
//---
        inHigh2=candlestick[value2].getHigh();
        inOpen2=candlestick[value2].getOpen();
        inClose2=candlestick[value2].getClose();
        inLow2=candlestick[value2].getLow();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=4+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(longred(inOpen2,inClose2,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2002));
          thrut[0]=TRUE;
        };
//---
        if(marubozured(inHigh2,inOpen2,inClose2,inLow2,percent9)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2002));
          thrut[1]=TRUE;
        };
//---
        if((longgreen(inOpen1,inClose1,mean)) && (inOpen1>inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2052));
          thrut[2]=TRUE;
        };
//---
        if((marubozugreen(inHigh1,inOpen1,inClose1,inLow1,percent9)) && (inOpen1>inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2052));
          thrut[3]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE)) {
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
//| Verify kicking low                                               |
//+------------------------------------------------------------------+
bool Kicking::Low(const int value,const string intimenow,const bool save,const double average)
  {
//---
    double percent3=0.0003;
    double percent9=0.0009;
    int value1=value;
    int value2=value+1;
    int account_max=2+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0,inLow1=0;
    double inHigh2=0,inOpen2=0,inClose2=0,inLow2=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value2; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if((account[2]==TRUE) && (account[1]==TRUE)) {
//---        
        inHigh1=candlestick[value1].getHigh();
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
        inLow1=candlestick[value1].getLow();
//---
        inHigh2=candlestick[value2].getHigh();
        inOpen2=candlestick[value2].getOpen();
        inClose2=candlestick[value2].getClose();
        inLow2=candlestick[value2].getLow();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=4+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(longgreen(inOpen2,inClose2,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if(marubozugreen(inHigh2,inOpen2,inClose2,inLow2,percent9)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2001));
          thrut[1]=TRUE;
        };
//---
        if((longred(inOpen1,inClose1,mean)) && (inOpen1<inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2022));
          thrut[2]=TRUE;
        };
//---
        if((marubozured(inHigh1,inOpen1,inClose1,inLow1,percent9)) && (inOpen1<inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2022));
          thrut[3]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE)) {
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
