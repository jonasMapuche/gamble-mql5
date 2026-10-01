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
class MovingMeanStick
  {
    private:

    public:
      int position;
      double mms21;
      double mms200;
      MovingMeanStick();
      ~MovingMeanStick();
      void Add(const int inposition, const double inmms21,const double inmms200);
      bool movingmeanhigh(const double inmms21,const double inmms200);
      bool movingmeanlow(const double inmms21,const double inmms200);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
MovingMeanStick::MovingMeanStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
MovingMeanStick::~MovingMeanStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void MovingMeanStick::Add(const int inposition,const double inmms21,const double inmms200)
  {
    this.position=inposition;
    this.mms21=inmms21;
    this.mms200=inmms200;
  }
//+------------------------------------------------------------------+
//| Verify moving mean high                                          |
//+------------------------------------------------------------------+
bool MovingMeanStick::movingmeanhigh(const double inmms21,const double inmms200)
  {
    if(inmms21>inmms200) return true;
    return false;
  }    
//+------------------------------------------------------------------+
//| Verify moving mean low                                          |
//+------------------------------------------------------------------+
bool MovingMeanStick::movingmeanlow(const double inmms21,const double inmms200)
  {
    if(inmms21<inmms200) return true;
    return false;
  }    
//+------------------------------------------------------------------+
