//+------------------------------------------------------------------+
//|                                                  Descriptive.mqh |
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
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                           |
//+------------------------------------------------------------------+
class RelativeStrength
  {
    private:
      double Variance(const double incurrency,const double inprior);

    protected:
      CandleStick *candlestick[];  

    public:
      RelativeStrength(const int value,const string inpattern);
      ~RelativeStrength();
      double StrengthIndex(const int quantity, const int mms);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
RelativeStrength::RelativeStrength(const int value,const string inpattern)
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
RelativeStrength::~RelativeStrength()
  {
  }
//+------------------------------------------------------------------+
//| Calc variance                                        |
//+------------------------------------------------------------------+
double RelativeStrength::Variance(const double incurrency,const double inprior)
  {
//---
    double invariance=incurrency-inprior;
    invariance=incurrency-inprior;
//---
    return invariance;
  }
//+------------------------------------------------------------------+
//| Relative strength                                                |
///+-----------------------------------------------------------------+
double RelativeStrength::StrengthIndex(const int quantity, const int mms)
  {
//---
    int quantitymms=quantity+mms;  
    double cumulatepositive=0,cumulatenegative=0;
//---
    for(int value=quantitymms+1;value>=mms;value--) {
      double invariance=Variance(candlestick[value].getClose(),candlestick[value+1].getClose());
      if(invariance>0) cumulatepositive+=invariance;
      if(invariance<0) cumulatenegative+=invariance;
    }  
//---
    double mmspositive=cumulatepositive/mms;
    double mmsnegative=cumulatenegative/mms;
//---
    double averagepositive=0,averagenegative=0;
    double factor=mms-1;
    double variancepositive=0,variancenegative=0;
    double relative=0;
//---
    if(quantity<mms) return relative;    
//---
    for(int value=quantity;value>=0;value--) {
//---
      if(value==quantity) {
        averagepositive=mmspositive;
        averagepositive=mmsnegative;
      } else {
//---
        double invariance=Variance(candlestick[value].getClose(),candlestick[value+1].getClose());
        if(invariance>0) variancepositive=invariance;
        if(invariance<0) variancenegative=invariance;
//---
        averagepositive=((averagepositive*factor)+variancepositive)/mms;
        averagenegative=((averagenegative*factor)+variancenegative)/mms;
      }
      double strength=averagepositive/averagenegative;
      relative=100-(100/(1+strength));
    }
//---
    return relative;
  }  
//+------------------------------------------------------------------+
