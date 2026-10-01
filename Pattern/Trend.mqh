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
#include "../SQlite.mqh"
#include "../Target/TrendStick.mqh"
#include "../Helper/DateTime.mqh"
#include "../Helper/Notification.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
struct TimeTrend {
    double trend;
    string time;
    int index;
};
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class Trend : TrendStick
  {
    private:
      bool Support(const int value);      
      bool Endurance(const int value);
      TimeTrend Minor(const int value);
      TimeTrend Major(const int value); 
      int CountEndurance(const string value);
      TimeTrend SupportUp(const string value);
      TimeTrend EnduranceDown(const string value);
      void WriteStick(const int index,const double trend_endurance,const double trend_support);
      DateTime dateTime;
      Notification notification;
      TimeTrend EnduranceBreak(const int index,const double value,const TimeTrend &trendMajor);
      TimeTrend EnduranceDiff(const double value,const TimeTrend &valueTrend);
      TimeTrend SupportDiff(const double value,const TimeTrend &valueTrend);
      TimeTrend MinorFirst(const int value);
      TimeTrend SupportDiff(const TimeTrend &valueTrend,const TimeTrend &lastTrend);
      TimeTrend TrendBreak(const int index,const double value,const TimeTrend &trendMajor);
      TimeTrend MajorFirst(const int value);
      TimeTrend EnduranceDiff(const TimeTrend &valueTrend,const TimeTrend &lastTrend);                        
      TimeTrend MinorFirst(const int value,const TimeTrend &majorTrend);
      TimeTrend MajorFirst(const int value,const TimeTrend &minorTrend);
      int EnduranceRange(const TimeTrend &initTrend,const TimeTrend &endTrend);

    protected:
      CandleStick *candlestick[];  
      TrendStick *supportStick[];
      TrendStick *enduranceStick[];
      
    public:
      Trend(const int value,const string inpattern);
      ~Trend();
      void Write();
      bool High(const int value,const string intimenow,const bool save);
      bool Low(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Trend::Trend(const int value,const string inpattern)
  {
//---
    dateTime = new DateTime();      
    notification = new Notification();
//---  
    ArrayResize(this.candlestick,value+1);
    for(int i=0; i<=value; i++){
      this.candlestick[i]=new CandleStick();
      this.candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
//---
    ArrayResize(this.enduranceStick,value+1);
    ArrayResize(this.supportStick,value+1);
    int endurance_count=0;
    int support_count=0;
    for(int i=0;i<=value;i++){
      if(Endurance(i)){
        double open_value=this.candlestick[i].getOpen();
        double close_value=this.candlestick[i].getClose();
        string time_value=this.candlestick[i].getTime();
        double endurance_value=0;
        if(red(open_value,close_value)) endurance_value=open_value; else endurance_value=close_value;
        this.enduranceStick[endurance_count]=new TrendStick();
        this.enduranceStick[endurance_count].Add(i,endurance_value,0,time_value);
        endurance_count++;
      }    
      if(Support(i)){
        double open_value=this.candlestick[i].getOpen();
        double close_value=this.candlestick[i].getClose();
        string time_value=this.candlestick[i]. getTime();
        double support_value=0;
        if(green(open_value,close_value)) support_value=open_value; else support_value=close_value;
        this.supportStick[support_count]=new TrendStick();
        this.supportStick[support_count].Add(i,0,support_value,time_value);
        support_count++;
      }    
    }
    ArrayResize(this.enduranceStick,endurance_count);
    ArrayResize(this.supportStick,support_count);
//---

  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
Trend::~Trend()
  {
  }
//+------------------------------------------------------------------+
//| Write                                                            |
//+------------------------------------------------------------------+
void Trend::Write()
  {
//---
    int size=ArraySize(this.candlestick);
    for(int i=0;i<size;i++)
      this.notification.WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
//---
    size=ArraySize(this.enduranceStick);
    for(int i=0;i<size;i++)
      this.notification.WriteTrend(IntegerToString(enduranceStick[i].getPosition()),DoubleToString(enduranceStick[i].getEndurance()),DoubleToString(enduranceStick[i].getSupport()),enduranceStick[i].getTime());
//---
    size=ArraySize(this.supportStick);
    for(int i=0;i<size;i++)
      this.notification.WriteTrend(IntegerToString(supportStick[i].getPosition()),DoubleToString(supportStick[i].getEndurance()),DoubleToString(supportStick[i].getSupport()),supportStick[i].getTime());
//---

  }
//+------------------------------------------------------------------+
//| Trend high                                                       |
///+-----------------------------------------------------------------+
bool Trend::High(const int value,const string intimenow,const bool save)
  {
//---
    int value1=value;
    double open_value=this.candlestick[value1].getOpen();
    double close_value=this.candlestick[value1].getClose();
//---
    double trend_endurance=0;
    double trend_support=0;
//---
    if(green(open_value,close_value)){
      trend_endurance=close_value; 
      trend_support=open_value; 
    }else{
      trend_endurance=open_value; 
      trend_support=close_value; 
    }
    string time_value=this.candlestick[value1].getTime();
//---
    this.notification.WriteTradeOpen(DoubleToString(open_value),time_value);
    this.notification.WriteTradeClose(DoubleToString(close_value),time_value);
//---
    WriteStick(value1,trend_endurance,trend_support);
//---
    return false;
//---      

  }
/*  
//---      
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int account_max=3+1;
//---    
    double close_value=candlestick[value].getClose();
//---
    double account[];
    ArrayResize(account,account_max); 
    for(int i=1; i<account_max; i++) account [i]=0;
//---
    bool support_up=false;
    for(int i=value1;i<=value3;i++) {
//---
      if(i==value1) account[1]=supportStick[value].getSupport();
      if(i==value2) account[2]=supportStick[value].getSupport();
      if(i==value3) account[3]=supportStick[value].getSupport();
//---
      if((account[1]<account[2]) && (account[2]<account[3])) support_up=true;
      if((account[1]<close_value) && (account[2]<close_value) && (account[3]<close_value)) support_up=true;     
    }
//---
    ArrayFree(account);
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    bool endurance_up=false;
    for(int i=value1;i<=value3;i++) {
//---
      if(i==value1) account[1]=enduranceStick[value].getEndurance();
      if(i==value2) account[2]=enduranceStick[value].getEndurance();
      if(i==value3) account[3]=enduranceStick[value].getEndurance();
//---
      if((account[1]<account[2]) && (account[2]<account[3])) endurance_up=true;
      if((account[2]<close_value) && (account[3]<close_value) && (account[4]<close_value)) endurance_up=true;     
    }
//---
    if(support_up && endurance_up) return true;
//---
    return false;
//---

  }
*/  
//+------------------------------------------------------------------+
//| Trend low                                                        |
///+-----------------------------------------------------------------+
bool Trend::Low(const int value,const string intimenow,const bool save)
  {
//---
    int value1=value;
    double open_value=this.candlestick[value1].getOpen();
    double close_value=this.candlestick[value1].getClose();
//---
    double trend_endurance=0;
    double trend_support=0;
//---
    if(green(open_value,close_value)){
      trend_endurance=close_value; 
      trend_support=open_value; 
    }else{
      trend_endurance=open_value; 
      trend_support=close_value; 
    }
    string time_value=this.candlestick[value1].getTime();
//---
    this.notification.WriteTradeOpen(DoubleToString(open_value),time_value);
    this.notification.WriteTradeClose(DoubleToString(close_value),time_value);
//---
    WriteStick(value1,trend_endurance,trend_support);
//---
    return false;
//---      

  }
/*
bool Trend::Low(const int value,const string intimenow,const bool save)
  {
//---      
    int value1=value;
    int value2=value+1;
    int value3=value+2;
    int account_max=3+1;
//---    
    double close_value=candlestick[value].getClose();
//---
    double account[];
    ArrayResize(account,account_max); 
    for(int i=1; i<account_max; i++) account [i]=0;
//---
    bool support_down=false;
    for(int i=value1;i<=value3;i++) {
//---
      if(i==value1) account[1]=supportStick[value].getSupport();
      if(i==value2) account[2]=supportStick[value].getSupport();
      if(i==value3) account[3]=supportStick[value].getSupport();
//---
      if((account[1]>account[2]) && (account[2]>account[3])) support_down=true;
      if((account[2]>close_value) && (account[3]>close_value) && (account[4]>close_value)) support_down=true;     
    }
//---
    ArrayFree(account);
    ArrayResize(account,account_max);
    for(int i=1; i<account_max; i++) account[i]=0;
//---
    bool endurance_down=false;
    for(int i=value1;i<=value3;i++) {
//---
      if(i==value1) account[1]=enduranceStick[value].getEndurance();
      if(i==value2) account[2]=enduranceStick[value].getEndurance();
      if(i==value3) account[3]=enduranceStick[value].getEndurance();
//---
      if((account[1]>account[2]) && (account[2]>account[3])) endurance_down=true;
      if((account[1]>close_value) && (account[2]>close_value) && (account[3]>close_value)) endurance_down=true;     
    }
//---
    if(support_down && endurance_down) return true;
//---
    return false;
//---

  }
*/    
//+------------------------------------------------------------------+
//| Verify support                                                   |
//+------------------------------------------------------------------+
bool Trend::Support(const int value)
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
      if(i==value1) if(green(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[1]=this.candlestick[i].getOpen(); else account[1]=this.candlestick[i].getClose();
      if(i==value2) if(green(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[2]=this.candlestick[i].getOpen(); else account[2]=this.candlestick[i].getClose();
      if(i==value3) if(green(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[3]=this.candlestick[i].getOpen(); else account[3]=this.candlestick[i].getClose();
//---
      if(i==value3){
        if((account[2]<=account[1])&&(account[2]<=account[3])){
          return true;
        }
      }
    }
//---
    return false;
//---

  }  
//+------------------------------------------------------------------+
//| Verify endurance                                                 |
//+------------------------------------------------------------------+
bool Trend::Endurance(const int value)
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
      if(i==value1) if(red(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[1]=this.candlestick[i].getOpen(); else account[1]=this.candlestick[i].getClose();
      if(i==value2) if(red(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[2]=this.candlestick[i].getOpen(); else account[2]=this.candlestick[i].getClose();
      if(i==value3) if(red(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) account[3]=this.candlestick[i].getOpen(); else account[3]=this.candlestick[i].getClose();
//---
      if(i==value3){
        if((account[2]>=account[1])&&(account[2]>=account[3])){
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
TimeTrend Trend::Major(const int value) 
  {
//---
    int value1=value;  
//---
    TimeTrend timeTrend;
    int init=0;
//---    
    timeTrend.index=value1;
    timeTrend.time=this.candlestick[value1].getTime();
    timeTrend.trend=0;
    if(green(this.candlestick[value1].getOpen(),this.candlestick[value1].getClose())) timeTrend.trend=this.candlestick[value1].getClose(); else timeTrend.trend=this.candlestick[value1].getOpen();
    int size=ArraySize(enduranceStick);
//---    
    for(int i=init;i<size;i++){
      double major_currenty=this.enduranceStick[i].getEndurance();
      string time_currenty=this.enduranceStick[i].getTime();
      if(major_currenty>timeTrend.trend){
        timeTrend.trend=major_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
      }
    }
//---    
    return timeTrend;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount major first                                                |
//+------------------------------------------------------------------+
TimeTrend Trend::MajorFirst(const int value) 
  {
//---
    int value1=value;  
//---
    TimeTrend timeTrend;
    int init=0;
//---    
    timeTrend.index=value1;
    timeTrend.time=this.candlestick[value1].getTime();
    timeTrend.trend=0;
    if(green(this.candlestick[value1].getOpen(),this.candlestick[value1].getClose())) timeTrend.trend=this.candlestick[value1].getClose(); else timeTrend.trend=this.candlestick[value1].getOpen();
    int size=ArraySize(enduranceStick);
//---    
    for(int i=init;i<size;i++){
      double major_currenty=this.enduranceStick[i].getEndurance();
      string time_currenty=this.enduranceStick[i].getTime();
      if(major_currenty>timeTrend.trend){
        timeTrend.trend=major_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
        return timeTrend;
      }
    }
//---    
    return timeTrend;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount major first                                                |
//+------------------------------------------------------------------+
TimeTrend Trend::MajorFirst(const int value,const TimeTrend &minorTrend) 
  {
//---
    int value1=value;  
    TimeTrend valueTrend=minorTrend;
    datetime date_major=this.dateTime.OnlyDate(valueTrend.time);
//---
    TimeTrend timeTrend;
    int init=0;
//---    
    timeTrend.index=value1;
    timeTrend.time=this.candlestick[value1].getTime();
    timeTrend.trend=0;
    if(green(this.candlestick[value1].getOpen(),this.candlestick[value1].getClose())) timeTrend.trend=this.candlestick[value1].getClose(); else timeTrend.trend=this.candlestick[value1].getOpen();
    int size=ArraySize(enduranceStick);
//---    
    for(int i=init;i<size;i++){
      double major_currenty=this.enduranceStick[i].getEndurance();
      string time_currenty=this.enduranceStick[i].getTime();
      int index_currenty=this.enduranceStick[i].getPosition();
      if(major_currenty>timeTrend.trend){
        timeTrend.trend=major_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
//---
        datetime date_trend=this.dateTime.OnlyDate(timeTrend.time);        
        if(date_trend!=date_major) return timeTrend;        
        else {
          timeTrend=MajorFirst(index_currenty);
//---
          return timeTrend;
        }
      }
    }
//---    
    return timeTrend;  
//---
    
  }      
//+------------------------------------------------------------------+
//| Mount minor                                                      |
//+------------------------------------------------------------------+
TimeTrend Trend::Minor(const int value) 
  {
//---
    int value1=value;  
//---
    TimeTrend timeTrend;
    int init=0;
//---    
    timeTrend.index=value1;
    timeTrend.time=this.candlestick[value1].getTime();
    timeTrend.trend=0;
    if(red(this.candlestick[value1].getOpen(),this.candlestick[value1].getClose())) timeTrend.trend=this.candlestick[value1].getClose(); else timeTrend.trend=this.candlestick[value1].getOpen();
    int size=ArraySize(supportStick);
//---    
    for(int i=init;i<size;i++){
      double minor_currenty=this.supportStick[i].getSupport();
      string time_currenty=this.supportStick[i].getTime();
      if(minor_currenty<timeTrend.trend){
        timeTrend.trend=minor_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
      }
    }
//---    
    return timeTrend;
//---
      
  }
//+------------------------------------------------------------------+
//| Mount minor first                                                |
//+------------------------------------------------------------------+
TimeTrend Trend::MinorFirst(const int value) 
  {
//---
    int value1=value;  
//---
    TimeTrend timeTrend;
    int init=0;
//---
    timeTrend.index=value1;
    timeTrend.time=this.candlestick[value1].getTime();
    timeTrend.trend=0;
    if(red(this.candlestick[value1].getOpen(),this.candlestick[value1].getClose())) timeTrend.trend=this.candlestick[value1].getClose(); else timeTrend.trend=this.candlestick[value1].getOpen();
    int size=ArraySize(supportStick);
//---    
    for(int i=init;i<size;i++){
      double minor_currenty=this.supportStick[i].getSupport();
      string time_currenty=this.supportStick[i].getTime();
      if(minor_currenty<timeTrend.trend){
        timeTrend.trend=minor_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
//---        
        return timeTrend;
      }
    }
//---    
    return timeTrend;
//---
      
  }
/*
//+------------------------------------------------------------------+
//| Mount minor equal                                                |
//+------------------------------------------------------------------+
TimeTrend Trend::MinorFirst(const int value,const TimeTrend &majorTrend) 
  {
//---
    int first=value;  
    TimeTrend valueTrend=majorTrend;
    datetime date_major=this.dateTime.OnlyDate(valueTrend.time);
//---    
    TimeTrend timeTrend;
    int init=0;
    timeTrend.trend=0;
    timeTrend.index=1;
    timeTrend.time=this.candlestick[first].getTime();
    if(red(this.candlestick[first].getOpen(),this.candlestick[first].getClose())) timeTrend.trend=this.candlestick[first].getClose(); else timeTrend.trend=this.candlestick[first].getOpen();
    int size=ArraySize(supportStick);
//---    
    for(int i=init;i<size;i++){
      double minor_currenty=this.supportStick[i].getSupport();
      string time_currenty=this.supportStick[i].getTime();
      if(minor_currenty<timeTrend.trend){
        timeTrend.trend=minor_currenty;
        timeTrend.time=time_currenty;
        timeTrend.index=i+1;
        datetime date_trend=this.dateTime.OnlyDate(timeTrend.time);        
//---
        if(date_trend!=date_major) return timeTrend;        
        else {
          timeTrend=MinorFirst(i);
          return timeTrend;
        }
      }
    }
//---    
    return timeTrend;
//---
      
  }
*/  
//+------------------------------------------------------------------+
//| Mount up position from support                                   |
//+------------------------------------------------------------------+
TimeTrend Trend::SupportUp(const string value) 
  {
//---
    string value_date=value;
    datetime only_date = this.dateTime.OnlyDate(value_date);
    TimeTrend timeTrend;   
//---
    int first=0;
    int size=ArraySize(this.supportStick);
//---    
    for(int i=first;i<size;i++){
      double value_currency=this.supportStick[i].getSupport();
      datetime time_currency=this.dateTime.OnlyDate(supportStick[i].getTime());
      if(time_currency<only_date){
        timeTrend.trend=value_currency;
        timeTrend.time=TimeToString(time_currency);
        timeTrend.index=i+1;
        return timeTrend;      
      }
    }    
//---    
    return timeTrend;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount down position from endurance                               |
//+------------------------------------------------------------------+
TimeTrend Trend::EnduranceDown(const string value) 
  {
//---
    string value_date=value;
    datetime only_date=this.dateTime.OnlyDate(value_date);
    TimeTrend timeTrend;   
//---
    int first=0;
    int size=ArraySize(this.enduranceStick);
//---    
    for(int i=first;i<size;i++){
      double value_currency=this.enduranceStick[i].getEndurance();
      datetime time_currency=this.dateTime.OnlyDate(this.enduranceStick[i].getTime());
      if(time_currency<only_date){
        timeTrend.trend=value_currency;
        timeTrend.time=TimeToString(time_currency);
        timeTrend.index=i+1;
        return timeTrend;      
      }
    }    
//---    
    return timeTrend;  
//---
    
  }
/*  
//+------------------------------------------------------------------+
//| Mount down position from support                                 |
//+------------------------------------------------------------------+
TimeTrend Trend::SupportDown(const double value,const int index) 
  {
//---
    double trend_value=value;
    int trend_index=index;
//---    
    TimeTrend minorFirst=MinorFirst(trend_index);
    if(minorFirst.trend<trend_value) return minorFirst;
//---    
    datetime date_value=this.dateTime.OnlyDate(this.candlestick[index].getTime());
//---
    TimeTrend timeTrend;   
//---
    int first=trend_index-1;
    int size=ArraySize(this.candlestick);
//---
    for(int i=first;i<size;i++){
      double value_currency=0;
      if(red(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) value_currency=this.candlestick[i].getClose(); else value_currency=this.candlestick[i].getOpen();
      string time_currency=this.candlestick[i].getTime();
      datetime date_currency=this.dateTime.OnlyDate(this.candlestick[i].getTime());
      if((value_currency<trend_value)&&(date_currency<date_value)){
        timeTrend=MinorFirst(i);
        return timeTrend;
      }
    }
//---    
    return timeTrend;
//---
    int first=0;
    int size=ArraySize(this.supportStick);
//---    
    for(int i=first;i<size;i++){
      double value_currency=this.supportStick[i].getSupport();
      string time_currency=this.supportStick[i].getTime();
      if(value_currency<trend_value){
        timeTrend.trend=value_currency;
        timeTrend.time=time_currency;
        timeTrend.index=i+1;
        return timeTrend;      
      }
    }    
//---
    
  }
*/  
//+------------------------------------------------------------------+
//| Mount difference endurance from up                               |
//+------------------------------------------------------------------+
TimeTrend Trend::EnduranceDiff(const double value,const TimeTrend &valueTrend) 
  {
//---
    double up_value=value;
    TimeTrend valueEndurance=valueTrend;
    TimeTrend timeTrend;   
//---
    double difference=valueEndurance.trend-up_value;
    timeTrend.trend=difference;
    timeTrend.time=valueEndurance.time;
    timeTrend.index=valueEndurance.index;
//---    
    return timeTrend;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount difference endurance from up                               |
//+------------------------------------------------------------------+
TimeTrend Trend::EnduranceDiff(const TimeTrend &valueTrend,const TimeTrend &lastTrend) 
  {
//---
    TimeTrend valueEndurance=valueTrend;
    TimeTrend lastEndurance=lastTrend;
    TimeTrend timeTrend;   
//---
    double value_difference=lastEndurance.trend-valueEndurance.trend;
    int index_difference=lastEndurance.index-valueEndurance.index;
    timeTrend.trend=value_difference;
    timeTrend.time=valueEndurance.time;
    timeTrend.index=index_difference;
//---    
    return timeTrend;  
//---
    
  }  
//+------------------------------------------------------------------+
//| Mount difference support from down                               |
//+------------------------------------------------------------------+
TimeTrend Trend::SupportDiff(const double value,const TimeTrend &valueTrend) 
  {
//---
    double down_value=value;
    TimeTrend valueSupport=valueTrend;
    TimeTrend timeTrend;   
//---
    double difference=down_value-valueSupport.trend;
    timeTrend.trend=difference;
    timeTrend.time=valueSupport.time;
    timeTrend.index=valueSupport.index;
//---    
    return timeTrend;  
//---
    
  }    
//+------------------------------------------------------------------+
//| Mount difference support from down                               |
//+------------------------------------------------------------------+
TimeTrend Trend::SupportDiff(const TimeTrend &valueTrend,const TimeTrend &lastTrend) 
  {
//---
    TimeTrend valueSupport=valueTrend;
    TimeTrend lastSupport=lastTrend;
    TimeTrend timeTrend;   
//---
    double value_difference=valueSupport.trend-lastSupport.trend;
    int index_difference=lastSupport.index-valueSupport.index;
    timeTrend.trend=value_difference;
    timeTrend.time=valueSupport.time;
    timeTrend.index=index_difference;
//---    
    return timeTrend;  
//---
    
  }      
//+------------------------------------------------------------------+
//| Mount position in the break endurance                            |
//+------------------------------------------------------------------+
TimeTrend Trend::EnduranceBreak(const int index,const double value,const TimeTrend &trendMajor) 
  {
//---
    double value_trend=value;
    TimeTrend major=trendMajor;
    TimeTrend timeTrend;   
//---
    if(value_trend<major.trend) return major;    
//---
    int first=index+1;
    int size=ArraySize(this.enduranceStick)-1;
//---
    for(int i=first;i<size;i++){
      timeTrend=Major(i);
      double value_previous=0;
      if(green(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) value_previous=this.candlestick[i].getClose(); else value_previous=this.candlestick[i].getOpen();
      if(value_previous<major.trend) return timeTrend;    
    }
//---    
    return timeTrend;  
//---
    
  }
//+------------------------------------------------------------------+
//| Mount base position in the break endurance                            |
//+------------------------------------------------------------------+
TimeTrend Trend::TrendBreak(const int index,const double value,const TimeTrend &trendMajor) 
  {
//---
    double value_trend=value;
    int index_trend=index;
    TimeTrend major=trendMajor;
    TimeTrend timeTrend;   
    timeTrend.trend=value_trend;
    timeTrend.index=index_trend;
    timeTrend.time=this.candlestick[index_trend].getTime();
//---
    if(value_trend<major.trend) return timeTrend;    
//---
    int first=index_trend+1;
    int size=ArraySize(this.enduranceStick)-1;
//---
    for(int i=first;i<size;i++){
      double value_previous=0;
      if(green(this.candlestick[i].getOpen(),this.candlestick[i].getClose())) value_previous=this.candlestick[i].getClose(); else value_previous=this.candlestick[i].getOpen();
      timeTrend.trend=value_previous;
      timeTrend.index=i;
      timeTrend.time=this.candlestick[i].getTime();
      if(value_previous<major.trend) return timeTrend;    
    }
//---    
    return timeTrend;  
//---
    
  }  
//+------------------------------------------------------------------+
//| Count the resistance position below level support                |
//+------------------------------------------------------------------+
int Trend::EnduranceRange(const TimeTrend &initTrend,const TimeTrend &endTrend) 
  {
//---
    TimeTrend minorTrend=initTrend;
    TimeTrend majorTrend=endTrend;   
//---    
    datetime date_minor=this.dateTime.OnlyDate(minorTrend.time);
    datetime date_major=this.dateTime.OnlyDate(majorTrend.time);
    int count=0;
//---
    if(date_major==date_minor) return count;    
//---
    int init=0;
    int size=ArraySize(this.enduranceStick)-1;
//---
    for(int i=init;i<size;i++){
      datetime date_endurance=this.dateTime.OnlyDate(this.enduranceStick[i].getTime());
      if((date_endurance>date_minor)&&(date_endurance<date_major)) count++;
    }
//---    
    return count;  
//---
    
  }
//+------------------------------------------------------------------+
//| Print endurance and support                                      |
//+------------------------------------------------------------------+
void Trend::WriteStick(const int index,const double trend_endurance,const double trend_support) 
  {
//---
    int index1=index;
    double value_endurance=trend_endurance;
    double value_support=trend_support;
//---
    TimeTrend major_value=Major(index1);
    this.notification.WriteTrendMajor(DoubleToString(major_value.trend),major_value.time,IntegerToString(major_value.index));
//---
    TimeTrend previous_endurance=EnduranceBreak(index1,value_endurance,major_value);
    this.notification.WriteMajorPrevious(DoubleToString(previous_endurance.trend),previous_endurance.time,IntegerToString(previous_endurance.index));
//---
    TimeTrend minor_value=Minor(index1);
    this.notification.WriteTrendMinor(DoubleToString(minor_value.trend),minor_value.time,IntegerToString(minor_value.index));
//---
    TimeTrend position_support=SupportUp(major_value.time);
    this.notification.WriteEnduranceMajor(IntegerToString(previous_endurance.index),previous_endurance.time,IntegerToString(position_support.index),position_support.time);
//---
    TimeTrend position_endurance=EnduranceDown(minor_value.time);
    this.notification.WriteSupportMinor(IntegerToString(minor_value.index),minor_value.time,IntegerToString(position_endurance.index),position_endurance.time);
//---
    TimeTrend minor_first=MinorFirst(index1);
    this.notification.WriteEnduranceSupport(IntegerToString(previous_endurance.index),previous_endurance.time,IntegerToString(minor_first.index),minor_first.time);
//---
    TimeTrend trend_position=TrendBreak(index1,value_endurance,major_value);
    TimeTrend difEndurance=EnduranceDiff(trend_position.trend,previous_endurance);
    this.notification.WriteEnduranceDiff(IntegerToString(difEndurance.index),difEndurance.time,DoubleToString(difEndurance.trend),trend_position.time);
//---
    TimeTrend difSupport=SupportDiff(value_support,minor_value);
    this.notification.WriteSupportDiff(IntegerToString(difSupport.index),difSupport.time,DoubleToString(difSupport.trend),this.candlestick[index1].getTime());
//---    
    TimeTrend major_first=MajorFirst(index1,minor_first);
    this.notification.WriteEnduranceUpSupportDown(IntegerToString(major_first.index),major_first.time,IntegerToString(minor_first.index),minor_first.time);
//---
    TimeTrend difEnduranceMajor=EnduranceDiff(major_first,previous_endurance);
    this.notification.WriteEnduranceDiff(IntegerToString(difEnduranceMajor.index),difEndurance.time,DoubleToString(difEnduranceMajor.trend),difEnduranceMajor.time);
//---
    TimeTrend difSupportMinor=SupportDiff(minor_first,minor_value);
    this.notification.WriteSupportDiff(IntegerToString(difSupportMinor.index),difSupport.time,DoubleToString(difSupportMinor.trend),difSupportMinor.time);
//---

  }          
//+------------------------------------------------------------------+
