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
class Volume
  {
    private:

    protected:
      CandleStick *candlestick[];  
    
    public:
      Volume(const int value,const string inpattern);
      ~Volume();
      double Balance(const int inquantity, const int inposition);
      double MME(const int inquantity, const int inposition,const int inmme);
      double MMS(const int inquantity, const int inposition,const int inmms);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Volume::Volume(const int value,const string inpattern)
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
Volume::~Volume()
  {
  }
//+------------------------------------------------------------------+
//| Volume Balance                                                   |
///+-----------------------------------------------------------------+
double Volume::Balance(const int inquantity, const int inposition)
  {
//---
    int start=inquantity;
    int end=inposition;
    int prior=start;
    double cumulate=0;
//---
    for(int value=start;value>=end;value--) {
//---
      if(value==start){
        cumulate=candlestick[value].getVolume();
        continue;
      }
//---      
      if(candlestick[value].getClose()>candlestick[prior].getClose()) cumulate+=candlestick[value].getVolume();
      if(candlestick[value].getClose()<candlestick[prior].getClose()) cumulate-=candlestick[value].getVolume();
//---
      prior--;      
    }
//---
    return cumulate;
//---

  }  
//+------------------------------------------------------------------+
//| Moving average sample                                            |
///+-----------------------------------------------------------------+
double Volume::MMS(const int inquantity, const int inposition,const int inmms)
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
      cumulate+=candlestick[value].getVolume();
    }
//---
    double volume=cumulate/mms;    
//---
    return volume;
//---    

}  
//+------------------------------------------------------------------+
//| Moving average exponential                                       |
///+-----------------------------------------------------------------+
double Volume::MME(const int inquantity, const int inposition,const int inmme)
  {
//---
    int start=inquantity;
    int position=inposition;
    int end=position;
    int prior=start;
    int mme=inmme;
    double cumulate=0;
//---    
    if((start-end)<mme) return cumulate;
    if((start-end)>mme) end=start-mme;
//--
    for(int value=start;value>=end;value--) {
//---
      if(value==start) {
        cumulate=candlestick[value].getVolume();
        continue;
      }
      if(candlestick[value].getClose()>candlestick[prior].getClose()) cumulate+=candlestick[value].getVolume();
      if(candlestick[value].getClose()<candlestick[prior].getClose()) cumulate-=candlestick[value].getVolume();
//---
      prior--;
    }
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
//---
      if(value==start) {
        cumulate=mme_currenty;
        continue;
      }
      if(candlestick[value].getClose()>candlestick[prior].getClose()) cumulate+=candlestick[value].getVolume();
      if(candlestick[value].getClose()<candlestick[prior].getClose()) cumulate-=candlestick[value].getVolume();
//---
      mme_currenty=mme_prior+(factor*(cumulate-mme_prior));
      mme_prior=mme_currenty;
      prior--;
    }
//---
    return mme_currenty;
//---

  }
//+------------------------------------------------------------------+
