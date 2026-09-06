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
class StochasticStick
  {
    private:

    public:
      int position;
      double percentK;
      double percentd;
      StochasticStick();
      ~StochasticStick();
      void Add(const int inposition, const double inpercentk, const double inpercentd);
      bool overbought(const double inpercentk, const double inpercetd);
      bool oversold(const double inpercentk, const double inpercetd);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
StochasticStick::StochasticStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
StochasticStick::~StochasticStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void StochasticStick::Add(const int inposition, const double inpercentk, const double inpercentd)
  {
    this.position=inposition;
    this.percentK=inpercentk;
    this.percentd=inpercentd;
  }
//+------------------------------------------------------------------+
//| Verify overbought                                                |
//+------------------------------------------------------------------+
bool StochasticStick::overbought(const double inpercentk, const double inpercetd)
  {
    if((inpercentk>80) && (inpercetd>80)) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify oversold                                                  |
//+------------------------------------------------------------------+
bool StochasticStick::oversold(const double inpercentk, const double inpercetd)
  {
    if((inpercentk<20) && (inpercetd<20)) return true;
    return false;
  } 
//+------------------------------------------------------------------+
