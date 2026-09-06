//+------------------------------------------------------------------+
//|                                                     DojiBase.mqh |
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
//| Class                                                            |
//+------------------------------------------------------------------+
class Doji : public CandleStick
  {
    private:

    protected:
      CandleStick *candlestick[];  
    
    public:
      Doji(const int value,const string inpattern);
      ~Doji();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
Doji::Doji(const int value,const string inpattern)
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
Doji::~Doji()
  {
  }
//+------------------------------------------------------------------+
//| Write doji base                                                  |
//+------------------------------------------------------------------+
void Doji::Write(const int value)
  {
    for(int i=1; i<=value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i),candlestick[i].getTime(),DoubleToString(candlestick[i].getVolume()),candlestick[i].getPattern(),candlestick[i].getSymbol());
  }
//+------------------------------------------------------------------+
//| Verify doji green (high)                                         |
///+-----------------------------------------------------------------+
bool Doji::High(const int value,const string intimenow,const bool save)
  {
//---
    double percent3=0.0003;
    int value1=value;
    int account_max=1+1;
    double inOpen1=0,inClose1=0;
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    if(green(candlestick[value1].getOpen(),candlestick[value1].getClose())) account[1]=TRUE;
//--- 
    if(account[1]==TRUE){
//---
      inOpen1=candlestick[value1].getOpen();
      inClose1=candlestick[value1].getClose();
//---
      inTime=candlestick[value1].getTime();
      inPattern=candlestick[value1].getPattern();
      inSymbol=candlestick[value1].getSymbol();
//---
      if(dojigreen(inOpen1,inClose1,percent3)){
//---
        if(save){
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
//| Verify doji red (low)                                            |
///+-----------------------------------------------------------------+
bool Doji::Low(const int value,const string intimenow,const bool save)
  {
//---
    double percent3=0.0003;
    int value1=value;
    int account_max=1+1;
    double inOpen1=0,inClose1=0;
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    if(red(candlestick[value1].getOpen(),candlestick[value1].getClose())) account[1]=TRUE;
//---
    if(account[1]==TRUE){
//---    
      inOpen1=candlestick[value1].getOpen();
      inClose1=candlestick[value1].getClose();
//---
      inTime=candlestick[value1].getTime();
      inPattern=candlestick[value1].getPattern();
      inSymbol=candlestick[value1].getSymbol();
//---
      if(dojired(inOpen1,inClose1,percent3)){
//---
        if(save){
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
