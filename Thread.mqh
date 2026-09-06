//+------------------------------------------------------------------+
//|                                                       Thread.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Trade/SymbolInfo.mqh>
#include "Golang.mqh"
#include "Statistic\Descriptive.mqh"
//#include "Pattern\SpinningTop.mqh"
#include "Pattern\Harami.mqh"
#include "Pattern\Hammer.mqh"
#include "Pattern\ShootingStar.mqh"
#include "Pattern\HammerInverted.mqh"
#include "Pattern\Hanged.mqh"
#include "Pattern\Engulfment.mqh"
#include "Pattern\PiercingLine.mqh"
#include "Pattern\BlackCloud.mqh"
#include "Pattern\MorningStar.mqh"
#include "Pattern\EveningStar.mqh"
#include "Pattern\SeatBelt.mqh"
#include "Pattern\DescendingFalcon.mqh"
#include "Pattern\CarrierPigeon.mqh"
#include "Pattern\Line.mqh"
#include "Pattern\MeetingLine.mqh"
#include "Pattern\StickSandwich.mqh"
#include "Pattern\SouthernStar.mqh"
#include "Pattern\AdvancedLock.mqh"
#include "Pattern\TripleStar.mqh"
#include "Pattern\ThreeRiverHigh.mqh"
#include "Pattern\TwoCrow.mqh"
#include "Pattern\Interruption.mqh"
#include "Pattern\Ladder.mqh"
#include "Pattern\Kicking.mqh"
#include "Pattern\AbandonedBaby.mqh"
#include "Pattern\ThreeInside.mqh"
#include "Pattern\ThreeOutside.mqh"
#include "Pattern\ThreeSoldier.mqh"
#include "Pattern\BabySwallowed.mqh"
#include "Pattern\SplitLine.mqh"
#include "Pattern\Strike.mqh"
#include "Pattern\TasukiGap.mqh"
#include "Pattern\WhiteLineSideBySide.mqh"
#include "Pattern\OnBalanceVolume.mqh"
#include "Pattern\MACD.mqh"
#include "Pattern\RelativeStrengthIndex.mqh"
#include "Pattern\StochasticOscillator.mqh"
#include "Pattern\BandBollinger.mqh"
#include "Pattern\Trend.mqh"
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class Thread
  {
    private:

    protected:
      
    public:
      Thread();
      ~Thread();
//--- verify current
      bool VerifyHaramiHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyHaramiLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyHammer(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyShootingStar(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyHammerInverted(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyHanged(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyEngulfmentHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyEngulfmentLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyPiercingLine(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyBlackCloud(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyMorningStar(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyEveningStar(const int quantity,const string intimenow,const double average,const int start);
      bool VerifySeatBeltHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifySeatBeltLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyDescendingFalcon(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyCarrierPigeon(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyLineHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyLineLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyMeetingLineHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyMeetingLineLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyStickSandwich(const int quantity,const string intimenow,const double average,const int start);
      bool VerifySouthernStar(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyAdvancedLock(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyTripleStarHigh(const int quantity,const string intimenow,const int start);
      bool VerifyTripleStarLow(const int quantity,const string intimenow,const int start);
      bool VerifyThreeRiverHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyTwoCrow(const int quantity,const string intimenow,const int start);
      bool VerifyInterruptionHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyInterruptionLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyLadderHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyLadderLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyKickingHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyKickingLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyAbandonedBabyHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyAbandonedBabyLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyThreeInsideHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyThreeInsideLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyThreeOutside(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyThreeSoldierHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyThreeSoldierLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyBabySwallowedHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyBabySwallowedLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifySplitLineHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifySplitLineLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyStrikeHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyStrikeLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyTasukiGapHigh(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyTasukiGapLow(const int quantity,const string intimenow,const double average,const int start);
      bool VerifyWhiteLineSideBySideHigh(const int quantity,const string intimenow,const int start);
      bool VerifyWhiteLineSideBySideLow(const int quantity,const string intimenow,const int start);
      bool VerifySupport(const int quantity,const string intimenow,const int start);
      bool VerifyEndurance(const int quantity,const string intimenow,const int start);
      bool VerifyDown(const int quantity,const string intimenow,const int start);
      bool VerifyUp(const int quantity,const string intimenow,const int start);
      bool VerifyRuptureHigh(const int quantity,const string intimenow,const int start);
      bool VerifyRuptureLow(const int quantity,const string intimenow,const int start);
      bool VerifyHistogramLow(const int quantity,const string intimenow,const int start);
      bool VerifyHistogramHigh(const int quantity,const string intimenow,const int start);
      bool VerifyOverBought(const int quantity,const string intimenow,const int start);
      bool VerifyOverSold(const int quantity,const string intimenow,const int start);
      bool VerifyStochasticOverBought(const int quantity,const string intimenow,const int start);      
      bool VerifyStochasticOverSold(const int quantity,const string intimenow,const int start);   
      bool VerifyBollingerOpening(const int quantity,const string intimenow,const int start);
      bool VerifyBollingerClosing(const int quantity,const string intimenow,const int start);
      bool VerifyTrendHigh(const int quantity,const string intimenow,const int start);
      bool VerifyTrendLow(const int quantity,const string intimenow,const int start);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Thread::Thread()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Thread::~Thread()
  {
  }
//+------------------------------------------------------------------+
//| Verify pattern harami high                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyHaramiHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="HARAMI HIGH";
//---    
    Harami *harami;
    harami=new Harami(quantity,inpattern);
//---   
    if(harami.High(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern harami low                                        |
//+------------------------------------------------------------------+
bool Thread::VerifyHaramiLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="HARAMI LOW";
//---    
    Harami *harami;
    harami=new Harami(quantity,inpattern);
//---   
    if(harami.Low(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern hammer                                            |
//+------------------------------------------------------------------+
bool Thread::VerifyHammer(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="HAMMER";
//---    
    Hammer *hammer;
    hammer=new Hammer(quantity,inpattern);
//---   
    if(hammer.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern hanged                                            |
//+------------------------------------------------------------------+
bool Thread::VerifyHammerInverted(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="HAMMER INVERTED";
//---    
    HammerInverted *hammerinverted;
    hammerinverted=new HammerInverted(quantity,inpattern);
//---   
    if(hammerinverted.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern shooting star                                     |
//+------------------------------------------------------------------+
bool Thread::VerifyShootingStar(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SHOOTING STAR";
//---    
    ShootingStar *shootingstar;
    shootingstar=new ShootingStar(quantity,inpattern);
//---   
    if(shootingstar.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern hanged                                            |
//+------------------------------------------------------------------+
bool Thread::VerifyHanged(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="HANGED";
//---    
    Hanged *hanged;
    hanged=new Hanged(quantity,inpattern);
//---   
    if(hanged.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern engulfment high                                   |
//+------------------------------------------------------------------+
bool Thread::VerifyEngulfmentHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="ENGULFMENT HIGH";
//---    
    Engulfment *engulfment;
    engulfment=new Engulfment(quantity,inpattern);
//---   
    if(engulfment.High(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern engulfment low                                    |
//+------------------------------------------------------------------+
bool Thread::VerifyEngulfmentLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="ENGULFMENT LOW";
//---    
    Engulfment *engulfment;
    engulfment=new Engulfment(quantity,inpattern);
//---   
    if(engulfment.Low(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern piercing line                                     |
//+------------------------------------------------------------------+
bool Thread::VerifyPiercingLine(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="PIERCING LINE";
//---    
    PiercingLine *piercingline;
    piercingline=new PiercingLine(quantity,inpattern);
//---   
    if(piercingline.Main(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern black cloud                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyBlackCloud(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="BLACK CLOUD";
//---    
    BlackCloud *blackcloud;
    blackcloud=new BlackCloud(quantity,inpattern);
//---   
    if(blackcloud.Main(start,intimenow,save,average)) return true;
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify pattern morning star                                      |
//+------------------------------------------------------------------+
bool Thread::VerifyMorningStar(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="MORNING STAR";
//---    
    MorningStar *morningstar;
    morningstar=new MorningStar(quantity,inpattern);
//---   
    if(morningstar.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern evening star                                      |
//+------------------------------------------------------------------+
bool Thread::VerifyEveningStar(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="EVENING STAR";
//---    
    EveningStar *eveningstar;
    eveningstar=new EveningStar(quantity,inpattern);
//---   
    if(eveningstar.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern seat belt high                                    |
//+------------------------------------------------------------------+
bool Thread::VerifySeatBeltHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SEAT BELT HIGH";
//---    
    SeatBelt *seatbelt;
    seatbelt=new SeatBelt(quantity,inpattern);
//---   
    if(seatbelt.High(start,intimenow,save,average)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern seat belt low                                     |
//+------------------------------------------------------------------+
bool Thread::VerifySeatBeltLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SEAT BELT LOW";
//---    
    SeatBelt *seatbelt;
    seatbelt=new SeatBelt(quantity,inpattern);
//---   
    if(seatbelt.Low(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern descending falcon                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyDescendingFalcon(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="DESCENDING FALCON";
//---    
    DescendingFalcon *descendingfalcon;
    descendingfalcon=new DescendingFalcon(quantity,inpattern);
//---   
    if(descendingfalcon.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern carrier pigeon                                    |
//+------------------------------------------------------------------+
bool Thread::VerifyCarrierPigeon(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="CARRIER PIGEON";
//---    
    CarrierPigeon *carrierpigeon;
    carrierpigeon=new CarrierPigeon(quantity,inpattern);
//---   
    if(carrierpigeon.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern line high                                         |
//+------------------------------------------------------------------+
bool Thread::VerifyLineHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="LINE HIGH";
//---    
    Line *line;
    line=new Line(quantity,inpattern);
//---   
    if(line.High(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern line low                                          |
//+------------------------------------------------------------------+
bool Thread::VerifyLineLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="LINE LOW";
//---    
    Line *line;
    line=new Line(quantity,inpattern);
//---   
    if(line.Low(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern meeting line high                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyMeetingLineHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="MEETING LINE HIGH";
//---    
    MeetingLine *meetingline;
    meetingline=new MeetingLine(quantity,inpattern);
//---   
    if(meetingline.High(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern meeting line low                                  |
//+------------------------------------------------------------------+
bool Thread::VerifyMeetingLineLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="MEETING LINE LOW";
//---    
    MeetingLine *meetingline;
    meetingline=new MeetingLine(quantity,inpattern);
//---   
    if(meetingline.Low(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern stick sandwich                                    |
//+------------------------------------------------------------------+
bool Thread::VerifyStickSandwich(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="STICK SANDWICH";
//---    
    StickSandwich *sticksandwich;
    sticksandwich=new StickSandwich(quantity,inpattern);
//---   
    if(sticksandwich.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern southern star                                     |
//+------------------------------------------------------------------+
bool Thread::VerifySouthernStar(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SOUTHERN STAR";
//---    
    SouthernStar *southernstar;
    southernstar=new SouthernStar(quantity,inpattern);
//---   
    if(southernstar.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern advanced lock                                     |
//+------------------------------------------------------------------+
bool Thread::VerifyAdvancedLock(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="ADVANCED LOCK";
//---    
    AdvancedLock *advancedlock;
    advancedlock=new AdvancedLock(quantity,inpattern);
//---   
    if(advancedlock.Main(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern triple star high                                  |
//+------------------------------------------------------------------+
bool Thread::VerifyTripleStarHigh(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TRIPLE STAR HIGH";
//---    
    TripleStar *triplestar;
    triplestar=new TripleStar(quantity,inpattern);
//---   
    if(triplestar.High(start,intimenow,save)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern triple star low                                   |
//+------------------------------------------------------------------+
bool Thread::VerifyTripleStarLow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TRIPLE STAR LOW";
//---    
    TripleStar *triplestar;
    triplestar=new TripleStar(quantity,inpattern);
//---   
    if(triplestar.Low(start,intimenow,save)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern three river high with hammer green or red              |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeRiverHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE RIVER HIGH";
//---    
    ThreeRiverHigh *threeriverhigh;
    threeriverhigh=new ThreeRiverHigh(quantity,inpattern);
//---   
    if(threeriverhigh.Main(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern two crow                                          |
//+------------------------------------------------------------------+
bool Thread::VerifyTwoCrow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TWO CROW";
//---    
    TwoCrow *twocrow;
    twocrow=new TwoCrow(quantity,inpattern);
//---   
    if(twocrow.Main(start,intimenow,save)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern interruption high                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyInterruptionHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="INTERRUPTION HIGH";
//---    
    Interruption *interruption;
    interruption=new Interruption(quantity,inpattern);
//---   
    if(interruption.High(start,intimenow,save,average)) return true;
//---
    return false;     
  }
//+------------------------------------------------------------------+
//| Verify pattern interruption low                                  |
//+------------------------------------------------------------------+
bool Thread::VerifyInterruptionLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="INTERRUPTION LOW";
//---    
    Interruption *interruption;
    interruption=new Interruption(quantity,inpattern);
//---   
    if(interruption.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern ladder high                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyLadderHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="LADDER HIGH";
//---    
    Ladder *ladder;
    ladder=new Ladder(quantity,inpattern);
//---   
    if(ladder.High(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern ladder low                                        |
//+------------------------------------------------------------------+
bool Thread::VerifyLadderLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="LADDER LOW";
//---    
    Ladder *ladder;
    ladder=new Ladder(quantity,inpattern);
//---   
    if(ladder.Low(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern kicking high                                      |
//+------------------------------------------------------------------+
bool Thread::VerifyKickingHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="KICKING HIGH";
//---    
    Kicking *kicking;
    kicking=new Kicking(quantity,inpattern);
//---   
    if(kicking.High(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern kicking low                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyKickingLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="KICKING LOW";
//---    
    Kicking *kicking;
    kicking=new Kicking(quantity,inpattern);
//---   
    if(kicking.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern abandoned baby high                               |
//+------------------------------------------------------------------+
bool Thread::VerifyAbandonedBabyHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="ABANDONED BABY HIGH";
//---    
    AbandonedBaby *abandonedbaby;
    abandonedbaby=new AbandonedBaby(quantity,inpattern);
//---   
    if(abandonedbaby.High(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern abandoned baby low                                |
//+------------------------------------------------------------------+
bool Thread::VerifyAbandonedBabyLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="ABANDONED BABY LOW";
//---    
    AbandonedBaby *abandonedbaby;
    abandonedbaby=new AbandonedBaby(quantity,inpattern);
//---   
    if(abandonedbaby.Low(start,intimenow,save,average)) return true;
//---
    return false;    
  }
//+------------------------------------------------------------------+
//| Verify pattern three inside high                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeInsideHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE INSIDE HIGH";
//---    
    ThreeInside *threeinside;
    threeinside=new ThreeInside(quantity,inpattern);
//---   
    if(threeinside.High(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern three inside low                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeInsideLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE INSIDE LOW";
//---    
    ThreeInside *threeinside;
    threeinside=new ThreeInside(quantity,inpattern);
//---   
    if(threeinside.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern three outside                                     |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeOutside(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE OUTSIDE";
//---    
    ThreeOutside *threeoutside;
    threeoutside=new ThreeOutside(quantity,inpattern);
//---   
    if(threeoutside.Main(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern three soldier high                                |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeSoldierHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE SOLDIER HIGH";
//---    
    ThreeSoldier *threesoldier;
    threesoldier=new ThreeSoldier(quantity,inpattern);
//---   
    if(threesoldier.High(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern three soldier low                                 |
//+------------------------------------------------------------------+
bool Thread::VerifyThreeSoldierLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="THREE SOLDIER LOW";
//---    
    ThreeSoldier *threesoldier;
    threesoldier=new ThreeSoldier(quantity,inpattern);
//---   
    if(threesoldier.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern baby swallowed high                               |
//+------------------------------------------------------------------+
bool Thread::VerifyBabySwallowedHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="BABY SWALLOWED HIGH";
//---    
    BabySwallowed *babyswallowed;
    babyswallowed=new BabySwallowed(quantity,inpattern);
//---   
    if(babyswallowed.High(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern baby swallowed low                                |
//+------------------------------------------------------------------+
bool Thread::VerifyBabySwallowedLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="BABY SWALLOWED LOW";
//---    
    BabySwallowed *babyswallowed;
    babyswallowed=new BabySwallowed(quantity,inpattern);
//---   
    if(babyswallowed.Low(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern split line high                                   |
//+------------------------------------------------------------------+
bool Thread::VerifySplitLineHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SPLIT LINE HIGH";
//---    
    SplitLine *splitline;
    splitline=new SplitLine(quantity,inpattern);
//---   
    if(splitline.High(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern split line low                                    |
//+------------------------------------------------------------------+
bool Thread::VerifySplitLineLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="SPLIT LINE LOW";
//---    
    SplitLine *splitline;
    splitline=new SplitLine(quantity,inpattern);
//---   
    if(splitline.Low(start,intimenow,save,average)) return true;
//---
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern strike high                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyStrikeHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="STRIKE HIGH";
//---    
    Strike *strike;
    strike=new Strike(quantity,inpattern);
//---   
    if(strike.High(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern strike low                                        |
//+------------------------------------------------------------------+
bool Thread::VerifyStrikeLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="STRIKE LOW";
//---    
    Strike *strike;
    strike=new Strike(quantity,inpattern);
//---   
    if(strike.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern tasuki gap high                                   |
//+------------------------------------------------------------------+
bool Thread::VerifyTasukiGapHigh(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TASUKI GAP HIGH";
//---    
    TasukiGap *tasukigap;
    tasukigap=new TasukiGap(quantity,inpattern);
//---   
    if(tasukigap.High(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern tasuki gap low                                    |
//+------------------------------------------------------------------+
bool Thread::VerifyTasukiGapLow(const int quantity,const string intimenow,const double average,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TASUKI GAP LOW";
//---    
    TasukiGap *tasukigap;
    tasukigap=new TasukiGap(quantity,inpattern);
//---   
    if(tasukigap.Low(start,intimenow,save,average)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern white line side by side high                      |
//+------------------------------------------------------------------+
bool Thread::VerifyWhiteLineSideBySideHigh(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="WHITE LINE SIDE BY SIDE HIGH";
//---    
    WhiteLineSideBySide *whitelinesidebyside;
    whitelinesidebyside=new WhiteLineSideBySide(quantity,inpattern);
//---   
    if(whitelinesidebyside.High(start,intimenow,save)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern white line side by side low                       |
//+------------------------------------------------------------------+
bool Thread::VerifyWhiteLineSideBySideLow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="WHITE LINE SIDE BY SIDE LOW";
//---    
    WhiteLineSideBySide *whitelinesidebyside;
    whitelinesidebyside=new WhiteLineSideBySide(quantity,inpattern);
//---   
    if(whitelinesidebyside.Low(start,intimenow,save)) return true;
//---
    return false; 
  }
//+------------------------------------------------------------------+
//| Verify pattern trend high                                        |
//+------------------------------------------------------------------+
bool Thread::VerifyTrendHigh(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TREND HIGH";
//---    
    Trend *trend;
    trend=new Trend(quantity,inpattern);
//---   
    if(trend.High(quantity,start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern trend low                                         |
//+------------------------------------------------------------------+
bool Thread::VerifyTrendLow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="TREND LOW";
//---    
    Trend *trend;
    trend=new Trend(quantity,inpattern);
//---   
    if(trend.Low(quantity,start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern rupture high                                      |
//+------------------------------------------------------------------+
bool Thread::VerifyRuptureHigh(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="OBV HIGH";
    const int inmme=10;
//---    
    OnBalanceVolume *onBalanceVolume;
    onBalanceVolume=new OnBalanceVolume(quantity,inpattern,inmme);
//---   
    if(onBalanceVolume.Low(start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern rupture low                                       |
//+------------------------------------------------------------------+
bool Thread::VerifyRuptureLow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="OBV LOW";
    const int inmme=10;
//---    
    OnBalanceVolume *onBalanceVolume;
    onBalanceVolume=new OnBalanceVolume(quantity,inpattern,inmme);
//---   
    if(onBalanceVolume.High(start,intimenow,save)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern histogram negative                                |
//+------------------------------------------------------------------+
bool Thread::VerifyHistogramLow(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="MACD LOW";
//---    
    MACD *mACD;
    mACD=new MACD(quantity,inpattern);
//---   
    if(mACD.Low(start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern histogram positive                                |
//+------------------------------------------------------------------+
bool Thread::VerifyHistogramHigh(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="MACD HIGH";
//---    
    MACD *mACD;
    mACD=new MACD(quantity,inpattern);
//---   
    if(mACD.High(start,intimenow,save)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify pattern overbought                                        |
//+------------------------------------------------------------------+
bool Thread::VerifyOverBought(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="RSI LOW";
    const int inmms=14;
//---    
    RelativeStrengthIndex *relativeStrengthIndex;
    relativeStrengthIndex=new RelativeStrengthIndex(quantity,inpattern,inmms);
//---   
    if(relativeStrengthIndex.Low(start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern oversold                                          |
//+------------------------------------------------------------------+
bool Thread::VerifyOverSold(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="RSI HIGH";
    const int inmms=14;
//---    
    RelativeStrengthIndex *relativeStrengthIndex;
    relativeStrengthIndex=new RelativeStrengthIndex(quantity,inpattern,inmms);
//---   
    if(relativeStrengthIndex.High(start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern stochastic overbought                             |
//+------------------------------------------------------------------+
bool Thread::VerifyStochasticOverBought(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="STOCHASTIC LOW";
    const int ink=8;
    const int inloopk=3;
    const int inquantity=100;
//---    
    StochasticOscillator *stochasticOscillator;
    stochasticOscillator=new StochasticOscillator(quantity,inpattern,ink,inloopk);
//---   
    if(stochasticOscillator.Low(start,intimenow,save,ink,inloopk,inquantity)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern stochastic oversold                               |
//+------------------------------------------------------------------+
bool Thread::VerifyStochasticOverSold(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="STOCHASTIC HIGH";
    const int ink=8;
    const int inloopk=3;
    const int inquantity=100;
//---    
    StochasticOscillator *stochasticOscillator;
    stochasticOscillator=new StochasticOscillator(quantity,inpattern,ink,inloopk);
//---   
    if(stochasticOscillator.High(start,intimenow,save,ink,inloopk,inquantity)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern band bollinger opening                            |
//+------------------------------------------------------------------+
bool Thread::VerifyBollingerOpening(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="BOLLINGER OPENING";
    const int inquantity=100;
//---    
    BandBollinger *bandBollinger;
    bandBollinger=new BandBollinger(quantity,inpattern);
//---   
    if(bandBollinger.Open(start,intimenow,save)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify pattern band bollinger closing                            |
//+------------------------------------------------------------------+
bool Thread::VerifyBollingerClosing(const int quantity,const string intimenow,const int start)
  {
//---
    const bool save=true;
    const string inpattern="BOLLINGER CLOSING";
    const int inquantity=100;
//---    
    BandBollinger *bandBollinger;
    bandBollinger=new BandBollinger(quantity,inpattern);
//---   
    if(bandBollinger.Close(start,intimenow,save)) return true;
    return false;
  }   
//+------------------------------------------------------------------+
