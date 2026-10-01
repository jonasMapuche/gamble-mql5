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
#include "../Target/CandleStick.mqh"
//#include "../Golang.mqh"
#include "../SQlite.mqh"
#include "../Target/TrendStick.mqh"
#include "../Helper/Notification.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class Fibonacci : TrendStick
  {
    private:
      bool Endurance(const int value);
      bool Support(const int value);
      double Major(const int value,const bool high_major);
      double Minor(const int value,const bool high_minor);      
      double Fibonacci382(const double inendurance,const double insupport,const bool inhigh);
      double Fibonacci618(const double inendurance,const double insupport,const bool inhigh);
      Notification notification;
    
    protected:
      CandleStick *candlestick[];   
      TrendStick *enduranceStick[];
      TrendStick *supportStick[];

    public:
      Fibonacci(const int value,const string inpattern);
      ~Fibonacci();
      void Write();
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
};
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
Fibonacci::Fibonacci(const int value,const string inpattern)
  {  
//---
    notification=new Notification();
//---    
    ArrayResize(candlestick,value+1);
    for(int i=0;i<=value;i++){
      candlestick[i]=new CandleStick();
      candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
//---
    ArrayResize(enduranceStick,value+1);
    ArrayResize(supportStick,value+1);
    int endurance_count=0;
    int support_count=0;
    for(int i=0;i<=value;i++){
      if(Endurance(i)){
        double open_value=candlestick[i].getOpen();
        double close_value=candlestick[i].getClose();
        string time_value=candlestick[i].getTime();
        double endurance_value=0;
        if(red(open_value,close_value)) endurance_value=open_value; else endurance_value=close_value;
        enduranceStick[endurance_count]=new TrendStick();
        enduranceStick[endurance_count].Add(i,endurance_value,0,time_value);
        endurance_count++;
      }    
      if(Support(i)){
        double open_value=candlestick[i].getOpen();
        double close_value=candlestick[i].getClose();
        string time_value=candlestick[i]. getTime();
        double support_value=0;
        if(green(open_value,close_value)) support_value=open_value; else support_value=close_value;
        supportStick[support_count]=new TrendStick();
        supportStick[support_count].Add(i,0,support_value,time_value);
        support_count++;
      }    
    }
    ArrayResize(enduranceStick,endurance_count);
    ArrayResize(supportStick,support_count);
//---
    
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
void Fibonacci::Write()
  {
//---
    int size=ArraySize(candlestick);
    for(int i=0;i<size;i++)
      this.notification.WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
//---
    size=ArraySize(enduranceStick);
    for(int i=0;i<size;i++)
      this.notification.WriteTrend(IntegerToString(enduranceStick[i].getPosition()),DoubleToString(enduranceStick[i].getEndurance()),DoubleToString(enduranceStick[i].getSupport()),enduranceStick[i].getTime());
//---
    size=ArraySize(supportStick);
    for(int i=0;i<size;i++)
      this.notification.WriteTrend(IntegerToString(supportStick[i].getPosition()),DoubleToString(supportStick[i].getEndurance()),DoubleToString(supportStick[i].getSupport()),supportStick[i].getTime());
//---

   }
//+------------------------------------------------------------------+
//| Verify fibonacci high                                            |
//+------------------------------------------------------------------+
bool Fibonacci::High(const int value,const string intimenow,const bool save)
  {
//---
    int value1=value;
    bool high_major=false;
    bool high_minor=true;
    bool high_fibonacci=true;
//---
    double close_value=candlestick[value1].getClose();
    string time_value=candlestick[value1].getTime();
    this.notification.WriteTrade(DoubleToString(close_value),time_value);
//---    
    double major_value=Major(value1,high_major);
    this.notification.WriteTrendMajor(DoubleToString(major_value));
    double minor_value=Minor(value1,high_minor);
    this.notification.WriteTrendMinor(DoubleToString(minor_value));
//---
    double fibonacci_382=Fibonacci382(major_value,minor_value,high_fibonacci);
    this.notification.WriteFibonacci100382(DoubleToString(major_value),DoubleToString(minor_value),DoubleToString(fibonacci_382));         
    double fibonacci_618=Fibonacci618(major_value,minor_value,high_fibonacci);
    this.notification.WriteFibonacci100618(DoubleToString(major_value),DoubleToString(minor_value),DoubleToString(fibonacci_618));         
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify fibonacci low                                             |
//+------------------------------------------------------------------+
bool Fibonacci::Low(const int value,const string intimenow,const bool save)
  {
//---
    int value1=value;
    bool high_major=true;
    bool high_minor=false;
    bool high_fibonacci=false;
//---
    double close_value=candlestick[value1].getClose();
    string time_value=candlestick[value1].getTime();
    this.notification.WriteTrade(DoubleToString(close_value),time_value);
//---
    double major_value=Major(value1,high_major);
    this.notification.WriteTrendMajor(DoubleToString(major_value));
    double minor_value=Minor(value1,high_minor);
    this.notification.WriteTrendMinor(DoubleToString(minor_value));
//---
    double fibonacci_382=Fibonacci382(major_value,minor_value,high_fibonacci);
    this.notification.WriteFibonacci100382(DoubleToString(major_value),DoubleToString(minor_value),DoubleToString(fibonacci_382));         
    double fibonacci_618=Fibonacci618(major_value,minor_value,high_fibonacci);
    this.notification.WriteFibonacci100618(DoubleToString(major_value),DoubleToString(minor_value),DoubleToString(fibonacci_618));         
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify endurance                                                 |
//+------------------------------------------------------------------+
bool Fibonacci::Endurance(const int value)
  {
//---  
    if(value==0) return false;
    int size=ArraySize(candlestick);
    if(value==size-1) return false;
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
      if(i==value3){
        if((account[2]>account[1])&&(account[2]>account[3])){
          return true;
        }
      }
    }
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify support                                                   |
//+------------------------------------------------------------------+
bool Fibonacci::Support(const int value)
  {
//---  
    if(value==0) return false;
    int size=ArraySize(candlestick);
    if(value==size-1) return false;
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
      if(i==value3){
        if((account[2]<account[1])&&(account[2]<account[3])){
          return true;
        }
      }
    }
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Mount major                                                      |
//+------------------------------------------------------------------+
double Fibonacci::Major(const int value,const bool high_major) 
  {
//---
    int first=value;  
    int previous=first-1;
    double major=0;
    if(green(candlestick[first].getOpen(),candlestick[first].getClose())) major=candlestick[first].getClose(); else major=candlestick[first].getOpen();
    int size=ArraySize(enduranceStick);
//---    
    for(int i=previous;i<size;i++){
      double currenty=enduranceStick[i].getEndurance();
      if(currenty>major){
        major=currenty;
//---
        if(high_major) return major;
      }
    }
//---    
    return major;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount minor                                                      |
//+------------------------------------------------------------------+
double Fibonacci::Minor(const int value,const bool high_minor) 
  {
//---
    int first=value;  
    int previous=first-1;
    double minor=0;
    if(red(candlestick[first].getOpen(),candlestick[first].getClose())) minor=candlestick[first].getClose(); else minor=candlestick[first].getOpen();
    int size=ArraySize(supportStick);
//---    
    for(int i=previous;i<size;i++){
      double currenty=supportStick[i].getSupport();
      if(currenty<minor){
        minor=currenty;
//--- 
        if(high_minor) return minor;
      }
    }
//---    
    return minor;
//---
      
  }
//+------------------------------------------------------------------+
//| Mount fibonacci 38.2                                             |
//+------------------------------------------------------------------+
double Fibonacci::Fibonacci382(const double inendurance,const double insupport,const bool inhigh) 
  {
//---
    const double first=38.2;
    const double last=100;
//--
    double endurance_value=inendurance;
    double support_value=insupport;
    double difference_value=endurance_value-support_value;
    double result_value=0;
    if(inhigh) result_value=endurance_value-((difference_value*last)/first);
    else result_value=support_value+((difference_value*last)/first);
//---    
    return result_value;  
//---
    
  } 
//+------------------------------------------------------------------+
//| Mount fibonacci 61.8                                             |
//+------------------------------------------------------------------+
double Fibonacci::Fibonacci618(const double inendurance,const double insupport,const bool inhigh) 
  {
//---
    const double first=61.8;
    const double last=100;
//--
    double endurance_value=inendurance;
    double support_value=insupport;
    double difference_value=endurance_value-support_value;
    double result_value=0;
    if(inhigh) result_value=endurance_value-((difference_value*last)/first);
    else result_value=support_value+((difference_value*last)/first);
//---    
    return result_value;  
//---
    
  }     
//+------------------------------------------------------------------+
