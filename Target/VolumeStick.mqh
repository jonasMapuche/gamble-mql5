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
class VolumeStick
  {
    private:

    public:
      int position;
      double balance;
      double mme;
      VolumeStick();
      ~VolumeStick();
      void Add(const int inposition, const double inbalance, const double inmme);
      bool rupturehigh(const double inbalance,const double inmme);
      bool rupturelow(const double inbalance,const double inmme);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
VolumeStick::VolumeStick()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
VolumeStick::~VolumeStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void VolumeStick::Add(const int inposition, const double inbalance, const double inmme)
  {
    this.position=inposition;
    this.balance=inbalance;
    this.mme=inmme;
  }
//+------------------------------------------------------------------+
//| Verify high rupture                                              |
//+------------------------------------------------------------------+
bool VolumeStick::rupturehigh(const double inbalance,const double inmme)
  {
    if(inbalance>inmme) return true;
    return false;
  }
//+------------------------------------------------------------------+
//| Verify low rupture                                               |
//+------------------------------------------------------------------+
bool VolumeStick::rupturelow(const double inbalance,const double inmme)
  {
    if(inbalance<inmme) return true;
    return false;
  }
//+------------------------------------------------------------------+

