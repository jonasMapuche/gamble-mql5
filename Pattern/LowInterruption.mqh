//+------------------------------------------------------------------+
//|                                              LowInterruption.mqh |
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
class LowInterruption : public CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];   

    public:
      LowInterruption(const int value,const string inpattern);
      ~LowInterruption();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
LowInterruption::LowInterruption(const int value,const string inpattern)
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
LowInterruption::~LowInterruption()
  {
  }
//+------------------------------------------------------------------+
//| Write low interruption                                           |
//+------------------------------------------------------------------+
void LowInterruption::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify low interruption (third candle green)                     |
//+------------------------------------------------------------------+
bool LowInterruption::High(const int value,const string intimenow,const bool save,const double average)
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
    double inOpen3=0;
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
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
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
        if(
            (greenlong(inHigh5,inOpen5,inClose5,inLow5,mean))
            &&
            (inLow4>inClose5)
            &&
            (inOpen3>inOpen4)
            &&
            (inOpen2>inOpen3)
            &&
            (
              (inOpen1>inOpen2)
              &&
              (inClose1<inOpen2)
              &&
              (inLow1>inClose5)
            )
          ){
//--- 
          if(save){
            SQLite *sqlite;
            sqlite=new SQLite();
            sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
          } 
          return true;
        }else{
//---
          if(save){
            SQLite *sqlite;
            sqlite=new SQLite();
            sqlite.SaveFault(intimenow,inPattern,inSymbol,inTime);
          }
          return false;
        }
      }
    }
//---    
    return false;
  }
//+------------------------------------------------------------------+
//| Verify low interruption (third candle red)                       |
//+------------------------------------------------------------------+
bool LowInterruption::Low(const int value,const string intimenow,const bool save,const double average)
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
    double inClose3=0;
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
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE;
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
        if(
            (greenlong(inHigh5,inOpen5,inClose5,inLow5,mean))
            &&
            (inLow4>inClose5)
            &&
            (inClose3>inOpen4)
            &&
            (inOpen2>inClose3)
            &&
            (
              (inOpen1>inOpen2)
              &&
              (inClose1<inOpen2)
              &&
              (inLow1>inClose5)
            )
          ){
//--- 
          if(save){
            SQLite *sqlite;
            sqlite=new SQLite();
            sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
          } 
          return true;
        }else{
//---
          if(save){
            SQLite *sqlite;
            sqlite=new SQLite();
            sqlite.SaveFault(intimenow,inPattern,inSymbol,inTime);
          }
          return false;
        }
      }
    }
//---    
    return false;
}
//+------------------------------------------------------------------+
