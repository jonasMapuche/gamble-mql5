//+------------------------------------------------------------------+
//|                                                       Hammer.mqh |
//|             Copyright 2026, César Cardoso Silva & Stomach.com.br |
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
#include "../Target/StochasticStick.mqh"
#include "../Gauge/Stochastic.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class StochasticOscillator : StochasticStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      StochasticStick *stochasticStick[];

    public:
      StochasticOscillator(const int value,const string inpattern,const int ink,const int inloopk);
      ~StochasticOscillator();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const int ink,const int inloopk,const int inquantity);
      bool Low(const int value,const string intimenow,const bool save,const int ink,const int inloopk,const int inquantity);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
StochasticOscillator::StochasticOscillator(const int value,const string inpattern,const int ink,const int inloopk)
  {
//---
    int quantity=value+1;
//---
    ArrayResize(candlestick,quantity);
    for(int i=0; i<=value; i++) {
      candlestick[i]=new CandleStick();
      candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
//---
    ArrayResize(stochasticStick,quantity);
    Stochastic *stochastic;
    stochastic=new Stochastic(quantity,"STOCHASTIC");
    for(int i=0; i<quantity; i++) {
      double inpercentk=stochastic.PercentK(i,ink,inloopk);
      double inpercentd=stochastic.PercentD(i,ink);
      stochasticStick[i]=new StochasticStick();
      stochasticStick[i].Add(i,inpercentk,inpercentd);
    }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
StochasticOscillator::~StochasticOscillator()
  {
  }
//+------------------------------------------------------------------+
//| Write down                                                       |
//+------------------------------------------------------------------+
void StochasticOscillator::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify low                                                       |
//+------------------------------------------------------------------+
bool StochasticOscillator::Low(const int value,const string intimenow,const bool save,const int ink,const int inloopk,const int inquantity)
  {
//---  
    int quantityk=ink+inloopk;
    int value1=value-quantityk;
    int account_max=1+1;
//---
    if(value1<(inquantity-quantityk)) return false;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(overbought(stochasticStick[i].percentK,stochasticStick[i].percentd)) account[1]=TRUE; else account[1]=FALSE;
//---      
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
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
//| Verify high                                                      |
//+------------------------------------------------------------------+
bool StochasticOscillator::High(const int value,const string intimenow,const bool save,const int ink,const int inloopk,const int inquantity)
  {
//---  
    int quantityk=ink+inloopk;
    int value1=value-quantityk;
    int account_max=1+1;
//---
    if(value1<(inquantity-quantityk)) return false;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(oversold(stochasticStick[i].percentK,stochasticStick[i].percentd)) account[1]=TRUE; else account[1]=FALSE;
//---      
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
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
