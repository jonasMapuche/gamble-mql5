//+------------------------------------------------------------------+
//|                                                    Fibonacci.mqh |
//|                   Copyright 2026, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026, Jonas Mapuche & Stomach.com.br"
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
class Fibonacci : public CandleStick
  {
    private:
      double Mean();
    
    protected:
      CandleStick *candlestick[];   

    public:
      Fibonacci(const int value,const string inpattern);
      ~Fibonacci();
      void Write(const int value);
      bool High(const int value,const string intimenow,const bool save,const double average);
      bool Low(const int value,const string intimenow,const bool save,const double average);
};
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
Fibonacci::Fibonacci(const int value,const string inpattern)
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
Fibonacci::~Fibonacci()
  {
  }
//+------------------------------------------------------------------+
//| Write fibonacci                                                  |
//+------------------------------------------------------------------+
void Fibonacci::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
  }
//+------------------------------------------------------------------+
//| Verify fibonacci high                                            |
//+------------------------------------------------------------------+
bool Fibonacci::High(const int value,const string intimenow,const bool save,const double average)
  {
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify fibonacci low                                             |
//+------------------------------------------------------------------+
bool Fibonacci::Low(const int value,const string intimenow,const bool save,const double average)
  {
//---
    return false;
  }
//+------------------------------------------------------------------+
