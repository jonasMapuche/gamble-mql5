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
#include "../Target/TrendStick.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class Trend : CandleStick
  {
    private:
      bool Down(const int value);
      bool Up(const int value);
      bool Support(const int value);      
      bool Endurance(const int value);
    protected:
      CandleStick *candlestick[];  

    public:
      Trend(const int value,const string inpattern);
      ~Trend();
      bool High(const int quantity,const int start,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Trend::Trend(const int value,const string inpattern)
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
Trend::~Trend()
  {
  }
//+------------------------------------------------------------------+
//| Trend high                                                       |
///+-----------------------------------------------------------------+
bool Trend::High(const int quantity,const int start,const string intimenow,const bool save)
  {
//---    
    const int inquantity=quantity;
//---
    int instart=start;
    TrendStick *supportStick[]; 
    TrendStick *enduranceStick[]; 
    ArrayResize(supportStick,inquantity);
    ArrayResize(enduranceStick,inquantity);
    supportStick[inquantity-1]=new TrendStick();
    enduranceStick[inquantity-1]=new TrendStick();
//---
    double inOpen=0,inClose=0;
    int countup=0,countdown=0;
    inOpen=iOpen(_Symbol,_Period,1);
    inClose=iClose(_Symbol,_Period,1);
//---
    double down=0;
    if(green(inOpen,inClose)) down=inOpen; else down=inClose;
    supportStick[countdown].Add(1,0,down,instart);
//---
    double up=0;
    if(red(inOpen,inClose)) up=inOpen; else up=inClose;
    enduranceStick[countup].Add(1,up,0,instart);
//---
    for(int value=instart+1; value<quantity; value++) {
//---
      inOpen=candlestick[value].getOpen();
      inClose=candlestick[value].getClose();
//---  
      double support=0;
      if(Support(value)) {
        if(green(inOpen,inClose)) support=inOpen; else support=inClose;
        countdown++;
        supportStick[countdown].Add(value,0,support,countdown);
      } 
//---
      double endurance=0;
      if(Endurance(value)) {
        if(red(inOpen,inClose)) endurance=inOpen; else endurance=inClose;
        countup++;
        enduranceStick[countup].Add(value,endurance,0,countup);
      }                     
    }
//---      
    int value1=instart;
    int value2=instart+1;
    int value3=instart+2;
    int account_max=3+1;
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    bool supportup=false;
//---
    for(int value=instart; value<quantity; value++) {
//---
      if(value==value1) account[1]=supportStick[value].support;
      if(value==value2) account[2]=supportStick[value].support;
      if(value==value3) account[3]=supportStick[value].support;
//---
      if((account[1]>account[2]) && (account[2]>account[3])) {
          supportup=true;
          break;
      }
    }
//---
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    bool enduranceup=false;
//---
    for(int value=instart; value<quantity; value++) {
//---
      if(value==value1) account[1]=enduranceStick[value].support;
      if(value==value2) account[2]=enduranceStick[value].support;
      if(value==value3) account[3]=enduranceStick[value].support;
//---
      if((account[1]>account[2]) && (account[2]>account[3])) {
          enduranceup=true;
          break;
      }
    }
//---
    if(supportup && enduranceup){
      return true;
    }
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify down                                                      |
//+------------------------------------------------------------------+
bool Trend::Down(const int value)
  {
//---  
    int value1=value-1;
    int value2=value;
    int value3=value+1;
    int account_max=3+1;
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=candlestick[i].getOpen(); else account[1]=candlestick[i].getClose();
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=candlestick[i].getOpen(); else account[2]=candlestick[i].getClose();
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=candlestick[i].getOpen(); else account[3]=candlestick[i].getClose();
//---
        if((account[1]>account[2]) && (account[2]>account[3])) {
          return true;
      }
    }
//---
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify up                                                        |
//+------------------------------------------------------------------+
bool Trend::Up(const int value)
  {
//---  
    int value1=value-1;
    int value2=value;
    int value3=value+1;
    int account_max=3+1;
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=candlestick[i].getOpen(); else account[1]=candlestick[i].getClose();
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=candlestick[i].getOpen(); else account[2]=candlestick[i].getClose();
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=candlestick[i].getOpen(); else account[3]=candlestick[i].getClose();
//---
        if((account[1]<account[2]) && (account[2]<account[3])) {
          return true;
      }
    }
//---
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify support                                                   |
//+------------------------------------------------------------------+
bool Trend::Support(const int value)
  {
//---  
    int value1=value-1;
    int value2=value;
    int value3=value+1;
    int account_max=3+1;
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=candlestick[i].getOpen(); else account[1]=candlestick[i].getClose();
      if(i==value2) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=candlestick[i].getOpen(); else account[2]=candlestick[i].getClose();
      if(i==value3) if(green(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=candlestick[i].getOpen(); else account[3]=candlestick[i].getClose();
//---
        if((account[2]<account[1]) && (account[2]<account[3])) {
          return true;
      }
    }
//---
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify endurance                                                 |
//+------------------------------------------------------------------+
bool Trend::Endurance(const int value)
  {
//---  
    int value1=value-1;
    int value2=value;
    int value3=value+1;
    int account_max=3+1;
//---
    double account[];
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    for(int i=value1; i<=value3; i++) {
      if(i==value1) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[1]=candlestick[i].getOpen(); else account[1]=candlestick[i].getClose();
      if(i==value2) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[2]=candlestick[i].getOpen(); else account[2]=candlestick[i].getClose();
      if(i==value3) if(red(candlestick[i].getOpen(),candlestick[i].getClose())) account[3]=candlestick[i].getOpen(); else account[3]=candlestick[i].getClose();
//---
        if((account[2]>account[1]) && (account[2]>account[3])) {
          return true;
      }
    }
//---
    return false;
  }  
//+------------------------------------------------------------------+
