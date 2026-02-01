//+------------------------------------------------------------------+
//|                                                 Interruption.mqh |
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
class Interruption : public CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];   

    public:
      Interruption(const int value,const string inpattern);
      ~Interruption();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
Interruption::Interruption(const int value,const string inpattern)
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
Interruption::~Interruption()
  {
  }
//+------------------------------------------------------------------+
//| Write interruption                                               |
//+------------------------------------------------------------------+
void Interruption::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify interruption high                                         |
//+------------------------------------------------------------------+
bool Interruption::High(const int value,const string intimenow,const bool save,const double average)
  {
//---
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int value6=value+5;
    int value7=value+6;
    int account_max=7+1;
//---
    double inHigh1=0,inOpen1=0,inClose1=0;
    double inOpen2=0;
    double inOpen3=0,inClose3=0;
    double inHigh4=0,inOpen4=0;
    double inOpen5=0,inClose5=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value7; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE; else account[3]=TRUE;
      if(i==value4) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE;
      if(i==value5) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE;
      if(i==value6) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[6]=TRUE; else account[6]=TRUE;
      if(i==value7) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[7]=TRUE; else account[7]=TRUE;
      if((account[7]==TRUE) && (account[6]==TRUE) && (account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---        
        inHigh1=candlestick[value1].getHigh();
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
//---
        inOpen2=candlestick[value2].getOpen();
//---
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
//---
        inHigh4=candlestick[value4].getHigh();
        inOpen4=candlestick[value4].getOpen();
//---
        inOpen5=candlestick[value5].getOpen();
        inClose5=candlestick[value5].getClose();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=7+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(longred(inOpen5,inClose5,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if(inHigh4<inClose5){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2295));
          thrut[1]=TRUE;
        };
//---
        if(inOpen3<inOpen4){                                    
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2024));
          thrut[2]=TRUE;
        };
//---
        if((inOpen2<inOpen3) && red(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2023));
          thrut[3]=TRUE;
        };
//---          
        if((inOpen2<inClose3) && green(inOpen3,inClose3)){                                    
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2153));
          thrut[3]=TRUE;
        };
//---
        if((longgreen(inOpen1,inClose1,mean)) && (inOpen1<inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2022));
          thrut[4]=TRUE;
        };
//---
        if((longgreen(inOpen1,inClose1,mean)) && (inClose1>inOpen4)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2084));
          thrut[5]=TRUE;
        };
//---
        if((longgreen(inOpen1,inClose1,mean)) && (inHigh1<inClose5)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2295));
          thrut[6]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE) && (thrut[4]==TRUE) && (thrut[5]==TRUE) && (thrut[6]==TRUE)) {
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
//| Verify interruption low                                          |
//+------------------------------------------------------------------+
bool Interruption::Low(const int value,const string intimenow,const bool save,const double average)
  {
//---
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int value6=value+5;
    int value7=value+6;
    int account_max=7+1;
//---
    double inOpen1=0,inClose1=0,inLow1=0;
    double inOpen2=0;
    double inOpen3=0,inClose3=0;
    double inOpen4=0,inLow4=0;
    double inHigh5=0,inOpen5=0,inClose5=0,inLow5=0;
    string inTime="",inPattern="",inSymbol="";
//---
    double mean=average;
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value7; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE; else account[3]=TRUE;
      if(i==value4) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE;
      if(i==value5) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE;
      if(i==value6) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[6]=TRUE; else account[6]=TRUE;
      if(i==value7) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[7]=TRUE; else account[7]=TRUE;
      if((account[7]==TRUE) && (account[6]==TRUE) && (account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---        
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
        inLow1=candlestick[value1].getLow();
//---
        inOpen2=candlestick[value2].getOpen();
//---
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
//---
        inOpen4=candlestick[value4].getOpen();
        inLow4=candlestick[value4].getLow();
//---
        inHigh5=candlestick[value5].getHigh();
        inOpen5=candlestick[value5].getOpen();
        inClose5=candlestick[value5].getClose();
        inLow5=candlestick[value5].getLow();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=7+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(longgreen(inOpen5,inClose5,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2002));
          thrut[0]=TRUE;
        };
//---
        if(inLow4>inClose5){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2285));
          thrut[1]=TRUE;
        };
//---
        if(inOpen3>inOpen4){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2054));
          thrut[2]=TRUE;
        };
//---
        if((inOpen2>inOpen3) && green(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2053));
          thrut[3]=TRUE;
        };
//---
        if((inOpen2>inClose3) && red(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2093));
          thrut[3]=TRUE;
        };
//---
        if((longred(inOpen1,inClose1,mean)) && (inOpen1>inOpen2)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2052));
          thrut[4]=TRUE;
        };
//---
        if((longred(inOpen1,inClose1,mean)) && (inClose1<inOpen4)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2114));
          thrut[5]=TRUE;
        };
//---
        if((longred(inOpen1,inClose1,mean)) && (inLow1>inClose5)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2285));
          thrut[6]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE) && (thrut[2]==TRUE) && (thrut[3]==TRUE) && (thrut[4]==TRUE) && (thrut[5]==TRUE) && (thrut[6]==TRUE)) {
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
