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
class BandBollingerStick
  {
    private:

    public:
      int position;
      double bandup;
      double mms;
      double banddown;
      BandBollingerStick();
      ~BandBollingerStick();
      void Add(const int inposition,const double inbandup,const double inmms,const double inbanddown);
      double bollingermean(const double inup,const double inmms);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
BandBollingerStick::BandBollingerStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
BandBollingerStick::~BandBollingerStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void BandBollingerStick::Add(const int inposition,const double inbandup,const double inmms,const double inbanddown)
  {
    this.position=inposition;
    this.bandup=inbandup;
    this.mms=inmms;
    this.banddown=inbanddown;
  }
//+------------------------------------------------------------------+
//| Verify mean                                                      |
//+------------------------------------------------------------------+
double BandBollingerStick::bollingermean(const double inup,const double inmms)
  {
    double mean=((inup-inmms)/inmms)*100;
    return mean;
  }
//+------------------------------------------------------------------+
