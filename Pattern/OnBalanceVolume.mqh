//+------------------------------------------------------------------+
//|                                                       Hammer.mqh |
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
#include "../Target/VolumeStick.mqh"
#include "../Gauge/Volume.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class OnBalanceVolume : VolumeStick
  {
    private:

    protected:
      CandleStick *candlestick[];   
      VolumeStick *volumeStick[]; 

    public:
      OnBalanceVolume(const int value,const string inpattern,const int inmme,const int inmms);
      ~OnBalanceVolume();
      void Write(const int value);
      bool Low(const int value,const string intimenow,const bool save);
      bool High(const int value,const string intimenow,const bool save);
      bool HighAverage(const int value,const string intimenow,const bool save);
      bool LowAverage(const int value,const string intimenow,const bool save);
  };
//+------------------------------------------------------------------+
//| Construtor write candle                                          |
//+------------------------------------------------------------------+
OnBalanceVolume::OnBalanceVolume(const int value,const string inpattern,const int inmme,const int inmms)
  {
//---
    int quantity=value+1;
//---
    ArrayResize(candlestick,quantity);
    for(int i=0; i<=value; i++) {
      candlestick[i]=new CandleStick();
      candlestick[i].Save(iHigh(_Symbol,_Period,i),iOpen(_Symbol,_Period,i),iClose(_Symbol,_Period,i),iLow(_Symbol,_Period,i),TimeToString(iTime(_Symbol,_Period,i)),iVolume(_Symbol,_Period,i),inpattern,_Symbol);
    }
//---
    ArrayResize(volumeStick,quantity);
    Volume *bulk;
    bulk=new Volume(quantity,"ONBALANCEVOLUME");
    int mme_value=inmme;
    int mms_value=inmms;
    for(int i=quantity; i>=0; i--) {
      double volume_cumulate=bulk.Balance(quantity,i);
      double mms_cumulate=bulk.MMS(quantity,i,mms_value);
      double mme_cumulate=bulk.MME(quantity,i,mme_value);
      volumeStick[i]=new VolumeStick();
      volumeStick[i].Add(i,volume_cumulate,mme_cumulate,mms_cumulate,candlestick[i].getVolume());
    }
//---

  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
OnBalanceVolume::~OnBalanceVolume()
  {
  }
//+------------------------------------------------------------------+
//| Write down                                                       |
//+------------------------------------------------------------------+
void OnBalanceVolume::Write(const int value)
  {
    for(int i=1; i<value; i++)
      WriteCandle(DoubleToString(candlestick[i].getHigh()),DoubleToString(candlestick[i].getOpen()),DoubleToString(candlestick[i].getClose()),DoubleToString(candlestick[i].getLow()),IntegerToString(i));
//---

  }
//+------------------------------------------------------------------+
//| Verify low                                                       |
//+------------------------------------------------------------------+
bool OnBalanceVolume::Low(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(rupturelow(volumeStick[i].balance,volumeStick[i].mme)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---    
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify high                                                      |
//+------------------------------------------------------------------+
bool OnBalanceVolume::High(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(rupturehigh(volumeStick[i].balance,volumeStick[i].mme)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---    
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify high average                                              |
//+------------------------------------------------------------------+
bool OnBalanceVolume::HighAverage(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(highaverage(volumeStick[i].volume,volumeStick[i].mms)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---    
    return false;
//---
    
  }  
//+------------------------------------------------------------------+
//| Verify low average                                               |
//+------------------------------------------------------------------+
bool OnBalanceVolume::LowAverage(const int value,const string intimenow,const bool save)
  {
//---  
    int value1=value;
    int account_max=1+1;
//---
    string inTime="",inPattern="",inSymbol="";
//---
    enum ENUM_SINAL {TRUE = 1, FALSE = -1, ZERO = 0};
    ENUM_SINAL account[];
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=ZERO;
//---
    for(int i=value1; i<=value1; i++) {
      if(i==value1) if(lowaverage(volumeStick[i].volume,volumeStick[i].mms)) account[1]=TRUE; else account[1]=FALSE;
//---
      if(account[1]==TRUE) {
//---
        inTime=candlestick[value1].getTime();
        inPattern=candlestick[value1].getPattern();
        inSymbol=candlestick[value1].getSymbol();
//---
        if(save) {
          SQLite *sqlite;
          sqlite=new SQLite();
          sqlite.SaveData(intimenow,inPattern,inSymbol,inTime);
        }
        return true;
      }
    }
//---    
    return false;
//---
    
  }   
//+------------------------------------------------------------------+
