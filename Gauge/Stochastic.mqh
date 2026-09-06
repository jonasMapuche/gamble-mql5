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
class Stochastic
  {
    private:

    protected:
      CandleStick *candlestick[];  

    public:
      Stochastic(const int value,const string inpattern);
      ~Stochastic();
      double PercentK(const int quantity, const int k,const int loopk);
      double PercentD(const int quantity, const int k);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Stochastic::Stochastic(const int value,const string inpattern)
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
Stochastic::~Stochastic()
  {
  }
//+------------------------------------------------------------------+
//| Percent K                                                        |
///+-----------------------------------------------------------------+
double Stochastic::PercentK(const int quantity,const int k,const int loopk)
  {
//---
    int inloopk=loopk;
    int ink=k;
    int inquantity=quantity;
    double cumulateaverage=0;
    double cumulatek=0;
//---
    int inlimit=inloopk+k;
    if(quantity<inlimit) return cumulateaverage;
//---    
    for(int value2=0;value2<inloopk;value2++) {
//---
      int inbulk=inquantity-value2;
      int inbulkk=inbulk-ink;  
      double minlow=candlestick[inbulk].getLow();
      double maxhigh=candlestick[inbulk].getHigh();
//---
      for(int value=inbulk;value>=inbulkk;value--) {
        if(candlestick[value].getLow()<minlow) minlow=candlestick[value].getLow();
      }
      for(int value=inbulk;value>=inbulkk;value--) {
        if(candlestick[value].getHigh()>maxhigh) maxhigh=candlestick[value].getHigh();
      }      
//---      
      double currentclose=candlestick[inbulkk].getClose();
      double inlow=currentclose-minlow;
      double lowestlow=maxhigh-minlow;
      double valuek=(inlow/lowestlow)*100;
      cumulatek+=valuek;            
    }      
    cumulateaverage=cumulatek/loopk;
//---    
    return cumulateaverage;
//---
  }
//+------------------------------------------------------------------+
//| Percent K                                                        |
///+-----------------------------------------------------------------+
double Stochastic::PercentD(const int quantity, const int k)
  {
//---
    int loopk=3;
    int loopd=3;
    int ink=k;
    int inquantity=quantity;
//---
    double cumulateaveragek=0;
    for(int value3=0;value3<loopd;value3++) {
      double cumulatek=0;
      for(int value2=0;value2<loopk;value2++) {
//---
        int inbulk=inquantity-value2;
        int inbulkk=inbulk-ink;  
        double minlow=candlestick[inbulk].getLow();
        double maxhigh=candlestick[inbulk].getHigh();
//---
        for(int value=inbulk;value>=inbulkk;value--) {
          if(candlestick[value].getLow()<minlow) minlow=candlestick[value].getLow();
        }
        for(int value=inbulk;value>=inbulkk;value--) {
          if(candlestick[value].getHigh()>maxhigh) maxhigh=candlestick[value].getHigh();
        }      
//---      
        double currentclose=candlestick[inbulkk].getClose();
        double inlow=currentclose-minlow;
        double lowestlow=maxhigh-minlow;
        double valuek=(inlow/lowestlow)*100;
        cumulatek+=valuek;            
      }      
      cumulateaveragek+=cumulatek/loopk;
    }
    double cumulateaveraged=cumulateaveragek/loopd;
//---    
    return cumulateaveraged;
//---
  }
//+------------------------------------------------------------------+
