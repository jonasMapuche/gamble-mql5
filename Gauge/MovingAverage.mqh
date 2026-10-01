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
      double MME(const int inquantity, const int inposition,const int inmms);
      double MMS(const int inquantity, const int inposition,const int inmms);   
      double MACD(const int inquantity, const int inposition,const int inmme);
      double BandUp(const int inquantity,const int inposition,const int indeviation,const int inmms);
      double BandDown(const int inquantity,const int inposition,const int indeviation,const int inmms);
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
//---
    
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
MovingAverage::~MovingAverage()
  {
  }
//+------------------------------------------------------------------+
//| Moving average sample                                            |
///+-----------------------------------------------------------------+
double MovingAverage::MMS(const int inquantity, const int inposition,const int inmms)
  {
//---
    int start=inquantity;
    int end=inposition;
    int mms=inmms;
    double cumulate=0;
//---    
    if((start-end)<mms) return cumulate;
    if((start-end)>mms) start=end+mms;
//---
    for(int value=start;value>=end;value--) {
      cumulate+=candlestick[value].getClose();
    }
//---
    double mean=cumulate/mms;    
//---
    return mean;
//---    

  }
//+------------------------------------------------------------------+
//| Moving average exponential                                       |
///+-----------------------------------------------------------------+
double MovingAverage::MME(const int inquantity, const int inposition,const int inmme)
  {
//---
    int start=inquantity;
    int position=inposition;
    int end=position;
    int mme=inmme;
    double cumulate=0;
//---    
    if((start-end)<mme) return cumulate;
    if((start-end)>mme) end=start-mme;
//---
    cumulate=MMS(inquantity,inposition,inmme);        
    double first_mme=cumulate/mme;    
//---
    double factor=2.0/((double)mme+1.0);
//---
    double mme_currenty=first_mme;
    double mme_prior=0;
    cumulate=0;
//---
    start=start+mme;
    end=position;
//---
    for(int value=start;value>=end;value--)
    {
      mme_currenty=(candlestick[value].getClose()*factor)+(mme_prior*(1.0-factor));
      mme_prior=mme_currenty;
    }
//---
    return mme_currenty;
//---

  }
//+------------------------------------------------------------------+
//| macd                                                             |
///+-----------------------------------------------------------------+
double MovingAverage::MACD(const int inquantity, const int inposition,const int inmme)
  {
//---
    int quantity=inquantity;
    int position=inposition;
    double cumulate=0;
//---
    int mme26_value=26;
    int mme12_value=12;
    int mme9_value=inmme;
//---
    double mme26_cumulate=MME(quantity,position,mme26_value);
    double mme12_cumulate=MME(quantity,position,mme12_value);
    double macd_cumulate=mme26_cumulate/mme12_cumulate;
//---
    return macd_cumulate;
//---    

  }   
//+------------------------------------------------------------------+
//| Band bollinger up                                                |
///+-----------------------------------------------------------------+
double MovingAverage::BandUp(const int inquantity,const int inposition,const int indeviation,const int inmms)
  {
//---
    int start=inquantity;
    int position=inposition;
    int deviation=indeviation;    
    int end=position;
    int mms=inmms;
    double cumulate=0;
//---    
    if((start-end)<mms) return cumulate;
    if((start-end)>mms) start=end+mms;
//---
    double mean=MMS(inquantity,inposition,inmms);    
//---
    for(int value=start;value>=end;value--) {
      double diff=candlestick[value].getClose()-mms;
      cumulate+=diff*diff;
    }
    double variance=cumulate/mms;
    double ratio=MathSqrt(variance);
    double band=mean+(ratio*deviation);
//---
    return band;
//---

  }
//+------------------------------------------------------------------+
//| Band bollinger down                                              |
///+-----------------------------------------------------------------+
double MovingAverage::BandDown(const int inquantity,const int inposition,const int indeviation,const int inmms)
  {
//---
    int start=inquantity;
    int position=inposition;
    int deviation=indeviation;    
    int end=position;
    int mms=inmms;
    double cumulate=0;
//---    
    if((start-end)<mms) return cumulate;
    if((start-end)>mms) start=end+mms;
//---
    double mean=MMS(inquantity,inposition,inmms);    
//---
    for(int value=start;value>=end;value--) {
      double diff=candlestick[value].getClose()-mms;
      cumulate+=diff*diff;
    }
    double variance=cumulate/mms;
    double ratio=MathSqrt(variance);
    double band=mean-(ratio*deviation);
//---
    return band;
//---

  }
//+------------------------------------------------------------------+
