//+------------------------------------------------------------------+
//|                                                   TradeStick.mqh |
//|             Copyright 2026, César Cardoso Silva & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class TrendStick
  {
    private:
      int position;
      double endurance;
      double support;
      string time;
    
    public:
      int getPosition(); 
      double getEndurance();
      double getSupport();
      string getTime();
      TrendStick();
      ~TrendStick();
      void Add(const int inposition,const double inendurance,const double insupport,const string intime);
      bool green(const double inopen,const double inclose);
      bool red(const double inopen,const double inclose);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
TrendStick::TrendStick()
  {
    this.position=NULL;
    this.endurance=NULL;
    this.support=NULL;
    this.time=NULL;
//---

  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
TrendStick::~TrendStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void TrendStick::Add(const int inposition,const double inendurance,const double insupport,const string intime)
  {
    this.position=inposition;
    this.endurance=inendurance;
    this.support=insupport;
    this.time=intime;
//---

  }
//+------------------------------------------------------------------+
//| Verify green                                                     |
//+------------------------------------------------------------------+
bool TrendStick::green(const double inopen,const double inclose)
  {
    if(inopen<inclose) return true;
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify red                                                       |
//+------------------------------------------------------------------+
bool TrendStick::red(const double inopen,const double inclose)
  {
    if(inopen>inclose) return true;
    return false;
//---

  }  
//+------------------------------------------------------------------+
//| Get properts                                                     |
//+------------------------------------------------------------------+
int TrendStick::getPosition() 
  {
    return this.position;
  }  
double TrendStick::getEndurance() 
  {
    return this.endurance;
  }  
double TrendStick::getSupport() 
  {
    return this.support;
  }  
string TrendStick::getTime() 
  {
    return this.time;
  }        
//+------------------------------------------------------------------+
