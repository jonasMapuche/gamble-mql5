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
class RelativeStrengthStick
  {
    private:

    public:
      int position;
      double strength;
      RelativeStrengthStick();
      ~RelativeStrengthStick();
      void Add(const int inposition, const double instrength);
      bool overbought(const double invalue);
      bool oversold(const double invalue);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
RelativeStrengthStick::RelativeStrengthStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
RelativeStrengthStick::~RelativeStrengthStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void RelativeStrengthStick::Add(const int inposition, const double instrength)
  {
    this.position=inposition;
    this.strength=instrength;
  }
//+------------------------------------------------------------------+
//| Verify overbought                                                |
//+------------------------------------------------------------------+
bool RelativeStrengthStick::overbought(const double invalue)
  {
    if(invalue>70) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify oversold                                                  |
//+------------------------------------------------------------------+
bool RelativeStrengthStick::oversold(const double invalue)
  {
    if(invalue<30) return true;
    return false;
  }
//+------------------------------------------------------------------+
