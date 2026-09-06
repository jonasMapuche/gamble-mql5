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
    
    public:
      int position;
      double endurance;
      double support;
      int sequence;
      TrendStick();
      ~TrendStick();
      void Add(const int inposition, const double inendurance, const double insupport, const int insequence);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
TrendStick::TrendStick()
  {
    this.position=NULL;
    this.endurance=NULL;
    this.support=NULL;
    this.sequence=NULL;
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
void TrendStick::Add(const int inposition, const double inendurance, const double insupport, const int insequence)
  {
    this.position=inposition;
    this.endurance=inendurance;
    this.support=insupport;
    this.sequence=insequence;
  }
//+------------------------------------------------------------------+
