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
//| Class                                                            |
//+------------------------------------------------------------------+
class MovingAverage
  {
    private:

    protected:
      CandleStick *candlestick[];  
    
    public:
      MovingAverage(const int value,const string inpattern);
      ~MovingAverage();
      double MME(const int quantity);
      double MMS(const int inquantity,const int inposition);   
      double BandUp(const int inquantity,const int inposition,const int indeviation);
      double BandDown(const int inquantity,const int inposition,const int indeviation);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
MovingAverage::MovingAverage(const int value,const string inpattern)
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
MovingAverage::~MovingAverage()
  {
  }
//+------------------------------------------------------------------+
//| Moving average exponential                                       |
///+-----------------------------------------------------------------+
double MovingAverage::MME(const int quantity)
  {
//---
    int day=0;
    int average=quantity;
    ENUM_TIMEFRAMES time_enum=PERIOD_D1;
//---    
    MqlRates mrate[];    
    ArraySetAsSeries(mrate,true);      
    CopyRates(_Symbol,time_enum,day,average,mrate);
//---
    double factor=2.0/((double)average+1.0);
//---
    double mmeprior=0;
    double cumulate=0;
    for(int value=average-1;value>=0;value--)
    {
      cumulate+=mrate[value].close;
    }
    mmeprior=cumulate/quantity;    
//---    
    double mmecurrenty=mmeprior;
    for(int value=quantity-1;value>=0;value--)
    {
      mmecurrenty=(mrate[value].close*factor)+(mmeprior*(1.0-factor));
      mmeprior=mmecurrenty;
    }    
//---
    return mmecurrenty;
  } 
//+------------------------------------------------------------------+
//| Moving average sample                                            |
///+-----------------------------------------------------------------+
double MovingAverage::MMS(const int inquantity,const int inposition)
  {
//---
    int index=inposition;
    int quantity=inquantity+inposition;
    int average=inquantity;
    double cumulate=0;
//---    
    for(int value=index;value<quantity;value++)
    {
      cumulate+=candlestick[value].getClose();
    }
    double mms=cumulate/average;    
//---
    return mms;
  }
//+------------------------------------------------------------------+
//| Band bollinger up                                                |
///+-----------------------------------------------------------------+
double MovingAverage::BandUp(const int inquantity,const int inposition,const int indeviation)
  {
//---
    double mms=MMS(inquantity,inposition);    
//---
    int index=inposition;
    int quantity=inquantity+inposition;
    int average=inquantity;
    int ratio=indeviation;
//---    
    double square=0;
    for(int value=index;value<quantity;value++)
    {
      double diff=candlestick[value].getClose()-mms;
      square+=diff*diff;
    }
    double variance=square/average;
    double deviation=MathSqrt(variance);
    double band=mms+(deviation*ratio);
//---
    return band;
  }
//+------------------------------------------------------------------+
//| Band bollinger down                                              |
///+-----------------------------------------------------------------+
double MovingAverage::BandDown(const int inquantity,const int inposition,const int indeviation)
  {
//---
    double mms=MMS(inquantity,inposition);    
//---
    int index=inposition;
    int quantity=inquantity+inposition;
    int average=inquantity;
    int ratio=indeviation;
//---
    double square=0;
    for(int value=index;value<quantity;value++)
    {
      double diff=candlestick[value].getClose()-mms;
      square+=diff*diff;
    }
    double variance=square/average;
    double deviation=MathSqrt(variance);
    double band=mms-(deviation*ratio);
//---
    return band;
  }
//+------------------------------------------------------------------+
