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
class MovingAverageStick
  {
    private:

    public:
      int position;
      double macd;
      double histogram;
      double mme;
      MovingAverageStick();
      ~MovingAverageStick();
      void Add(const int inposition, const double inmacd, const double inhistogram, const double inmme);
      bool histogrampositive(const double inhistogram);
      bool histogramnegative(const double inhistogram);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
MovingAverageStick::MovingAverageStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
MovingAverageStick::~MovingAverageStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void MovingAverageStick::Add(const int inposition, const double inmacd, const double inhistogram, const double inmme)
  {
    this.position=inposition;
    this.macd=inmacd;
    this.histogram=inhistogram;
    this.mme=inmme;
  }
//+------------------------------------------------------------------+
//| Verify histogram positive                                        |
//+------------------------------------------------------------------+
bool MovingAverageStick::histogrampositive(const double inhistogram)
  {
    if(histogram>0) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify histogram negative                                        |
//+------------------------------------------------------------------+
bool MovingAverageStick::histogramnegative(const double inhistogram)
  {
    if(histogram<0) return true;
    return false;
  }  
//+------------------------------------------------------------------+
