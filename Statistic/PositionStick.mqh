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
      long position;
      double price;
      double profit;
      double stoploss;
      string contract;
      PositionStick();
      ~PositionStick();
      void Add(const long inposition, const double inprice, const double inprofit, const double instoploss, const string incontract);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PositionStick::PositionStick()
  {
    this.position=NULL;
    this.price=NULL;
    this.profit=NULL;
    this.stoploss=NULL;
    this.contract=NULL;
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
void PositionStick::Add(const long inposition, const double inprice, const double inprofit, const double instoploss, const string incontract)
  {
    this.position=inposition;
    this.price=inprice;
    this.profit=inprofit;
    this.stoploss=instoploss;
    this.contract=incontract;
  }
//+------------------------------------------------------------------+
