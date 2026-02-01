//+------------------------------------------------------------------+
//|                                               HammerInverted.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "../CandleStick.mqh"
#include "../Golang.mqh"
#include "../SQlite.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class HammerInverted : public CandleStick
  {
    private:
      
    protected:
      CandleStick *candlestick[];   
  
    public:
      HammerInverted(const int value,const string inpattern);
      ~HammerInverted();
      bool Main(const int value,const string intimenow,const bool save,const double average);
      void Write(const int value);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
HammerInverted::HammerInverted(const int value,const string inpattern)
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
HammerInverted::~HammerInverted()
  {
  }
//+------------------------------------------------------------------+
//| Write hammer                                                     |
//+------------------------------------------------------------------+
void HammerInverted::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify hammer inverted                                           |
//+------------------------------------------------------------------+
bool HammerInverted::Main(const int value,const string intimenow,const bool save,const double average)
  {
//---
    double percent3=0.0003;
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int account_max=4+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0,inLow1=0;
    string inTime="",inPattern="",inSymbol="";
//---
    const double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value4; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE; else account[1]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE; 
      if(i==value4) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
//---
      if((account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---
        inHigh1=candlestick[value1].getHigh();
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
        inLow1=candlestick[value1].getLow();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=1+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if((hammerinvertedred(inHigh1,inOpen1,inClose1,inLow1,mean,percent3)) || (hammerinvertedgreen(inHigh1,inOpen1,inClose1,inLow1,mean,percent3))){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1005),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if (thrut[0]==TRUE) {
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
