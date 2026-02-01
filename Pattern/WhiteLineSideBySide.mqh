//+------------------------------------------------------------------+
//|                                         WhiteLinesSideBySide.mqh |
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
class WhiteLineSideBySide : public CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      
    public:
      WhiteLineSideBySide(const int value,const string inpattern);
      ~WhiteLineSideBySide();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
WhiteLineSideBySide::WhiteLineSideBySide(const int value,const string inpattern)
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
WhiteLineSideBySide::~WhiteLineSideBySide()
  {
  }
//+------------------------------------------------------------------+
//| Write white line side by side                                    |
//+------------------------------------------------------------------+
void WhiteLineSideBySide::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify white line side by side high                              |
//+------------------------------------------------------------------+
bool WhiteLineSideBySide::High(const int value,const string intimenow,const bool save)
  {
//---
    double percent100=0.01;
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int account_max=5+1;
//---
    double inLow1=0,inOpen1=0,inClose1=0;
    double inLow2=0,inOpen2=0,inClose2=0;
    double inHigh3=0,inOpen3=0,inClose3=0;
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value5; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
      if(i==value4) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
      if(i==value5) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE; else account[5]=TRUE;
      if((account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---   
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
        inLow1=candlestick[value1].getLow();
//---
        inOpen2=candlestick[value2].getOpen();
        inClose2=candlestick[value2].getClose();
        inLow2=candlestick[value2].getLow();
//---
        inHigh3=candlestick[value3].getHigh();
        inOpen3=candlestick[value3].getOpen();
        inClose3=candlestick[value3].getClose();
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
        if(green(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2002));
          thrut[0]=TRUE;
        };
//---
        if(inLow2>inHigh3){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2183));
          thrut[1]=TRUE;
        };
//---
        if(inLow1>inHigh3){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2183));
          thrut[2]=TRUE;
        };
//---
        if(equalopengreen(inOpen2,inClose2,inOpen1,inClose1,percent100)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2032));
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
//| Verify white line side by side low                               |
//+------------------------------------------------------------------+
bool WhiteLineSideBySide::Low(const int value,const string intimenow,const bool save)
  {
//---
    double percent100=0.01;
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int value5=value+4;
    int account_max=5+1;
//---
    double inOpen1=0,inClose1=0;
    double inOpen2=0,inClose2=0;
    double inOpen3=0,inClose3=0,inLow3=0;
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value5; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
      if(i==value4) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
      if(i==value5) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[5]=TRUE; else account[5]=TRUE;
      if((account[5]==TRUE) && (account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---   
        inOpen1=candlestick[value1].getOpen();
        inClose1=candlestick[value1].getClose();
//---
        inOpen2=candlestick[value2].getOpen();
        inClose2=candlestick[value2].getClose();
//---
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
        int max=4+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(red(inOpen3,inClose3)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if(inClose2<inLow3){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2303));
          thrut[1]=TRUE;
        };
//---        
        if(inClose1<inLow3){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2303));
          thrut[2]=TRUE;
        };
//---
        if(equalopengreen(inOpen2,inClose2,inOpen1,inClose1,percent100)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2032));
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


