//+------------------------------------------------------------------+
//|                                                PositionStick.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
class PositionStick
  {
    private:

    public:
      ulong ticket;
      string symbol;
      long kind;
      double volume;
      double bid;
      double ask;
      double price;
      double profit;
      double sl;
      PositionStick();
      ~PositionStick();
      void Add(const ulong inticket,const string insymbol,const long inkind,const double involume,const double inbid,const double inask,const double inprice,const double inprofit,const double insl);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PositionStick::PositionStick()
  {
    this.ticket=NULL;
    this.symbol=NULL;
    this.kind=NULL;
    this.volume=NULL;
    this.bid=NULL;
    this.ask=NULL;
    this.price=NULL;
    this.profit=NULL;
    this.sl=NULL;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PositionStick::~PositionStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void PositionStick::Add(const ulong inticket,const string insymbol,const long inkind,const double involume,const double inbid,const double inask,const double inprice,const double inprofit,const double insl)
  {
    this.ticket=inticket;
    this.symbol=insymbol;
    this.kind=inkind;
    this.volume=involume;
    this.bid=inbid;
    this.ask=inask;
    this.price=inprice;
    this.profit=inprofit;
    this.sl=insl;
  }
//+------------------------------------------------------------------+
