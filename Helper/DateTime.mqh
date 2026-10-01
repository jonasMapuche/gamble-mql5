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
class DateTime
  {
    private:

    public:
      DateTime();
      ~DateTime();
      datetime OnlyDate(const string value);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
DateTime::DateTime()
  {
//---

  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
DateTime::~DateTime()
  {
//---

  }
//+------------------------------------------------------------------+
//| Mount date without time                                          |
//+------------------------------------------------------------------+
datetime DateTime::OnlyDate(const string value) 
  {
//---
    datetime value_date=StringToTime(value);
    MqlDateTime structDate;
    TimeToStruct(value_date, structDate);
    structDate.hour=0;
    structDate.min=0;
    structDate.sec=0;
    datetime only_date = StructToTime(structDate);
//---
    return only_date;
//---
    
  }   
 
//+------------------------------------------------------------------+
