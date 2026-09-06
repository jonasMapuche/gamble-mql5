//+------------------------------------------------------------------+
//|                                                  CandleStick.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "../SQlite.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class CandleStick
  {
    private:
  
    protected:
      //CandleStick *candlehigh;
      double open;
      double close;
      double high;
      double low;
      string time;
      double volume;
      string pattern;
      string symbol;
      //CandleStick *candlelow;
    
    public:
      CandleStick();
      ~CandleStick();
      void Save(double inHigh,double inOpen,double inClose,double inLow,string inTime,double inVolume,string inpattern,string insymbol);
      double getHigh();
      double getOpen();
      double getClose();
      double getLow();
      string getTime();
      string getPattern();
      string getSymbol();
      double getVolume();
//---
      bool green(const double inopen,const double inclose);
      bool red(const double inopen,const double inclose);
//---
      string GetTypeCandle(int retcode);
      string GetRuleCandle(int retcode);
//---
      bool longred(const double inopen2,const double inclose2,const double value);
      bool longgreen(const double inopen2,const double inclose2,const double value);
//---
      bool insidebodygreen(const double inopen2,const double inclose2,const double inhigh1,const double inlow1);
      bool insidebodyred(const double inopen2,const double inclose2,const double inhigh1,const double inlow1);
//---
      bool hammergreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent);
      bool hammerred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent);
      bool hammerinvertedgreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent);
      bool hammerinvertedred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent);
//---
      bool engulfmentgreen(const double inhigh2,const double inlow2,const double inopen1,const double inclose1);
      bool engulfmentred(const double inhigh2,const double inlow2,const double inopen1,const double inclose1);
//---
      bool abovehalfred(const double inhigh2,const double inlow2,const double inclose1);
      bool belowhalfgreen(const double inhigh2,const double inlow2,const double inclose1);
      bool abovehalfbodyred(const double inopen2,const double inclose2,const double inclose1);
      bool belowhalfbodygreen(const double inopen2,const double inclose2,const double inclose1);
//---
      bool morningstargreen(const double inclose3,const double inclose2,const double inopen2,const double inopen1);
      bool morningstarred(const double inclose3,const double inclose2,const double inopen2,const double inopen1);
//---
      bool eveningstargreen(const double inclose3,const double inopen2,const double inclose2,const double inopen1);
      bool eveningstarred(const double inclose3,const double inopen2,const double inclose2,const double inopen1);
//---
      bool sealtbeltgreen(const double inopen1,const double inclose1,const double inlow1,const double percent);
      bool sealtbeltred(const double inhigh1,const double inopen1,const double inclose1,const double percent);
//---
      bool linered(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent);
      bool linegreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent);
//---
      bool meetingline(const double inclose2,const double inclose1,const double percent);
//---
      bool marubozured(const double inhigh,const double inopen,const double inclose,const double inlow,const double percent);
      bool marubozugreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double percent);
//---
      bool longlegred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent);
//---
      bool dojired(const double inopen,const double inclose,const double percent);
      bool dojigreen(const double inopen,const double inclose,const double percent);
//---
      bool equalopengreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent);     
      bool equalopenred(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent); 
//---
      bool equalopengreenred(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent);
      bool equalopenredgreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent);
//---
      bool support(const double insupport,const double inopen, const double inclose);
      bool endurance(const double inendurance,const double inopen, const double inclose);
  };
