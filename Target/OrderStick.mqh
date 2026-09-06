//+------------------------------------------------------------------+
//|                                                   TradeStick.mqh |
//|             Copyright 2026, César Cardoso Silva & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class OrderStick
  {
    private:
      enum ENUM_SINAL {COMPRA = 1, VENDA = -1, NULO = 0};

    public:
      long order;
      double price;
      double profit;
      double stoploss;
      int sequence;
      string contract;
      OrderStick();
      ~OrderStick();
      void Add(const long inorder, const double inprice, const double inprofit, const double instoploss, const int insequence, const string incontract);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
OrderStick::OrderStick()
  {
    this.order=NULL;
    this.price=NULL;
    this.profit=NULL;
    this.stoploss=NULL;
    this.sequence=NULL;
    this.contract=NULL;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
OrderStick::~OrderStick()
  {
  }
//+------------------------------------------------------------------+
//| Add item                                                         |
//+------------------------------------------------------------------+
void OrderStick::Add(const long inorder, const double inprice, const double inprofit, const double instoploss, const int insequence, const string incontract)
  {
    this.order=inorder;
    this.price=inprice;
    this.profit=inprofit;
    this.stoploss=instoploss;
    this.sequence=insequence;
    this.contract=incontract;
  }
//+------------------------------------------------------------------+
