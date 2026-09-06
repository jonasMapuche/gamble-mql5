//+------------------------------------------------------------------+
//|                                                AbandonedBaby.mqh |
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
class AbandonedBaby : CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];   

    public:
      AbandonedBaby(const int value,const string inpattern);
      ~AbandonedBaby();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
AbandonedBaby::AbandonedBaby(const int value,const string inpattern)
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
AbandonedBaby::~AbandonedBaby()
  {
  }
//+------------------------------------------------------------------+
//| Write abandoned baby high and low                                |
//+------------------------------------------------------------------+
void AbandonedBaby::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify abandoned baby high                                       |
//+------------------------------------------------------------------+
bool AbandonedBaby::High(const int value,const string intimenow,const bool save,const double average)
  {
//---
    double percent3=0.0003;
    double percent9=0.0009;
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int value6=value+5;
    int account_max=6+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0,inLow1=0;
    double inHigh2=0,inOpen2=0,inClose2=0,inLow2=0;
    double inHigh3=0,inOpen3=0,inClose3=0,inLow3=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value6; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
      if(i==value4) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
      if(i==value5) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE; else account[5]=TRUE;
      if(i==value6) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[6]=TRUE; else account[6]=TRUE;
      if((account[6]==TRUE) && (account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
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
        inHigh3=candlestick[value3].getHigh();
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
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
        if(longred(inOpen3,inClose3,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if(marubozured(inHigh3,inOpen3,inClose3,inLow3,percent9)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2001));
          thrut[1]=TRUE;
        };
//---
        if(((dojigreen(inOpen2,inClose2,percent3)) || (dojired(inOpen2,inClose2,percent3))) && (inHigh2<inLow3)) {
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1007),GetRuleCandle(2263));
          thrut[2]=TRUE;
        };
//---
        if((longgreen(inOpen1,inClose1,mean)) && (inLow1>inHigh2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2272));
          thrut[3]=TRUE;
        };
//---
        if((marubozugreen(inHigh1,inOpen1,inClose1,inLow1,percent9)) && (inLow1>inHigh2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2272));
          thrut[4]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE) && (thrut[4]==TRUE)) {
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
//| Verify abandoned baby low                                        |
//+------------------------------------------------------------------+
bool AbandonedBaby::Low(const int value,const string intimenow,const bool save,const double average)
  {
//---
    double percent3=0.0003;
    double percent9=0.0009;
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int value6=value+5;
    int account_max=6+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0,inLow1=0;
    double inHigh2=0,inOpen2=0,inClose2=0,inLow2=0;
    double inHigh3=0,inOpen3=0,inClose3=0,inLow3=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value6; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
      if(i==value4) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
      if(i==value5) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE; else account[5]=TRUE;
      if(i==value6) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[6]=TRUE; else account[6]=TRUE;
      if((account[6]==TRUE) && (account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
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
        inHigh3=candlestick[value3].getHigh();
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
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
        if(longgreen(inOpen3,inClose3,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2002));
          thrut[0]=TRUE;
        };
//---
        if(marubozugreen(inHigh3,inOpen3,inClose3,inLow3,percent9)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2002));
          thrut[1]=TRUE;
        };
//---
        if(((dojigreen(inOpen2,inClose2,percent3)) || (dojired(inOpen2,inClose2,percent3))) && (inLow2>inHigh3)) {
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1007),GetRuleCandle(2273));
          thrut[2]=TRUE;
        };
//---
        if((longred(inOpen1,inClose1,mean)) && (inHigh1<inLow2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2262));
          thrut[3]=TRUE;
        };
//---
        if((marubozured(inHigh1,inOpen1,inClose1,inLow1,percent9)) && (inHigh1<inLow2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1006),GetRuleCandle(2262));
          thrut[4]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE) && (thrut[4]==TRUE)) {
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