//+------------------------------------------------------------------+
//| Constructor class initialize                                     |
//+------------------------------------------------------------------+
CandleStick::CandleStick()
  {
    //this.candlehigh=NULL;
    this.open=NULL;
    this.close=NULL; 
    this.high=NULL;
    this.low=NULL;
    this.time=NULL;
    this.volume=NULL;
    this.pattern=NULL;
    this.symbol=NULL;
    //this.candlelow=NULL;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CandleStick::~CandleStick()
  {
  }
//+------------------------------------------------------------------+
//| Save load candlestick                                            |
//+------------------------------------------------------------------+
void CandleStick::Save(double inHigh,double inOpen,double inClose,double inLow,string inTime,double inVolume,string inpattern,string insymbol)
  {
    //this.candlehigh=NULL;
    this.high=inHigh;
    this.open=inOpen;
    this.close=inClose;
    this.low=inLow;
    this.time=inTime;
    this.volume=inVolume;
    this.pattern=inpattern;
    this.symbol=insymbol;
    //this.candlelow=NULL;
  }
//+------------------------------------------------------------------+
//| Get properts                                                     |
//+------------------------------------------------------------------+
double CandleStick::getHigh() 
  {
    return this.high;
  }
double CandleStick::getOpen() 
  {
    return this.open;
  }
double CandleStick::getClose() 
  {
    return this.close;
  }
double CandleStick::getLow() 
  {
    return this.low;  
  }
string CandleStick::getTime() 
  {
    return this.time;  
  }
string CandleStick::getPattern() 
  {
    return this.pattern;  
  }
string CandleStick::getSymbol() 
  {
    return this.symbol;  
  }
double CandleStick::getVolume() 
  {
    return this.volume;  
  }
//+------------------------------------------------------------------+
//| Decoder type candle                                              |
//+------------------------------------------------------------------+
string CandleStick::GetTypeCandle(int retcode)
  {
    switch(retcode)
    {
      case 1001: return("body"); break;
      case 1002: return("small body"); break;
      case 1003: return("long body"); break;
      case 1004: return("hammer"); break;
      case 1005: return("inverted hammer"); break;
      case 1006: return("marubozu"); break;
      case 1007: return("doji"); break;
      case 1008: return("sealt belt"); break;
      case 1009: return("long lower shadow"); break;
      default: return("unknown"); break;
    }
    return NULL;
  }
//+------------------------------------------------------------------+
//| Decoder rule candle                                              |
//+------------------------------------------------------------------+
string CandleStick::GetRuleCandle(int retcode)
  {
    switch(retcode)
    {
      case 2000: return("neutral"); break;
      case 2001: return("downtrend"); break;
      case 2002: return("uptrend"); break;
      case 2011: return("open below the low on the candle 1"); break;
      case 2012: return("open below the low on the candle 2"); break;
      case 2021: return("open below the open on the candle 1"); break;
      case 2022: return("open below the open on the candle 2"); break;
      case 2023: return("open below the open on the candle 3"); break;
      case 2024: return("open below the open on the candle 4"); break;
      case 2025: return("open below the open on the candle 5"); break;
      case 2031: return("open equal the open on the candle 1"); break;
      case 2032: return("open equal the open on the candle 2"); break;
      case 2041: return("open above the high on the candle 1"); break;
      case 2042: return("open above the high on the candle 2"); break;
      case 2051: return("open above the open on the candle 1"); break;
      case 2052: return("open above the open on the candle 2"); break;
      case 2053: return("open above the open on the candle 3"); break;
      case 2054: return("open above the open on the candle 4"); break;
      case 2055: return("open above the open on the candle 5"); break;
      case 2061: return("close above on the half on the candle 1"); break;
      case 2062: return("close above on the half on the candle 2"); break;
      case 2063: return("close above on the half on the candle 3"); break;
      case 2071: return("close above the high of the candle 1"); break;
      case 2072: return("close above the high of the candle 2"); break;
      case 2073: return("close above the high of the candle 3"); break;
      case 2081: return("close above the open of the candle 1"); break;
      case 2082: return("close above the open of the candle 2"); break;
      case 2083: return("close above the open of the candle 3"); break;
      case 2084: return("close above the open of the candle 4"); break;
      case 2091: return("close above the close of the candle 1"); break;
      case 2092: return("close above the close of the candle 2"); break;
      case 2093: return("close above the close of the candle 3"); break;
      case 2094: return("close above the close of the candle 4"); break;
      case 2095: return("close above the close of the candle 5"); break;
      case 2101: return("close below the close of the candle 1"); break;
      case 2102: return("close below the close of the candle 2"); break;
      case 2103: return("close below the close of the candle 3"); break;
      case 2104: return("close below the close of the candle 4"); break;
      case 2105: return("close below the close of the candle 5"); break;
      case 2111: return("close below the open of the candle 1"); break;
      case 2112: return("close below the open of the candle 2"); break;
      case 2113: return("close below the open of the candle 3"); break;
      case 2114: return("close below the open of the candle 4"); break;
      case 2121: return("close below on the half on the candle 1"); break;
      case 2122: return("close below on the half on the candle 2"); break;
      case 2123: return("close below on the half on the candle 3"); break;
      case 2131: return("close equal the close of the candle 1"); break;
      case 2132: return("close equal the close of the candle 2"); break;
      case 2133: return("close equal the close of the candle 3"); break;
      case 2141: return("high above the high on the candle 1"); break;
      case 2142: return("high above the high on the candle 2"); break;
      case 2143: return("high above the high on the candle 3"); break;
      case 2151: return("open below the close on the candle 1"); break;
      case 2152: return("open below the close on the candle 2"); break;
      case 2153: return("open below the close on the candle 3"); break;
      case 2161: return("high below the open of the candle 1"); break;
      case 2162: return("high below the open of the candle 2"); break;
      case 2171: return("low above the low of the candle 1"); break;
      case 2172: return("low above the low of the candle 2"); break;
      case 2173: return("low above the low of the candle 3"); break;
      case 2181: return("low above the high of the candle 1"); break;
      case 2182: return("low above the high of the candle 2"); break;
      case 2183: return("low above the high of the candle 3"); break;
      case 2191: return("low below the close of the candle"); break;
      case 2201: return("inside body of the candle 1"); break;
      case 2202: return("inside body of the candle 2"); break;
      case 2203: return("inside body of the candle 3"); break;
      case 2211: return("body covering up the candle 1"); break;
      case 2212: return("body covering up the candle 2"); break;
      case 2213: return("body covering up the candle 3"); break;
      case 2221: return("body below the close of the candle 1"); break;
      case 2222: return("body below the close of the candle 2"); break;
      case 2223: return("body below the close of the candle 3"); break;
      case 2231: return("body below the open of the candle 1"); break;
      case 2232: return("body below the open of the candle 2"); break;
      case 2241: return("body above the close of the candle 1"); break;
      case 2242: return("body above the close of the candle 2"); break;
      case 2243: return("body above the close of the candle 3"); break;
      case 2251: return("body above the open of the candle 1"); break;
      case 2261: return("candle below the low of the candle 1"); break;
      case 2262: return("candle below the low of the candle 2"); break;
      case 2263: return("candle below the low of the candle 3"); break;
      case 2271: return("candle above the high of the candle 1"); break;
      case 2272: return("candle above the high of the candle 2"); break;
      case 2273: return("candle above the high of the candle 3"); break;
      case 2281: return("low above the close of the candle 1"); break;
      case 2282: return("low above the close of the candle 2"); break;
      case 2283: return("low above the close of the candle 3"); break;
      case 2284: return("low above the close of the candle 4"); break;
      case 2285: return("low above the close of the candle 5"); break;
      case 2291: return("high below the close of the candle 1"); break;
      case 2292: return("high below the close of the candle 2"); break;
      case 2293: return("high below the close of the candle 3"); break;
      case 2294: return("high below the close of the candle 4"); break;
      case 2295: return("high below the close of the candle 5"); break;
      case 2301: return("close below the low of the candle 1"); break;
      case 2302: return("close below the low of the candle 2"); break;
      case 2303: return("close below the low of the candle 3"); break;
      case 2311: return("open above the close on the candle 1"); break;
      case 2312: return("open above the close on the candle 2"); break;
      default: return("unknown"); break;
    }
    return NULL;
  }
//+------------------------------------------------------------------+
//| Verify candle gree                                               |
//+------------------------------------------------------------------+
bool CandleStick::green(const double inopen,const double inclose)
  {
    if(inclose>=inopen) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify candle red                                                |
//+------------------------------------------------------------------+
bool CandleStick::red(const double inopen,const double inclose)
  {
    if(inopen>inclose) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify long red                                                  |
//+------------------------------------------------------------------+
bool CandleStick::longred(const double inopen2,const double inclose2,const double value)
  {
    if((inopen2-inclose2)>=value){
      return true;  
    }      
    return false;
  }
//+------------------------------------------------------------------+
//| Verify long green                                                |
//+------------------------------------------------------------------+
bool CandleStick::longgreen(const double inopen2,const double inclose2,const double value)
  {
    if((inclose2-inopen2)>=value)
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify inside body red                                           |
//+------------------------------------------------------------------+
bool CandleStick::insidebodyred(const double inopen2,const double inclose2,const double inhigh1,const double inlow1)
  {
    if(
        (inhigh1<=inopen2) 
        && 
        (inlow1>=inclose2)
        &&
        (inclose2<inopen2)
      )
      return true;  
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify inside body green                                         |
//+------------------------------------------------------------------+
bool CandleStick::insidebodygreen(const double inopen2,const double inclose2,const double inhigh1,const double inlow1)
  {
    if(
        (inhigh1<=inclose2) 
        && 
        (inlow1>=inopen2)
        &&
        (inclose2>inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify hammer green                                              |
//+------------------------------------------------------------------+
bool CandleStick::hammergreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent)
  {
    double div=3;
    double size=(inhigh-inlow)/div;
    double inhighdown3=inhigh-(inhigh*percent);
    double inhighdown30=inhigh-size;
    if(
        ((inhigh-inlow)>value)
        &&
        (
          (inclose<=inhigh)
          &&
          (inclose>=inhighdown3)
        )
        &&
        (inopen>=inhighdown30) 
        &&
        (inclose>inopen)
      )
      return true;
    return false;
  }  
//+------------------------------------------------------------------+
//| Verify hammer red                                                |
//+------------------------------------------------------------------+
bool CandleStick::hammerred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent)
  {
    double div=3;
    double size=(inhigh-inlow)/div;
    double inhighdown3=inhigh-(inhigh*percent);
    double inhighdown30=inhigh-size;
    if(
        ((inhigh-inlow)>value)
        &&
        (
          (inopen<=inhigh)
          &&
          (inopen>=inhighdown3)
        )
        &&
        (inclose>=inhighdown30) 
        &&
        (inclose<inopen)
      )
      return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify inverted hammer green                                     |
//+------------------------------------------------------------------+
bool CandleStick::hammerinvertedgreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent)
  {
    double div=3;
    double size=(inhigh-inlow)/div;
    double inlowup3=inlow+(inlow*percent);
    double inlowup30=inlow+size;
    if(
        ((inhigh-inlow)>value)
        &&
        (
          (inopen>=inlow)
          &&
          (inopen<=inlowup3)
        )
        &&
        (inclose<=inlowup30) 
        &&
        (inclose>inopen)
      )
      return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify inverted hammer red                                       |
//+------------------------------------------------------------------+
bool CandleStick::hammerinvertedred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent)
  {
    double div=3;
    double size=(inhigh-inlow)/div;
    double inlowup3=inlow+(inlow*percent);
    double inlowup30=inlow+size;
    if(
        ((inhigh-inlow)>value)
        &&
        (
          (inclose>=inlow)
          &&
          (inclose<=inlowup3)
        )
        &&
        (inopen<=inlowup30) 
        &&
        (inclose<inopen)
      )
      return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify engulfment green                                          |
//+------------------------------------------------------------------+
bool CandleStick::engulfmentgreen(const double inhigh2,const double inlow2,const double inopen1,const double inclose1)
  {
    if(
        (inhigh2<=inclose1) 
        && 
        (inlow2>=inopen1)
        &&
        (inclose1>inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify engulfment red                                            |
//+------------------------------------------------------------------+
bool CandleStick::engulfmentred(const double inhigh2,const double inlow2,const double inopen1,const double inclose1)
  {
    if(
        (inhigh2<=inopen1) 
        && 
        (inlow2>=inclose1)
        &&
        (inclose1<inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify close above half red                                      |
//+------------------------------------------------------------------+
bool CandleStick::abovehalfred(const double inhigh2,const double inlow2,const double inclose1)
  {  
    if(inclose1>(((inhigh2-inlow2)/2)+inlow2))
      return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify close above half body red                                      |
//+------------------------------------------------------------------+
bool CandleStick::abovehalfbodyred(const double inopen2,const double inclose2,const double inclose1)
  {  
    if(inclose1>(((inopen2-inclose2)/2)+inclose2))
      return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify close below half green                                    |
//+------------------------------------------------------------------+
bool CandleStick::belowhalfgreen(const double inhigh2,const double inlow2,const double inclose1)
  {  
    if(inclose1<(((inhigh2-inlow2)/2)+inlow2))
      return true;
    return false;
  } 
//+------------------------------------------------------------------+
//| Verify close below half body green                               |
//+------------------------------------------------------------------+
bool CandleStick::belowhalfbodygreen(const double inopen2,const double inclose2,const double inclose1)
  {  
    if(inclose1<(((inclose2-inopen2)/2)+inopen2))
      return true;
    return false;
  }   
//+------------------------------------------------------------------+
//| Verify morning star green                                        |
//+------------------------------------------------------------------+
bool CandleStick::morningstargreen(const double inclose3,const double inclose2,const double inopen2,const double inopen1)
  {
    if(
        (inclose3>inclose2)
        &&
        (inopen1>inclose2)
        &&
        (inclose2>inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify morning star red                                          |
//+------------------------------------------------------------------+
bool CandleStick::morningstarred(const double inclose3,const double inopen2,const double inclose2,const double inopen1)
  {
    if(
        (inclose3>inopen2)
        &&
        (inopen1>inopen2)
        && 
        (inclose2<inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify evening star green                                        |
//+------------------------------------------------------------------+
bool CandleStick::eveningstargreen(const double inclose3,const double inopen2,const double inclose2,const double inopen1)
  {
    if(
        (inclose3<inopen2)
        &&
        (inopen1<inopen2)
        &&
        (inclose2>inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify evening star red                                          |
//+------------------------------------------------------------------+
bool CandleStick::eveningstarred(const double inclose3,const double inopen2,const double inclose2,const double inopen1)
  {
    if(
        (inclose3<inclose2)
        &&
        (inopen1<inclose2)
        &&
        (inclose2<inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify sealt belt green                                          |
//+------------------------------------------------------------------+
bool CandleStick::sealtbeltgreen(const double inopen1,const double inclose1,const double inlow1,const double percent)
  {
    double inlow1up3=inlow1+(inlow1*percent);
    if(
        (inopen1>=inlow1)
        &&
        (inopen1<=inlow1up3) 
        &&
        (inclose1>inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify sealt belt red                                            |
//+------------------------------------------------------------------+
bool CandleStick::sealtbeltred(const double inhigh1,const double inopen1,const double inclose1,const double percent)
  {
    double inhigh1down3=inhigh1-(inhigh1*percent);
    if(
        (inopen1<=inhigh1)
        &&
        (inopen1>=inhigh1down3) 
        &&
        (inclose1<inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify alignment both close red                                  |
//+------------------------------------------------------------------+
bool CandleStick::linered(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inclose1up=inclose1+(inclose1*percent);
    double inclose1down=inclose1-(inclose1*percent);
    double inclose2up=inclose2+(inclose2*percent);
    double inclose2down=inclose2-(inclose2*percent);
    if(
        (
          (
            (inclose1>=inclose2down)
            &&
            (inclose1<=inclose2up)
          )
          ||
          (
            (inclose2>=inclose1down)
            &&
            (inclose2<=inclose1up)
          )
        )
        &&
        (inclose1<inopen1)
        && 
        (inclose2<inopen2)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify alignment both close green                                |
//+------------------------------------------------------------------+
bool CandleStick::linegreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inclose1up=inclose1+(inclose1*percent);
    double inclose1down=inclose1-(inclose1*percent);
    double inclose2up=inclose2+(inclose2*percent);
    double inclose2down=inclose2-(inclose2*percent);
    if(
        (
          (
            (inclose1<=inclose2up)
            &&
            (inclose1>=inclose2down)
          )
          ||
          (
            (inclose2<=inclose1up)
            &&
            (inclose2>=inclose1down)
          )
        )
        &&
        (inclose1>inopen1)
        &&
        (inclose2>inopen2)
      )    
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify alignment close                                           |
//+------------------------------------------------------------------+
bool CandleStick::meetingline(const double inclose2,const double inclose1,const double percent)
  {
    double inclose1up=inclose1+(inclose1*percent);
    double inclose1down=inclose1-(inclose1*percent);
    double inclose2up=inclose2+(inclose2*percent);
    double inclose2down=inclose2-(inclose2*percent);
    if(
        (
          (inclose1<=inclose2up)
          &&
          (inclose1>=inclose2down)
        )
        ||
        (
          (inclose2>=inclose1down)
          &&
          (inclose2<=inclose1up)
        )
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify marubozu red                                              |
//+------------------------------------------------------------------+
bool CandleStick::marubozured(const double inhigh,const double inopen,const double inclose,const double inlow,const double percent)
  {
    double inhighdown=inhigh-(inhigh*percent);
    double inlowup=inlow+(inlow*percent);
    if(
        (
          (inopen<=inhigh)
          &&
          (inopen>=inhighdown)
        )
        &&
        (
          (inclose>=inlow)
          &&
          (inclose<=inlowup)
        )            
        &&
        (inclose<inopen)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify marubozu green                                            |
//+------------------------------------------------------------------+
bool CandleStick::marubozugreen(const double inhigh,const double inopen,const double inclose,const double inlow,const double percent)
  {
    double inhighdown=inhigh-(inhigh*percent);
    double inlowup=inlow+(inlow*percent);
    if(
        (
          (inclose<=inhigh)
          &&
          (inclose>=inhighdown)
        )
        &&
        (
          (inopen>=inlow)
          &&
          (inopen<=inlowup)
        )
        &&
        (inclose>inopen)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify long leg red                                              |
//+------------------------------------------------------------------+
bool CandleStick::longlegred(const double inhigh,const double inopen,const double inclose,const double inlow,const double value,const double percent)
  {
    double div=3;
    double size=(inhigh-inlow)/div;
    double leg=(inlow+size);
    double leg3=leg+(leg*percent);
    if(
        ((inhigh-inlow)>value)
        &&
        (
          (inclose>=leg)
          &&
          (inclose<=leg3)
        )
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify doji red                                                  |
//+------------------------------------------------------------------+
bool CandleStick::dojired(const double inopen,const double inclose,const double percent)
  {
    double inopendown=(inopen-(inopen*percent));
    double incloseup=(inclose+(inclose*percent));
    if(
        (
          (
            (inopen>=inclose)
            &&
            (inopen<=incloseup)
          )
          ||
          (
            (inclose<=inopen)
            &&
            (inclose>=inopendown)
          )
        )
        &&
        (inclose<inopen)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify dojis green                                        |
//+------------------------------------------------------------------+
bool CandleStick::dojigreen(const double inopen,const double inclose,const double percent)
  {
    double inopenup=inopen+(inopen*percent);
    double inclosedown=inclose-(inclose*percent);
    if(
        (
          (
            (inopen<=inclose)
            &&
            (inopen>=inclosedown)
          )
          ||
          (
            (inclose>=inopen)
            &&
            (inclose<=inopenup)
          )
        )
        &&
        (inclose>=inopen)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify equal open green                                          |
//+------------------------------------------------------------------+
bool CandleStick::equalopengreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inopen1up=inopen1+(inopen1*percent);
    double inopen1down=inopen1-(inopen1*percent);
    double inopen2up=inopen2+(inopen2*percent);
    double inopen2down=inopen2-(inopen2*percent);
    if(
        (
          (
            (inopen1<=inopen2up)
            &&
            (inopen1>=inopen2down)
          )
          ||
          (
            (inopen2>=inopen1down)
            &&
            (inopen2<=inopen1up)
          )
        ) 
        &&
        (inclose2>inopen2)
        &&
        (inclose1>inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify equal open red                                            |
//+------------------------------------------------------------------+
bool CandleStick::equalopenred(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inopen1up=inopen1+(inopen1*percent);
    double inopen1down=inopen1-(inopen1*percent);
    double inopen2up=inopen2+(inopen2*percent);
    double inopen2down=inopen2-(inopen2*percent);
    if(
        (
          (
            (inopen1>=inopen2down)
            &&
            (inopen1<=inopen2up)
          )
          ||
          (
            (inopen2<=inopen1up)
            &&
            (inopen2>=inopen1down)
          )
        )
        &&
        (inclose2<inopen2)
        &&
        (inclose1<inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify equal open green and red                                  |
//+------------------------------------------------------------------+
bool CandleStick::equalopengreenred(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inopen1up=inopen1+(inopen1*percent);
    double inopen1down=inopen1-(inopen1*percent);
    double inopen2up=inopen2+(inopen2*percent);
    double inopen2down=inopen2-(inopen2*percent);
    if(
        (
          (
            (inopen1<=inopen2up)
            &&
            (inopen1>=inopen2down)
          )
          ||
          (
            (inopen2>=inopen1down)
            &&
            (inopen2<=inopen1up)
          )
        ) 
        &&
        (inclose2<inopen2)
        &&
        (inclose1>inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify equal open red and green                                  |
//+------------------------------------------------------------------+
bool CandleStick::equalopenredgreen(const double inopen2,const double inclose2,const double inopen1,const double inclose1,const double percent)
  {
    double inopen1up=inopen1+(inopen1*percent);
    double inopen1down=inopen1-(inopen1*percent);
    double inopen2up=inopen2+(inopen2*percent);
    double inopen2down=inopen2-(inopen2*percent);
    if(
        (
          (
            (inopen1>=inopen2down)
            &&
            (inopen1<=inopen2up)
          )
          ||
          (
            (inopen2<=inopen1up)
            &&
            (inopen2>=inopen1down)
          )
        )
        &&
        (inclose2>inopen2)
        &&
        (inclose1<inopen1)
      )
      return true;  
    return false;
  }
//+------------------------------------------------------------------+
//| Verify support                                                   |
//+------------------------------------------------------------------+
bool CandleStick::support(const double insupport,const double inopen, const double inclose)
  {
    if((inclose<insupport) && (inopen<insupport)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify endurance                                                 |
//+------------------------------------------------------------------+
bool CandleStick::endurance(const double inendurance,const double inopen, const double inclose)
  {
    if((inclose>inendurance) && (inopen>inendurance)) return true;
    return false;
  }
//+------------------------------------------------------------------+
