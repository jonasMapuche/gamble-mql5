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
#include <Trade/SymbolInfo.mqh>
#include "Golang.mqh"
#include "Thread.mqh"
#include "CandleStick.mqh"
#include "SQlite.mqh"
//+------------------------------------------------------------------+
//| Class Router                                                     |
//+------------------------------------------------------------------+
class Strategy
  {
    private:
//---
      bool LoadHigh(const int start);
      bool LoadLow(const int start);
    public:
      Strategy();
      ~Strategy();
//---
      bool PatternHigh();
      bool PatternLow();
      
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
//| Verify pattern high                                              |
//+------------------------------------------------------------------+
bool Strategy::PatternHigh()
  { 
    int inStart=0;
    inStart=2;
    if(LoadHigh(inStart)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern low                                               |
//+------------------------------------------------------------------+
bool Strategy::PatternLow()
  {
    int inStart=0;
    inStart=2;
    if(LoadLow(inStart)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Load high pattern                                                |
//+------------------------------------------------------------------+
bool Strategy::LoadHigh(const int start)
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
//| Load low pattern                                                 |
//+------------------------------------------------------------------+
bool Strategy::LoadLow(const int start)
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
