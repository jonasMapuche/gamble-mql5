//+------------------------------------------------------------------+
//|                                                  Descriptive.mqh |
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
//| Class                                                           |
//+------------------------------------------------------------------+
class Descriptive : public CandleStick
  {
    private:
    
    protected:
      CandleStick *candlestick[];  

    public:
      Descriptive(const int value,const string inpattern);
      ~Descriptive();
      double MeanSize(const int quantity);
      double MeanBody(const int quantity);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Descriptive::Descriptive(const int value,const string inpattern)
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
Descriptive::~Descriptive()
  {
  }
//+------------------------------------------------------------------+
//| Mean size                                                        |
///+-----------------------------------------------------------------+
double Descriptive::MeanSize(const int quantity)
  {
//---
    const int value=quantity;
//---
    double size=0;
    for(int i=0;i<value;i++){
      size=size+(candlestick[i].getHigh()-candlestick[i].getLow());
    }
//---
    return size/value;
  }
//+------------------------------------------------------------------+
//| Mean body                                                        |
///+-----------------------------------------------------------------+
double Descriptive::MeanBody(const int quantity)
  {
//---
    const int value=quantity;
//---    
    double body=0;
    for(int i=0;i<value;i++){
      if(green(candlestick[i].getOpen(),candlestick[i].getClose())) 
        body=body+(candlestick[i].getClose()-candlestick[i].getOpen());
      else
        body=body+(candlestick[i].getOpen()-candlestick[i].getClose());
    };
//---
    return body/value;    
  }
//+------------------------------------------------------------------+
