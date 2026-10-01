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
class Notification
  {
    private:

    public:
      Notification();
      ~Notification();
      void WriteTrade(const string value,const string time);
      void WriteTrend(const string position,const string endurance,const string support,const string time);      
      void WriteTradeClose(const string value,const string time);
      void WriteTradeOpen(const string value,const string time);
      void WriteTrendMajor(const string text);
      void WriteTrendMajor(const string text,const string time,const string index);
      void WriteMajorPrevious(const string text,const string time,const string index);
      void WriteTrendMinor(const string text);
      void WriteTrendMinor(const string text,const string time,const string index);
      void WriteEnduranceMajor(const string endurance,const string time_endurance,const string support,const string time_support);
      void WriteSupportMinor(const string support,const string time_support,const string endurance,const string time_endurance);
      void WriteEnduranceSupport(const string endurance,const string time_endurance,const string support,const string time_support);
      void WriteEnduranceUpSupportDown(const string endurance,const string time_endurance,const string support,const string time_support);
      void WriteEnduranceBreak(const string endurance,const string time_endurance,const string support,const string time_support);
      void WriteCandle(const string high,const string open,const string close,const string low,const string i);
      void WriteCandle(const string high,const string open,const string close,const string low,const string i,const string time,const string volume,const string pattern,const string symbol);
      void WriteFibonacci100382(const string value_0,const string value_382,const string value_100);
      void WriteFibonacci100618(const string value_0,const string value_618,const string value_100);
      void WriteEnduranceDiff(const string position,const string date,const string value,const string date_init);
      void WriteSupportDiff(const string position,const string date,const string value,const string date_init);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Notification::Notification()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
Notification::~Notification()
  {
  }
//+------------------------------------------------------------------+
//| write trade                                                      |
//+------------------------------------------------------------------+
void Notification::WriteTrade(const string value,const string time) 
  {
    printf("| Trade: %s - Time: %s",value,time); 
  };  
//+------------------------------------------------------------------+
//| write trend                                                      |
//+------------------------------------------------------------------+
void Notification::WriteTrend(const string position,const string endurance,const string support,const string time) 
  {
    if(StringToDouble(endurance)!=0) printf("| Position %s = Endurance %s - Time %s",position,endurance,time); 
    if(StringToDouble(support)!=0) printf("| Position %s = Support %s - Time %s",position,support,time); 
  };
//+------------------------------------------------------------------+
//| write trade close                                                |
//+------------------------------------------------------------------+
void Notification::WriteTradeClose(const string value,const string time) 
  {
    printf("| Trade Close: %s - Time: %s",value,time); 
  };  
//+------------------------------------------------------------------+
//| write trade open                                                 |
//+------------------------------------------------------------------+
void Notification::WriteTradeOpen(const string value,const string time) 
  {
    printf("| Trade Open: %s - Time: %s",value,time); 
  };  
//+------------------------------------------------------------------+
//| write trade major                                                |
//+------------------------------------------------------------------+
void Notification::WriteTrendMajor(const string text) 
  {
    printf("| Endurance: %s",text); 
  };
//+------------------------------------------------------------------+
//| write trade major                                                |
//+------------------------------------------------------------------+
void Notification::WriteTrendMajor(const string text,const string time,const string index) 
  {
    printf("| Endurance: %s - Time: %s - Position: %s",text,time,index); 
  };
//+------------------------------------------------------------------+
//| write previous trade major                                       |
//+------------------------------------------------------------------+
void Notification::WriteMajorPrevious(const string text,const string time,const string index) 
  {
    printf("| Endurance Previous: %s - Time: %s - Position: %s",text,time,index); 
  };  
//+------------------------------------------------------------------+
//| write trade minor                                                |
//+------------------------------------------------------------------+
void Notification::WriteTrendMinor(const string text) 
  {
    printf("| Support: %s",text); 
  };
//+------------------------------------------------------------------+
//| write trade minor                                                |
//+------------------------------------------------------------------+
void Notification::WriteTrendMinor(const string text,const string time,const string index)  
  {
    printf("| Support: %s - Time: %s - Position: %s",text,time,index); 
  };
//+------------------------------------------------------------------+
//| write endurance major                                            |
//+------------------------------------------------------------------+
void Notification::WriteEnduranceMajor(const string endurance,const string time_endurance,const string support,const string time_support) 
  {
    printf("| Endurance Major Position: %s - Date: %s | Support Position: %s - Date: %s ",endurance,time_endurance,support,time_support); 
  };
//+------------------------------------------------------------------+
//| write support minor                                              |
//+------------------------------------------------------------------+
void Notification::WriteSupportMinor(const string support,const string time_support,const string endurance,const string time_endurance) 
  {
    printf("| Support Minor Position: %s - Date: %s | Endurance Position: %s - Date: %s ",support,time_support,endurance,time_endurance); 
  };  
//+------------------------------------------------------------------+
//| write endurance support                                          |
//+------------------------------------------------------------------+
void Notification::WriteEnduranceSupport(const string endurance,const string time_endurance,const string support,const string time_support) 
  {
    printf("| Endurance Position: %s - Date: %s | Support Down Position: %s - Date: %s ",endurance,time_endurance,support,time_support); 
  };
//+------------------------------------------------------------------+
//| write endurance support                                          |
//+------------------------------------------------------------------+
void Notification::WriteEnduranceUpSupportDown(const string endurance,const string time_endurance,const string support,const string time_support) 
  {
    printf("| Endurance Up Position: %s - Date: %s | Support Down Position: %s - Date: %s ",endurance,time_endurance,support,time_support); 
  };  
//+------------------------------------------------------------------+
//| write endurance break                                            |
//+------------------------------------------------------------------+
void Notification::WriteEnduranceDiff(const string position,const string date,const string value,const string date_init) 
  {
    printf("| Endurance Difference Position: %s - Date: %s - Value: %s - Init: %s",position,date,value,date_init); 
  };
//+------------------------------------------------------------------+
//| write support break                                              |
//+------------------------------------------------------------------+
void Notification::WriteSupportDiff(const string position,const string date,const string value,const string date_init) 
  {
    printf("| Support Difference Position: %s - Date: %s - Value: %s - Init: %s",position,date,value,date_init); 
  };
//+------------------------------------------------------------------+
//| write candle                                                     |
//+------------------------------------------------------------------+
void Notification::WriteCandle(const string high,const string open,const string close,const string low,const string i) 
  {
    printf("| Position %s = High %s - Open %s - Close %s - Low %s",i,high,open,close,low); 
  };
//+------------------------------------------------------------------+
//| write candle                                                     |
//+------------------------------------------------------------------+
void Notification::WriteCandle(const string high,const string open,const string close,const string low,const string i,const string time,const string volume,const string pattern,const string symbol) 
  {
    printf("| Position %s = High %s - Open %s - Close %s - Low %s - Time %s - Volume %s - Pattern %s - Symbol %s",i,high,open,close,low,time,volume,pattern,symbol); 
  };
//+------------------------------------------------------------------+
//| write fibonacci 100 by 38.2                                      |
//+------------------------------------------------------------------+
void Notification::WriteFibonacci100382(const string value_0,const string value_382,const string value_100) 
  {
    printf("| Fibonacci = 38.2 - 0 %s - 38.2 %s - 100 %s",value_0,value_382,value_100); 
  };
//+------------------------------------------------------------------+
//| write fibonacci 100 by 61.8                                                     |
//+------------------------------------------------------------------+
void Notification::WriteFibonacci100618(const string value_0,const string value_618,const string value_100) 
  {
    printf("| Fibonacci = 61.8 - 0 %s - 61.8 %s - 100 %s",value_0,value_618,value_100); 
  };
//+------------------------------------------------------------------+
