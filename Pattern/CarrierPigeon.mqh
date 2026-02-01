//+------------------------------------------------------------------+
//|                                                CarrierPigeon.mqh |
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
class CarrierPigeon : public CandleStick
  {
    private:
      double Mean();

    protected:
      CandleStick *candlestick[];   

    public:
      CarrierPigeon(const int value,const string inpattern);
      ~CarrierPigeon();
      void Write(const int value);
      bool Main(const int value,const string intimenow,const bool save,const double average);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
CarrierPigeon::CarrierPigeon(const int value,const string inpattern)
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
CarrierPigeon::~CarrierPigeon()
  {
  }
//+------------------------------------------------------------------+
//| Write low carrier pigeon                                         |
//+------------------------------------------------------------------+
void CarrierPigeon::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify carrier pigeon high                                       |
//+------------------------------------------------------------------+
bool CarrierPigeon::Main(const int value,const string intimenow,const bool save,const double average)
  {
//---
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int value4=value+3;
    int account_max=4+1;
//---
    double inHigh1=0,inLow1=0;
    double inOpen2=0,inClose2=0;
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
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=TRUE;
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=TRUE;
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=TRUE; else account[3]=TRUE;
      if(i==value4) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[4]=TRUE; else account[4]=TRUE;
//---
      if((account[4]==TRUE) && (account[3]==TRUE) && (account[2]==TRUE) && (account[1]==TRUE)) {
//---
        inHigh1=candlestick[value1].getHigh();
        inLow1=candlestick[value1].getLow();
//--
        inOpen2=candlestick[value2].getOpen();
        inClose2=candlestick[value2].getClose();
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        SQLite *sqlite;
        sqlite=new SQLite();
//---
        ENUM_SINAL thrut[];
        int max=2+1;
        ArrayResize(thrut,max);
        for(int i=0; i<max; i++) thrut[i]=FALSE;
//---
        if(longred(inOpen2,inClose2,mean)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1003),GetRuleCandle(2001));
          thrut[0]=TRUE;
        };
//---
        if(insidebodyred(inOpen2,inClose2,inHigh1,inLow1)){
          if(save) sqlite.SaveRule(intimenow,inPattern,inSymbol,inTime,GetTypeCandle(1001),GetRuleCandle(2202));
          thrut[1]=TRUE;
        };
//---
        if ((thrut[0]==TRUE) && (thrut[1]==TRUE)){
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
