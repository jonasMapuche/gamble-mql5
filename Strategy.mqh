//+------------------------------------------------------------------+
//|                                                     Strategy.mqh |
//|                                  Copyright 2022, Stomach.com.br. |
//|                                       https://www.stomach.com.br |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Stomach.com.br."
#property link      "https://www.stomach.com.br"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "Golang.mqh"
#include "Thread.mqh"
#include "Target/CandleStick.mqh"
#include "SQlite.mqh"
#include "Target\TrendStick.mqh"
#include "Target\VolumeStick.mqh"
#include "Target\MovingAverageStick.mqh"
#include "Gauge\Volume.mqh"
#include "Gauge\MovingAverage.mqh"
#include "Statistic\Descriptive.mqh"
#include "Target\PositionStick.mqh"
//+------------------------------------------------------------------+
//| Class Router                                                     |
//+------------------------------------------------------------------+
class Strategy
  {
    private:
//---
      bool LoadOpenHigh(const int start);
      bool LoadOpenLow(const int start);
      bool LoadCloseSellPattern1(const int start);
      bool LoadCloseBuyPattern1(const int start);
      bool LoadOpenBuyPattern1(const int start);
      bool LoadOpenSellPattern1(const int start);
      bool LoadOpenBuyPattern2(const int start);
      bool LoadOpenSellPattern2(const int start);
      bool LoadOpenBuyFibonacci(const int start);
      bool LoadOpenSellFibonacci(const int start);
    public:
      Strategy();
      ~Strategy();
//---
      bool PatternHigh();
      bool PatternLow();
      bool Pattern1Close(PositionStick &positionStick);
      bool Pattern1Open(long brand);
      bool Pattern2Open(long brand);
      bool PatternFibonacciOpen(long brand);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Strategy::Strategy()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Strategy::~Strategy()
  {
  }
//+------------------------------------------------------------------+
//| Verify pattern close position opening                            |
//+------------------------------------------------------------------+
bool Strategy::Pattern1Close(PositionStick &positionStick)
  { 
//---
    int inStart=1;
    long kind=positionStick.kind;
    if(kind==POSITION_TYPE_BUY){
      if(LoadCloseBuyPattern1(inStart)) return true;
    }else{
      if(LoadCloseSellPattern1(inStart)) return true;
    }
//---
    return false;
//---

  } 
//+------------------------------------------------------------------+
//| Verify pattern 1 open position                                   |
//+------------------------------------------------------------------+
bool Strategy::Pattern1Open(long brand)
  { 
//---
    int inStart=1;
    long kind=brand;
    if(kind==POSITION_TYPE_BUY){
      if(LoadOpenBuyPattern1(inStart)) return true;
    }else{
      if(LoadOpenSellPattern1(inStart)) return true;
    }
//---
    return false;
//---

  } 
//+------------------------------------------------------------------+
//| Verify pattern 2 open position                                   |
//+------------------------------------------------------------------+
bool Strategy::Pattern2Open(long brand)
  { 
//---
    int inStart=1;
    long kind=brand;
    if(kind==POSITION_TYPE_BUY){
      if(LoadOpenBuyPattern2(inStart)) return true;
    }else{
      if(LoadOpenSellPattern2(inStart)) return true;
    }
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify pattern fibonacci open position                           |
//+------------------------------------------------------------------+
bool Strategy::PatternFibonacciOpen(long brand)
  { 
//---
    int inStart=1;
    long kind=brand;
    if(kind==POSITION_TYPE_BUY){
      if(LoadOpenBuyFibonacci(inStart)) return true;
    }else{
      if(LoadOpenSellFibonacci(inStart)) return true;
    }
//---
    return false;
//---

  }   
//+------------------------------------------------------------------+
//| Verify pattern high                                              |
//+------------------------------------------------------------------+
bool Strategy::PatternHigh()
  { 
    int inStart=0;
    inStart=2;
    if(LoadOpenHigh(inStart)) return true;
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify pattern low                                               |
//+------------------------------------------------------------------+
bool Strategy::PatternLow()
  {
    int inStart=0;
    inStart=2;
    if(LoadOpenLow(inStart)) return true;
//---
    return false;
//---
    
  }
//+------------------------------------------------------------------+
//| Load open high pattern                                           |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenHigh(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Descriptive *descriptive;
    descriptive=new Descriptive(quantity,"DESCRIPTIVE");
    const double meansize=descriptive.MeanSize(quantity);
    const double meanbody=descriptive.MeanBody(quantity);
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    double inOpen=0,inClose=0;
    long inVolume=0;
    inOpen=iOpen(_Symbol,_Period,1);
    inClose=iClose(_Symbol,_Period,1);
    inVolume=iVolume(_Symbol,_Period,1);
    CandleStick *candleStick;
    candleStick=new CandleStick();
    const bool green=candleStick.green(inOpen,inClose);
//---
    const bool save=true;
    const int quantitymean=quantity;
    const int max=quantity-10;
    string value="buy";
    const string insymbol=(string)_Symbol;
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=26;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    if(thread.VerifyHaramiHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"HARAMI HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[0]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"HARAMI HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyHammer(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"HAMMER",insymbol,intimenow,value,"TRUE",inVolume);
        account[1]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"HAMMER",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyHammerInverted(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"HAMMER INVERTED",insymbol,intimenow,value,"TRUE",inVolume);
        account[2]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"HAMMER INVERTED",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyEngulfmentHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"ENFULFMENT HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[3]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"ENGULFMENT HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyPiercingLine(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"PIERCING LINE",insymbol,intimenow,value,"TRUE",inVolume);
        account[4]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"PIERCING LINE",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyMorningStar(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"MORNING STAR",insymbol,intimenow,value,"TRUE",inVolume);
        account[5]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"MORNING STAR",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifySeatBeltHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"SEAT BELT HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[6]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SEAT BELT HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---      
    if(thread.VerifyCarrierPigeon(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"CARRIER PIGEON",insymbol,intimenow,value,"TRUE",inVolume);
        account[7]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"CARRIER PIGEON",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyLineLow(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"LINE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[8]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"LINE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyMeetingLineHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"MEETING LINE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[9]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"MEETING LINE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyStickSandwich(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"STICK SANDWICH",insymbol,intimenow,value,"TRUE",inVolume);
        account[10]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"STICK SANDWICH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifySouthernStar(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"SOUTHERN STAR",insymbol,intimenow,value,"TRUE",inVolume);
        account[11]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SOUTHERN STAR",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyTripleStarHigh(quantity,intimenow,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"TRIPLE STAR HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[12]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"TRIPLE STAR HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeRiverHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"THREE RIVER HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[13]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE RIVER HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyInterruptionHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"INTERRUPTION HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[14]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"INTERRUPTION HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyLadderHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"LADEER HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[15]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"LADDER HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyKickingHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"KICKING HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[16]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"KICKING HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyAbandonedBabyHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"ABANDONE BABY HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[17]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"ABANDONE BABY HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeInsideHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"THREE INSIDE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[18]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE INSIDE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeOutside(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"THREE OUTSIDE",insymbol,intimenow,value,"TRUE",inVolume);
        account[19]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE OUTSIDE",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeSoldierHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"THREE SOLDIER HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[20]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE SOLDIER HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyBabySwallowedHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"BABY SWALLOWED HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[21]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"BABY SWALLOWED HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifySplitLineHigh(quantity,intimenow,meanbody,start)) {
      if (green) {
        sqlite.SaveChoise(intimenow,"SPLIT LINE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[22]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SPLIT LINE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyStrikeHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"STRIKE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[23]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"STRIKE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyTasukiGapHigh(quantity,intimenow,meanbody,start)) { //meansize
      if (green) {
        sqlite.SaveChoise(intimenow,"TASUKI GAP HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[24]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"TASUKI GAP HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---  
    if(thread.VerifyWhiteLineSideBySideHigh(quantity,intimenow,start)){
      if (green) {
        sqlite.SaveChoise(intimenow,"WHITE LINE SIDE BY SIDE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[25]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"WHITE LINE SIDE BY SIDE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    }
//---
    for(int i=0; i<account_max; i++) 
      if (account[i]==TRUE) 
        return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Load open low pattern                                            |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenLow(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Descriptive *descriptive;
    descriptive=new Descriptive(quantity,"DESCRIPTIVE");
    const double meansize=descriptive.MeanSize(quantity);
    const double meanbody=descriptive.MeanBody(quantity);
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    double inOpen=0,inClose=0;
    long inVolume=0;
    inOpen=iOpen(_Symbol,_Period,1);
    inClose=iClose(_Symbol,_Period,1);
    inVolume=iVolume(_Symbol,_Period,1);
    CandleStick *candleStick;
    candleStick=new CandleStick();
    const bool red=candleStick.red(inOpen,inClose);
//---
    const bool save=true;
    const int quantitymean=quantity;
    const int max=quantity-10;
    string value="sell";
    const string insymbol=(string)_Symbol;
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=24;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    if(thread.VerifyHaramiLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"HARAMI LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[0]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"HARAMI LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyShootingStar(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"SHOOTING START",insymbol,intimenow,value,"TRUE",inVolume);
        account[1]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SHOOTING START",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyHanged(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"HANGED",insymbol,intimenow,value,"TRUE",inVolume);
        account[2]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"HANGED",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyEngulfmentLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"ENGULFMENT LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[3]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"ENGULFMENT LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyBlackCloud(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"BLACK CLOUD",insymbol,intimenow,value,"TRUE",inVolume);
        account[4]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"BLACK CLOUD",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyEveningStar(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"EVENING STAR",insymbol,intimenow,value,"TRUE",inVolume);
        account[5]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"EVENING STAR",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifySeatBeltLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"SEAT BELT LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[6]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SEAT BELT LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyDescendingFalcon(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"DESCENDING FALCON",insymbol,intimenow,value,"TRUE",inVolume);
        account[7]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"DESCENDING FALCON",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyLineHigh(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"LINE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
        account[8]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"LINE HIGH",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyMeetingLineLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"MEETING LINE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[9]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"MEETING LINE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyAdvancedLock(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"ADVANCED LOCK",insymbol,intimenow,value,"TRUE",inVolume);
        account[10]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"ADVANCED LOCK",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyTripleStarLow(quantity,intimenow,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"TRIPLE STAR LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[11]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"TRIPLE STAR LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyTwoCrow(quantity,intimenow,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"TWO CROW",insymbol,intimenow,value,"TRUE",inVolume);
        account[12]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"TWO CROW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyInterruptionLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"INTERRUPTION LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[13]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"INTERRUPTION LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyLadderLow(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"LADDER LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[14]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"LADDER LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyKickingLow(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"KICKING LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[15]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"KICKING LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyAbandonedBabyLow(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"ABANDONE BABY LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[16]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"ABANDONE BABY LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeInsideLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"THREE INSIDE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[17]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE INSIDE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyThreeSoldierLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"THREE SOLDIER LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[18]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"THREE SOLDIER LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyBabySwallowedLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"BABY SWALLOWED LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[19]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"BABY SWALLOWED LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifySplitLineLow(quantity,intimenow,meanbody,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"SPLIT LINE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[20]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"SPLIT LINE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyStrikeLow(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"STRIKE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[21]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"STRIKE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyTasukiGapLow(quantity,intimenow,meanbody,start)) { //meansize
      if (red) {
        sqlite.SaveChoise(intimenow,"TASUKI GAP LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[22]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"TASUKI GAP LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    if(thread.VerifyWhiteLineSideBySideLow(quantity,intimenow,start)) {
      if (red) {
        sqlite.SaveChoise(intimenow,"WHITE LINE SIDE BY SIDE LOW",insymbol,intimenow,value,"TRUE",inVolume);
        account[23]=TRUE;
        //return true;
      } else {
        sqlite.SaveChoise(intimenow,"WHITE LINE SIDE BY SIDE LOW",insymbol,intimenow,value,"FALSE",inVolume);
      };    
    };
//---
    for(int i=0; i<account_max; i++) 
      if (account[i]==TRUE) 
        return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Load pattern close buy                                           |
//+------------------------------------------------------------------+
bool Strategy::LoadCloseBuyPattern1(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="buy";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=3;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---    
    if(thread.VerifyOverBought(quantity,intimenow,start)) {
      sqlite.SaveChoise(intimenow,"RSI OVERBOUGHT",insymbol,intimenow,value,"TRUE",inVolume);
      account[1]=TRUE;
    };    
//---
    for(int i=0; i<account_max; i++) 
      if((account[0]==TRUE) && (account[1]==TRUE)) 
        return true;
//---
    return false;
//---    

  }
//+------------------------------------------------------------------+
//| Load pattern close sell                                          |
//+------------------------------------------------------------------+
bool Strategy::LoadCloseSellPattern1(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="sell";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=2;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    if(thread.VerifyOverSold(quantity,intimenow,start)) {
      sqlite.SaveChoise(intimenow,"RSI OVERSOLD",insymbol,intimenow,value,"TRUE",inVolume);
      account[1]=TRUE;
    };    
//---
    for(int i=0; i<account_max; i++) 
      if ((account[0]==TRUE) && (account[1]==TRUE)) 
        return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Load pattern 1 open buy                                          |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenBuyPattern1(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="buy";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=7;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    if(thread.VerifyHistogramHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"MACD BREAKUP",insymbol,intimenow,value,"TRUE",inVolume);
      account[0]=TRUE;
    };
//---    
    if(thread.VerifyRSIHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"RSI RUPTURE DOWN",insymbol,intimenow,value,"TRUE",inVolume);
      account[1]=TRUE;
    };
//---    
    if(thread.VerifyRuptureHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"OBV ABOVE MME10",insymbol,intimenow,value,"TRUE",inVolume);
      account[2]=TRUE;
    };
//---    
    if(thread.VerifyHighAverage(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"VOLUME ABOVE AVERAGE",insymbol,intimenow,value,"TRUE",inVolume);
      account[3]=TRUE;
    };            
//---    
    if(thread.VerifyMovingMeanHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"MMS21 ABOVE MMS200",insymbol,intimenow,value,"TRUE",inVolume);
      account[4]=TRUE;
    };                
//---    
    if(thread.VerifyTrendHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"TREND HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[5]=TRUE;
    };                    
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if(cumulate==6) return true;
//---
    return false;
//---    

  }
//+------------------------------------------------------------------+
//| Load pattern 1 open sell                                         |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenSellPattern1(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="sell";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=7;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    if(thread.VerifyHistogramLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"MACD BREAKDOWN",insymbol,intimenow,value,"TRUE",inVolume);
      account[0]=TRUE;
    };
//---    
    if(thread.VerifyRSILow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"RSI RUPTURE TOP",insymbol,intimenow,value,"TRUE",inVolume);
      account[1]=TRUE;
    };    
//---    
    if(thread.VerifyRuptureLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"OBV BELOW LOW",insymbol,intimenow,value,"TRUE",inVolume);
      account[2]=TRUE;
    };        
//---    
    if(thread.VerifyLowAverage(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"VOLUME BELOW AVERAGE",insymbol,intimenow,value,"TRUE",inVolume);
      account[3]=TRUE;
    };            
//---    
    if(thread.VerifyMovingMeanLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"MMS21 BELOW MMS200",insymbol,intimenow,value,"TRUE",inVolume);
      account[4]=TRUE;
    };
//---    
    if(thread.VerifyTrendLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"TREND LOW",insymbol,intimenow,value,"TRUE",inVolume);
      account[5]=TRUE;
    };                    
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if(cumulate==6) return true;
//---
    return false;
//---    

  }  
//+------------------------------------------------------------------+
//| Load pattern 2 open buy                                          |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenBuyPattern2(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Descriptive *descriptive;
    descriptive=new Descriptive(quantity,"DESCRIPTIVE");
    const double meanbody=descriptive.MeanBody(quantity);
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="buy";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=22;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---    
    if(thread.VerifyTrendLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"TREND LOW",insymbol,intimenow,value,"TRUE",inVolume);
      account[0]=TRUE;
    };                    
//---
    if(thread.VerifyHaramiHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"HARAMI HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[1]=TRUE;
    };
//---
    if(thread.VerifyHammer(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"HAMMER",insymbol,intimenow,value,"TRUE",inVolume);
      account[2]=TRUE;
    };
//---
    if(thread.VerifyHammerInverted(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"HAMMER INVERTED",insymbol,intimenow,value,"TRUE",inVolume);
      account[3]=TRUE;
    };
//---        
    if(thread.VerifyEngulfmentHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"ENFULFMENT HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[4]=TRUE;
    };    
//---
    if(thread.VerifyPiercingLine(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"PIERCING LINE",insymbol,intimenow,value,"TRUE",inVolume);
      account[5]=TRUE;
    };
//---
    if(thread.VerifyMorningStar(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"MORNING STAR",insymbol,intimenow,value,"TRUE",inVolume);
      account[6]=TRUE;
    };
//---
    if(thread.VerifySeatBeltHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"SEAT BELT HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[7]=TRUE;
    };
//---      
    if(thread.VerifyCarrierPigeon(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"CARRIER PIGEON",insymbol,intimenow,value,"TRUE",inVolume);
      account[8]=TRUE;
    };
//---
    if(thread.VerifyLineLow(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"LINE LOW",insymbol,intimenow,value,"TRUE",inVolume);
      account[9]=TRUE;
    };
//---
    if(thread.VerifyMeetingLineHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"MEETING LINE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[10]=TRUE;
    };
//---
    if(thread.VerifyStickSandwich(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"STICK SANDWICH",insymbol,intimenow,value,"TRUE",inVolume);
      account[11]=TRUE;
    };
//---
    if(thread.VerifySouthernStar(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"SOUTHERN STAR",insymbol,intimenow,value,"TRUE",inVolume);
      account[12]=TRUE;
    };
//---
    if(thread.VerifyTripleStarHigh(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"TRIPLE STAR HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[13]=TRUE;
    };
//---
    if(thread.VerifyThreeRiverHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"THREE RIVER HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[14]=TRUE;
    };
//---
    if(thread.VerifyInterruptionHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"INTERRUPTION HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[15]=TRUE;
    };
//---
    if(thread.VerifyLadderHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"LADEER HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[16]=TRUE;
    };
//---
    if(thread.VerifyKickingHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"KICKING HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[17]=TRUE;
    };
//---
    if(thread.VerifyAbandonedBabyHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"ABANDONE BABY HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[18]=TRUE;
    };
//---
    if(thread.VerifyThreeInsideHigh(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"THREE INSIDE HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[19]=TRUE;
    };
//---
    if(thread.VerifyThreeOutside(quantity,intimenow,meanbody,start)){
      sqlite.SaveChoise(intimenow,"THREE OUTSIDE",insymbol,intimenow,value,"TRUE",inVolume);
      account[20]=TRUE;
    };
//---
    if(thread.VerifyBabySwallowedHigh(quantity,intimenow,meanbody,start)) {
      sqlite.SaveChoise(intimenow,"BABY SWALLOWED HIGH",insymbol,intimenow,value,"TRUE",inVolume);
      account[21]=TRUE;
    };    
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if((account[0]==TRUE) && (cumulate==2)) return true;
//---
    return false;
//---    

  }
//+------------------------------------------------------------------+
//| Load pattern 2 open sell                                         |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenSellPattern2(const int start)
  {
//---    
    const int quantity=100;
    const string intimenow=TimeToString(TimeCurrent());
//---
    Descriptive *descriptive;
    descriptive=new Descriptive(quantity,"DESCRIPTIVE");
    const double meanbody=descriptive.MeanBody(quantity);
//---
    Thread *thread;
    thread=new Thread();
    int inStart=0;
//---
    const bool save=true;
    const string insymbol=(string)_Symbol;
    long inVolume=0;
    inVolume=iVolume(_Symbol,_Period,1);
    string value="sell";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=2;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---    
    if(thread.VerifyTrendLow(quantity,intimenow,start)){
      sqlite.SaveChoise(intimenow,"TREND LOW",insymbol,intimenow,value,"TRUE",inVolume);
      account[5]=TRUE;
    };                    
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if((account[0]==TRUE) && (cumulate==2)) return true;
//---
    return false;
//---    

  }
//+------------------------------------------------------------------+
//| Load pattern fibonacci open buy                                  |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenBuyFibonacci(const int start)
  {
//---    
    const int inquantity=50;
    const string intimenow=TimeToString(TimeCurrent());
//---
    int instart=start;
//---
    Thread *thread;
    thread=new Thread();
//---
    const string insymbol=(string)_Symbol;
    long involume=iVolume(_Symbol,_Period,instart);
    string inkind="buy";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=2;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---    
    if(thread.VerifyTrendHigh(inquantity,intimenow,instart)){
      sqlite.SaveChoise(intimenow,"TREND HIGH",insymbol,intimenow,inkind,"TRUE",involume);
      account[0]=TRUE;
    };                    
//---
/*
    if(thread.VerifyFibonacciHigh(inquantity,intimenow,instart)){
      sqlite.SaveChoise(intimenow,"FIBONACCI HIGH",insymbol,intimenow,inkind,"TRUE",involume);
      account[1]=TRUE;
    };
*/                        
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if(cumulate==1) return true;
//---
    return false;
//---    

  }
//+------------------------------------------------------------------+
//| Load pattern fibonacci open sell                                  |
//+------------------------------------------------------------------+
bool Strategy::LoadOpenSellFibonacci(const int start)
  {
//---    
    const int inquantity=50;
    const string intimenow=TimeToString(TimeCurrent());
//---
    int instart=start;
//---
    Thread *thread;
    thread=new Thread();
//---
    const string insymbol=(string)_Symbol;
    long involume=iVolume(_Symbol,_Period,instart);
    string inkind="sell";
//---
    enum ENUM_SINAL {TRUE=1, FALSE=-1, ZERO=0};
    ENUM_SINAL account[];
    int account_max=2;
    ArrayResize(account,account_max);
    for(int i=0; i<account_max; i++) account[i]=FALSE;
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---    
    if(thread.VerifyTrendLow(inquantity,intimenow,instart)){
      sqlite.SaveChoise(intimenow,"TREND LOW",insymbol,intimenow,inkind,"TRUE",involume);
      account[0]=TRUE;
    };                    
//---
/*    
    if(thread.VerifyFibonacciLow(inquantity,intimenow,instart)){
      sqlite.SaveChoise(intimenow,"FIBONACCI LOW",insymbol,intimenow,inkind,"TRUE",involume);
      account[1]=TRUE;
    };                    
*/
//---
    int cumulate=0;
    for(int i=0; i<account_max; i++) 
      if(account[i]==TRUE)
        cumulate++;
    if(cumulate==1) return true;
//---
    return false;
//---    

  }  
//+------------------------------------------------------------------+