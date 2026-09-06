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
      double Balance(const int quantity, const int start);
      double MME(const int quantity, const int period);
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
double Volume::Balance(const int quantity, const int start)
  {
//---
    int instart=quantity;
    int inend=start;
    int prior=instart;
    double cumulate=0;
//---
    for(int value=instart;value<inend;value--) {
//---
      if(value==quantity){
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
  }  
//+------------------------------------------------------------------+
//| Moving average exponential                                       |
///+-----------------------------------------------------------------+
double Volume::MME(const int quantity, const int period)
  {
//---
    int day=0;
    int average=quantity;
    int mean=period;
    int prior=0;
    ENUM_TIMEFRAMES time_enum=PERIOD_D1;
//---    
    MqlRates mrate[];    
    ArraySetAsSeries(mrate,true);      
    CopyRates(_Symbol,time_enum,day,average,mrate);
//---
    double factor=2.0/((double)mean+1.0);
//---
    double mmeprior=0;
    double cumulate=0;
    for(int value=average-1;value>=0;value--) {
//---
      if(value==quantity) {
        cumulate=candlestick[value].getVolume();
        continue;
      }
      if(candlestick[value].getClose()>candlestick[prior].getClose()) cumulate+=candlestick[value].getVolume();
      if(candlestick[value].getClose()<candlestick[prior].getClose()) cumulate-=candlestick[value].getVolume();
      //cumulate+=mrate[value].tick_volume;
//---
      prior--;
    }
    mmeprior=cumulate/quantity;    
//---    
    double mmecurrenty=mmeprior;
    double hive=0;
    for(int value=average-1;value>=0;value--)
    {
//---
      if(value==quantity) {
        hive=candlestick[value].getVolume();
        continue;
      }
      if(candlestick[value].getClose()>candlestick[prior].getClose()) hive+=candlestick[value].getVolume();
      if(candlestick[value].getClose()<candlestick[prior].getClose()) hive-=candlestick[value].getVolume();
//---
      mmecurrenty=mmeprior+(factor*(hive-mmeprior));
      mmeprior=mmecurrenty;
      prior--;
    }
//---
    return mmecurrenty;
  }
//+------------------------------------------------------------------+
