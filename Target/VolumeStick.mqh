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
      double mms;
      double volume;
      VolumeStick();
      ~VolumeStick();
      void Add(const int inposition,const double inbalance,const double inmme,const double inmms,const double involume);
      bool rupturehigh(const double inbalance,const double inmme);
      bool rupturelow(const double inbalance,const double inmme);
      bool highaverage(const double involume,const double inmms);
      bool lowaverage(const double involume,const double inmms);
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
void VolumeStick::Add(const int inposition,const double inbalance,const double inmme,const double inmms,const double involume)
  {
    this.position=inposition;
    this.balance=inbalance;
    this.mme=inmme;
    this.mms=inmms;
    this.volume=involume;
//---

  }
//+------------------------------------------------------------------+
//| Verify high rupture                                              |
//+------------------------------------------------------------------+
bool VolumeStick::rupturehigh(const double inbalance,const double inmme)
  {
    if(inbalance>inmme) return true;
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify low rupture                                               |
//+------------------------------------------------------------------+
bool VolumeStick::rupturelow(const double inbalance,const double inmme)
  {
    if(inbalance<inmme) return true;
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify high average                                              |
//+------------------------------------------------------------------+
bool VolumeStick::highaverage(const double involume,const double inmms)
  {
    if(involume>inmms) return true;
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify low average                                              |
//+------------------------------------------------------------------+
bool VolumeStick::lowaverage(const double involume,const double inmms)
  {
    if(involume>inmms) return true;
    return false;
//---

  }    
//+------------------------------------------------------------------+

