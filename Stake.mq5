//+------------------------------------------------------------------+
//|                                                        Sense.mq5 |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Trade/SymbolInfo.mqh> 
#include "Message.mqh"
#include "Golang.mqh"
#include "SQlite.mqh"
#include "Strategy.mqh"
#include "Target/OrderStick.mqh"
#include "Target/PositionStick.mqh"
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
CSymbolInfo symbolInfo;
bool candle_control;
static int quantity_bars;
int loop_quantity; 
int file_output=FileOpen("stake.csv",FILE_WRITE|FILE_CSV);
MqlDateTime time_start, time_end, time_close;
enum ENUM_SINAL {COMPRA = 1, VENDA = -1, NULO = 0};
enum ENUM_TYPE {POSITION = 1, ORDER = -1, NIL = 0};
MqlTradeRequest trade_request;
MqlTradeResult trade_result;
MqlTradeCheckResult trade_check;
int MAGIC_NUMBER=8403;
double TAKEPROFIT=0.001;
double STOPLOSS=0.001;
double account_buy[];
double account_sell[];
OrderStick *orderStick[];
int order_open=0;
//+------------------------------------------------------------------+
//| Input                                                            |
//+------------------------------------------------------------------+
input ENUM_TIMEFRAMES TIME_FRAME=PERIOD_D1;
input string TIME_START="10:00";;
input string TIME_END="12:00";;
input string TIME_CLOSE="13:00";;
input int ORDER_OPEN=1;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
//---
    if(!symbolInfo.Name(_Symbol)){
      return INIT_FAILED;
    }
    if(EnumToString(TIME_FRAME)!=EnumToString(_Period)){
      PeriodInput(EnumToString(TIME_FRAME));
      PeriodSymbol(EnumToString(_Period));
      return INIT_FAILED;
    }
    TimeToStruct(StringToTime(TIME_START),time_start);
    TimeToStruct(StringToTime(TIME_END),time_end);
    TimeToStruct(StringToTime(TIME_CLOSE),time_close);
    if(IsTime()){
      TimeError();
      return INIT_FAILED;
    }
//---
    candle_control=false;
    loop_quantity=1;
    SayInit(IntegerToString(loop_quantity));
//---    
    WriteArquive(file_output,"OnInit;"+(string)TimeCurrent());
//---
    SQLite *sqlite;
    sqlite=new SQLite();
    sqlite.DropDatabase("hit");
    sqlite.InitDatabase("hit");
//---
    //GolangDLLGet();
    //GolangDLLPost("{\"message\":\"init\"}");
    //SendPush("init send notification");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
    if(IsNewDay()){
      candle_control=false;
    }   
//---
    if(IsNewCandle()){
      candle_control=true;
    }
//---
    if(!GetPeriodDay(_Period)) CheckTimeClose();
//--- 
    CheckLimitOrder();
//---
    CheckOrderOpen();
//---
    CheckPositionOpen();
//--
    if(candle_control){
      if(IsTimeDo()){ 
        loop_quantity++;
        SayTimeDo(IntegerToString(loop_quantity));
        CheckPattern();
        candle_control=false;
      } else if(!IsTimeClose()){
        loop_quantity++;
      }
    }    

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---
    const string time_now=TimeToString(TimeCurrent());
//--- 
    string last_order_id=(string)trans.order;
    ENUM_ORDER_TYPE last_order_type=trans.order_type;
    ENUM_ORDER_STATE last_order_state=trans.order_state;
    string trans_symbol=trans.symbol; // name symbol
    ENUM_TRADE_TRANSACTION_TYPE trans_type=trans.type; // type transaction
    string trans_volume=DoubleToString(trans.volume,0);
    string trans_price=DoubleToString(trans.price);
    string trans_price_tp=DoubleToString(trans.price_tp);
    string trans_price_ls=DoubleToString(trans.price_sl);
    string trans_ticket=DoubleToString(trans.position,0);
//---
    SQLite *sqlite;
    sqlite=new SQLite();
//---
    switch(trans.type)
      {
        case TRADE_TRANSACTION_HISTORY_ADD: 
          {
            PrintFormat("MqlTradeTransaction: %s order #%s %s %s %s",EnumToString(trans_type),
              last_order_id,EnumToString(last_order_type),trans_symbol,EnumToString(last_order_state));
            sqlite.SaveHistory(time_now,last_order_id,EnumToString(last_order_type),trans_symbol,EnumToString(last_order_state),trans_price,
              trans_price_tp,trans_price_ls,trans_volume,trans_ticket);
          }
        break;
        default: 
          {
            PrintFormat("MqlTradeTransaction: %s order #%s %s %s %s",EnumToString(trans_type),
              last_order_id,EnumToString(last_order_type),trans_symbol,EnumToString(last_order_state));
          }
        break;
      }   
//---
    ulong order_id_result=result.order;
    string code_result=GetTradeServer(result.retcode);
    if(order_id_result!=0) PrintFormat("MqlTradeResult: order #%d retcode=%s ",order_id_result,code_result);
//---  
   
  }
//+------------------------------------------------------------------+
//| Verify new day                                                   |
//+------------------------------------------------------------------+
bool IsNewDay()
  {
//---
    static datetime old_day=0;
//---
    MqlRates mrate[];    
    ArraySetAsSeries(mrate,true);      
    CopyRates(_Symbol,TIME_FRAME,0,2,mrate);
    datetime lastbar_time=mrate[0].time;
    MqlDateTime time;
    TimeToStruct(lastbar_time,time);
//---
    if(old_day<time.day_of_year) { 
      old_day=time.day_of_year;
      return true;
    }
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify new candle by period                                      |
//+------------------------------------------------------------------+
bool IsNewCandle()
  {
//---
    if(quantity_bars!=Bars(_Symbol,_Period)) {
      quantity_bars=Bars(_Symbol,_Period);
      SayCandle(IntegerToString(quantity_bars));
      return true;
    }
//---
    return false;
//---

  }  
//+------------------------------------------------------------------+
//| Verify time execution                                            |
//+------------------------------------------------------------------+
 bool IsTime()
  { 
//---
    if((time_start.hour>time_end.hour || (time_start.hour==time_end.hour && time_start.min>time_end.min))
         || time_end.hour>time_close.hour || (time_end.hour==time_close.hour && time_end.min>time_close.min)) return true;
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify time close                                                |
//+------------------------------------------------------------------+
bool IsTimeClose()
  {
//---
    MqlDateTime time_now;
    TimeToStruct(TimeCurrent(),time_now); 
    if((time_now.hour<time_start.hour) && (time_now.min<=time_start.min)) return true;
    if(time_now.hour>time_close.hour) return true;
    if((time_now.hour==time_close.hour) && (time_now.min>=time_close.min)) return true;
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Verify time do                                                   |
//+------------------------------------------------------------------+
bool IsTimeDo()
  {
//---
    MqlDateTime time_now;
    TimeToStruct(TimeCurrent(),time_now); 
    if(time_now.hour>=time_start.hour && time_now.hour<=time_end.hour) {
      if((time_start.hour==time_end.hour) 
         && (time_now.min>=time_start.min) && (time_now.min<=time_end.min))
         return true;
      if(time_now.hour==time_start.hour) {
         if(time_now.min>=time_start.min) return true;
         else return false;
      }
      if(time_now.hour==time_end.hour) {
         if (time_now.min<=time_end.min) return true;
         else return false;
      }
      return true;
    }
//---
    return false;
//---

  }
//+------------------------------------------------------------------+
//| Check open position                                              |
//+------------------------------------------------------------------+
bool IsPositioned()
{  
//---
   return PositionSelect(_Symbol);
//---

}  
//+------------------------------------------------------------------+
//| Check open order                                                 |
//+------------------------------------------------------------------+
bool IsOrderLaunch()
{  
//---
   for(int i=OrdersTotal()-1;i>=0;i--){
//---
      OrderGetTicket(i);
      if(OrderGetString(ORDER_SYMBOL)==_Symbol) return true;
   }
//---
   return false;
//---

}
//+------------------------------------------------------------------+
//| Manage closing position                                          |
//+------------------------------------------------------------------+
void CheckTimeClose()
  {
//---
    if(IsTimeClose()) {
//---
      if(IsPositioned()) CloseAllPosition();
//---
      if(IsOrderLaunch()) CloseOrder();
    }
//---

  } 
//+------------------------------------------------------------------+
//| Verify exceeded order                                            |
//+------------------------------------------------------------------+
void CheckLimitOrder()
  {
//---
    for(int i=OrdersTotal()-1;i>=0;i--) {
//---
      ulong ticket=OrderGetTicket(i);
      if(i>=ORDER_OPEN) {
//---
        ClearRequest();
        trade_request.order=ticket;
        trade_request.action=TRADE_ACTION_REMOVE;
        trade_request.comment="Delete Order Limited";
//---
        CloseRequest();
      }
    }
//---
    
  }
//+------------------------------------------------------------------+
//| Controller less order                                            |
//+------------------------------------------------------------------+
bool IsOrderLess(ENUM_SINAL signal, ulong order, double inprice)
  {
//---
    string spot;
    double price=0;
    if(signal==VENDA) spot="VENDA";
    else spot="COMPRA";
    for(int j=0;j<order_open;j++) {
      if((orderStick[j].order==order) && (orderStick[j].contract==spot)) price=orderStick[j].price;
    }  
//---
    if(signal==VENDA) {
      if(inprice>price) return false;
    } else {
      if(signal==COMPRA) {
        if(inprice<price) return false;
      }
    }
//---
    return true;
//---
    
  }     
//+------------------------------------------------------------------+
//| Send message                                                     |
//+------------------------------------------------------------------+
bool SendRequest()
  {
//---
    ResetLastError();
//---
    if(!OrderCheck(trade_request,trade_check)) {
      //PrintFormat("| Erro OrderCheck: %d - Código: %d",GetLastError(),check_result.retcode);
      ErrorSendRequest(DoubleToString(GetLastError())+" | "+GetRuntime(GetLastError()));   
      ErrorCodSendRequest(DoubleToString(trade_check.retcode)+" | "+ GetTradeServer(trade_check.retcode));
      return false;
    }
//---
    if(!OrderSend(trade_request,trade_result)) {
      return false;
    }
//---
    order_open++;
    ArrayResize(orderStick,order_open);
    orderStick[order_open-1]=new OrderStick();
//---
    ENUM_ORDER_TYPE type=(ENUM_ORDER_TYPE)trade_request.type;
    string signal=""; 
    if(type==ORDER_TYPE_BUY_STOP) signal="COMPRA";
      else signal="VENDA";
//---
    orderStick[order_open-1].Add(trade_result.order,trade_request.price,trade_request.tp,trade_request.sl,order_open,signal);
//---
    return true;
//---

  }
//+------------------------------------------------------------------+
//| Send modify message                                              |
//+------------------------------------------------------------------+
bool ModifyRequest(ENUM_TYPE kind, ENUM_SINAL spot)
  {
//---
    ResetLastError();
//---
    if(!OrderCheck(trade_request,trade_check)) {
      //PrintFormat("| Erro OrderCheck: %d - Código: %d",GetLastError(),check_result.retcode);
      ErrorSendRequest(DoubleToString(GetLastError())+" | "+GetRuntime(GetLastError()));   
      ErrorCodSendRequest(DoubleToString(trade_check.retcode)+" | "+ GetTradeServer(trade_check.retcode));
      return false;
    }
//---
    if(!OrderSend(trade_request,trade_result)) {
      return false;
    }
//---
    order_open++;
    ArrayResize(orderStick,order_open);
    orderStick[order_open-1]=new OrderStick();
//---    
    string signal=""; 
    if(spot==COMPRA) signal="COMPRA";
    else signal="VENDA";
//---
    ulong index;
    double value;
    if(kind==ORDER) {
      index=trade_request.order;
      value=trade_request.price;
    }
    else {
      index=trade_request.position;
      double close=iClose(_Symbol,_Period,0);
      value=close;
    }
//---
    orderStick[order_open-1].Add(index,value,trade_request.tp,trade_request.sl,order_open,signal);
//---
    return true;
//---

  }
//+------------------------------------------------------------------+
//| Send message closing                                             |
//+------------------------------------------------------------------+
bool CloseRequest()
  {
//---
    ResetLastError();
//---
    if(!OrderCheck(trade_request,trade_check)) {
      //PrintFormat("| Erro OrderCheck: %d - Código: %d",GetLastError(),check_result.retcode);
      ErrorSendRequest(DoubleToString(GetLastError())+" | "+GetRuntime(GetLastError()));   
      ErrorCodSendRequest(DoubleToString(trade_check.retcode)+" | "+ GetTradeServer(trade_check.retcode));
      return false;
    }
//---
    if(!OrderSend(trade_request,trade_result)) {
      return false;
    }
//---
    return true;
//---

  }  
//+------------------------------------------------------------------+
//| Close order                                                      |
//+------------------------------------------------------------------+
void CloseOrder()
  {
//---
    for(int i=OrdersTotal()-1;i>=0;i--) {
      ulong order=OrderGetTicket(i);
//---
      ClearRequest();
      trade_request.action=TRADE_ACTION_REMOVE;
      trade_request.order=order;
      trade_request.comment="Delete Order";
//---
      CloseRequest();
    }
//---
    
  }
//+------------------------------------------------------------------+
//| Clean message                                                    |
//+------------------------------------------------------------------+
void ClearRequest()
  {
//---
    ZeroMemory(trade_request);
    ZeroMemory(trade_result);
    ZeroMemory(trade_check);
//---

  }
//+------------------------------------------------------------------+
//| manage position closing                                          |
//+------------------------------------------------------------------+
void CloseAllPosition()
  {
//---
    for(int i=PositionsTotal()-1;i>=0;i--) {
//---
      ulong ticket=PositionGetTicket(i);
      long type=PositionGetInteger(POSITION_TYPE);
      string symbol=PositionGetString(POSITION_SYMBOL);
      double volume=PositionGetDouble(POSITION_VOLUME);
      int digits=(int)SymbolInfoInteger(symbol,SYMBOL_DIGITS); 
//---
      ClearRequest();
      trade_request.position=ticket;
      trade_request.action=TRADE_ACTION_DEAL;
      trade_request.magic=MAGIC_NUMBER;
      trade_request.symbol=symbol;
      trade_request.volume=volume;
      trade_request.deviation=5;
      trade_request.type_filling=ORDER_FILLING_IOC; 
//---      
      if(type==POSITION_TYPE_BUY) {
        trade_request.price=SymbolInfoDouble(symbol,SYMBOL_BID);
        trade_request.type=ORDER_TYPE_SELL;
        trade_request.comment="Close Position Buy";
//---
      } else {
        trade_request.price=SymbolInfoDouble(symbol,SYMBOL_ASK);
        trade_request.type=ORDER_TYPE_BUY;
        trade_request.comment="Close Position Sell";
      }
//---
      CloseRequest();
    }
//---

  }
//+------------------------------------------------------------------+
//| Modify order                                                     |
//+------------------------------------------------------------------+
bool EditOrder(ENUM_SINAL signal,int ticket)
  {
//---
    int ok=0;
//---
    ulong order=OrderGetTicket(ticket);
    long type=OrderGetInteger(ORDER_TYPE);
    string symbol=Symbol();
    double volume=OrderGetDouble(ORDER_VOLUME_CURRENT); 
    int digits=(int)SymbolInfoInteger(symbol,SYMBOL_DIGITS); 
    double sl=OrderGetDouble(ORDER_SL); 
    double tp=OrderGetDouble(ORDER_TP); 
    double price=OrderGetDouble(ORDER_PRICE_CURRENT);
//---
    ClearRequest();   
    trade_request.order=order;
    trade_request.action=TRADE_ACTION_MODIFY;
    trade_request.magic=MAGIC_NUMBER;
    trade_request.symbol=symbol;
    trade_request.volume=volume;
    trade_request.deviation=5;
//---
    int stop_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(stop_level<=0) stop_level=150; 
    else stop_level+=50;
    int profit_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(profit_level<=0) profit_level=40; 
    else profit_level+=13;      
//---      
    double price_sl=stop_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
    double price_tp=profit_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
//---
    if(signal==COMPRA) { 
//---
      if(type==ORDER_TYPE_SELL_STOP)
      {
        price=SymbolInfoDouble(Symbol(),SYMBOL_ASK); 
        price=NormalizeDouble(price,digits);
        sl=NormalizeDouble(price+price_sl,digits);
        tp=NormalizeDouble(price-price_tp,digits);
        trade_request.price=price;
        trade_request.sl=sl;
        trade_request.tp=tp;
        trade_request.comment="Edit Order Sell Stop";
        if(ModifyRequest(ORDER,VENDA)) ok++;
      } else {
//---
        if(type==ORDER_TYPE_SELL_LIMIT) {
          price=SymbolInfoDouble(Symbol(),SYMBOL_ASK); 
          price=NormalizeDouble(price,digits);
          sl=NormalizeDouble(price+price_sl,digits);
          tp=NormalizeDouble(price-price_tp,digits);
          trade_request.price=price;              
          trade_request.sl=sl;
          trade_request.tp=tp;
          trade_request.comment="Edit Order Sell Limit";
          if(ModifyRequest(ORDER,VENDA)) ok++;
        }
      }
    } else {
//---
      if(type==ORDER_TYPE_BUY_STOP) {
        price=SymbolInfoDouble(Symbol(),SYMBOL_ASK); 
        price=NormalizeDouble(price,digits);
        sl=NormalizeDouble(price-price_sl,digits);
        tp=NormalizeDouble(price+price_tp,digits);
        trade_request.sl=sl;
        trade_request.tp=tp;
        trade_request.price=price;
        trade_request.comment="Edit Order Buy Stop";
        if(ModifyRequest(ORDER,COMPRA)) ok++;
      } else {
//---
        if(type==ORDER_TYPE_BUY_LIMIT) {
          price=SymbolInfoDouble(Symbol(),SYMBOL_ASK); 
          price=NormalizeDouble(price,digits);
          sl=NormalizeDouble(price-price_sl,digits);
          tp=NormalizeDouble(price+price_tp,digits);
          trade_request.sl=sl;
          trade_request.tp=tp;
          trade_request.price=price;  
          trade_request.comment="Edit Order Buy Limit";
          if(ModifyRequest(ORDER,COMPRA)) ok++;
        }
      }
    }
//---
    if(ok>0) return true;
    else return false;
//---

  }
//+------------------------------------------------------------------+
//| Modify position                                                  |
//+------------------------------------------------------------------+
bool EditPosition(ENUM_SINAL signal,int ticket)
  {
//---
    int ok=0;
//---
    ulong position=PositionGetTicket(ticket);
    //long type=PositionGetInteger(POSITION_TYPE);
    ENUM_POSITION_TYPE type=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
    string symbol=PositionGetString(POSITION_SYMBOL);
    double volume=PositionGetDouble(POSITION_VOLUME);    
    int digits=(int)SymbolInfoInteger(symbol,SYMBOL_DIGITS); 
    double sl=PositionGetDouble(POSITION_SL);
    double tp=PositionGetDouble(POSITION_TP);
    double price=PositionGetDouble(POSITION_PRICE_OPEN);
    double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
    double ask=SymbolInfoDouble(symbol,SYMBOL_ASK);
//---
    ClearRequest();
    trade_request.position=position;
    trade_request.action=TRADE_ACTION_SLTP;
    trade_request.magic=MAGIC_NUMBER;
    trade_request.symbol=symbol;
    trade_request.volume=volume;
    //trade_request.type=type;
//---      
    int stop_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(stop_level<=0) stop_level=150; 
    else stop_level+=50;
    int profit_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(profit_level<=0) profit_level=40; 
    else profit_level+=13;      
//---      
    double price_sl=stop_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
    double price_tp=profit_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
//---
    if(signal==COMPRA) {
//---
      if(type==POSITION_TYPE_SELL) {
          sl=NormalizeDouble(ask+price_sl,digits);
          tp=NormalizeDouble(bid-price_tp,digits);
          trade_request.sl=sl;
          trade_request.tp=tp;
          trade_request.comment="Edit Position Sell";
//---
          double close=iClose(_Symbol,_Period,0);
          if(IsOrderLess(VENDA, position, close)) return false;
//---
          if(ModifyRequest(POSITION,VENDA)) ok++;
      } 
    } else {
//---
      if(type==POSITION_TYPE_BUY)
      {
        sl=NormalizeDouble(bid-price_sl,digits);
        tp=NormalizeDouble(ask+price_tp,digits);
        trade_request.sl=sl;
        trade_request.tp=tp;
        trade_request.comment="Edit Position Buy";
//---
        double close=iClose(_Symbol,_Period,0);
        if(IsOrderLess(COMPRA, position, close)) return false;
//---
        if(ModifyRequest(POSITION,COMPRA)) ok++;
      }
    }
//---   
    if(ok>0) return true;
    else return false;
//---

  }
//+------------------------------------------------------------------+
//| open a buy stop order                                            |
//+------------------------------------------------------------------+
bool BuyStop()
  {
//---
    ClearRequest();
    trade_request.action=TRADE_ACTION_PENDING;
    trade_request.type=ORDER_TYPE_BUY_STOP;
    trade_request.type_filling=ORDER_FILLING_RETURN; 
    trade_request.type_time=ORDER_TIME_DAY;
    trade_request.magic=MAGIC_NUMBER;
    trade_request.deviation=5; 
    trade_request.comment="Buy Stop";
//---
    int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);   
    double price=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
    trade_request.price=NormalizeDouble(price,digits);
//---
    string symbol=Symbol();
    trade_request.symbol=symbol;
//---
    trade_request.volume=GetVolume(symbol);  
//---
    int stop_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(stop_level<=0) stop_level=150; // default 150 
    else stop_level+=50; // default 50
    int profit_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(profit_level<=0) profit_level=150; // default 150 
    else profit_level+=50; // default 50
//---
    double price_sl=stop_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
    double price_tp=profit_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
//---
    double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
    double ask=SymbolInfoDouble(symbol,SYMBOL_ASK);
//---
    double sl=NormalizeDouble(bid-price_sl,digits);
    double tp=NormalizeDouble(ask+price_tp,digits);
    trade_request.sl=sl;
    trade_request.tp=tp;
//---
    return SendRequest();
//---

  }
//+------------------------------------------------------------------+
//| open a sell stop order                                           |
//+------------------------------------------------------------------+
bool SellStop()
  {
//---
    ClearRequest();
    trade_request.action=TRADE_ACTION_PENDING;
    trade_request.type=ORDER_TYPE_SELL_STOP;
    trade_request.type_filling=ORDER_FILLING_RETURN; 
    trade_request.type_time=ORDER_TIME_DAY;
    trade_request.magic=MAGIC_NUMBER;
    trade_request.deviation=5; 
    trade_request.comment="Sell Stop";
//---
    int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);   
    double price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
    trade_request.price=NormalizeDouble(price,digits);
//---
    string symbol=Symbol();
    trade_request.symbol=symbol;
//---
    trade_request.volume=GetVolume(symbol);  
//---
    int stop_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(stop_level<=0) stop_level=150; 
    else stop_level+=50;
    int profit_level=(int)SymbolInfoInteger(symbol,SYMBOL_TRADE_STOPS_LEVEL);
    if(profit_level<=0) profit_level=150; 
    else profit_level+=50;
//---
    double price_sl=stop_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
    double price_tp=profit_level*SymbolInfoDouble(symbol,SYMBOL_POINT);
//---
    double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
    double ask=SymbolInfoDouble(symbol,SYMBOL_ASK);
//---
    double sl=NormalizeDouble(ask+price_sl,digits);
    double tp=NormalizeDouble(bid-price_tp,digits);
    trade_request.sl=sl;
    trade_request.tp=tp;
//---
    return SendRequest();
//---

  }
//+------------------------------------------------------------------+
//| Manage order opening                                             |
//+------------------------------------------------------------------+
void CheckOrderOpen()
  {
//---
    int buy=0;
    int sell=0;
    bool op=false;
//---
    if(IsTimeDo()) {
//---
      if(IsOrderLaunch()) {
//---
        double high=iHigh(_Symbol,_Period,0); 
        double open=iOpen(_Symbol,_Period,0); 
        double close=iClose(_Symbol,_Period,0); 
        double low=iLow(_Symbol,_Period,0);
        bool red=false;
        bool green=false;
        ulong order;
        long type;
        double price;
        string signal;      
//---        
        for(int i=OrdersTotal()-1;i>=0;i--) {
//---
          order=OrderGetTicket(i);
          type=OrderGetInteger(ORDER_TYPE);
          price=OrderGetDouble(ORDER_PRICE_OPEN);
//---
          if((type==ORDER_TYPE_BUY_STOP)||(type==ORDER_TYPE_BUY_LIMIT)||(type==ORDER_TYPE_BUY)) {
//---
            signal="COMPRA";
            for (int j=0;j<order_open;j++) {
              if ((orderStick[j].order==order) && (orderStick[j].contract==signal)) price=orderStick[j].price;
            }
//---
            red=price>close? true: false;
            if(red) op=EditOrder(VENDA,i);
          } else {
            if((type==ORDER_TYPE_SELL_STOP)||(type==ORDER_TYPE_SELL_LIMIT)||(type==ORDER_TYPE_SELL)) {
//---
              signal="VENDA";
              for (int j=0;j<order_open;j++) {
                if ((orderStick[j].order==order) && (orderStick[j].contract==signal)) price=orderStick[j].price;
              }
//---
              green=price<close? true: false;
              if(green) op=EditOrder(COMPRA,i);
            }
          }
        }          
      }      
    }
//---

  }
//+------------------------------------------------------------------+
//| Manage position opening                                          |
//+------------------------------------------------------------------+
void CheckPositionOpen()
  {
//---
    int buy=0;
    int sell=0;
    bool op=false;
//---
    if(IsTimeDo()) {
//---
      if(IsPositioned()) {
//---
        double high=iHigh(_Symbol,_Period,0); 
        double open=iOpen(_Symbol,_Period,0); 
        double close=iClose(_Symbol,_Period,0); 
        double low=iLow(_Symbol,_Period,0);
        bool red=false;
        bool green=false;
        ulong position;
        long type;
        double price;
        string signal;
//---
        for(int i=PositionsTotal()-1;i>=0;i--) {
//---
          position=PositionGetTicket(i);
          type=PositionGetInteger(POSITION_TYPE);
          price=PositionGetDouble(POSITION_PRICE_OPEN);
//---
          if(type==POSITION_TYPE_BUY) {
//---
            signal="COMPRA";
            for (int j=0;j<order_open;j++) {
              if ((orderStick[j].order==position) && (orderStick[j].contract==signal)) price=orderStick[j].price;
            }
//---
            red=price>close? true: false;
            if(red) op=EditPosition(VENDA,i);
          } else {
//---
            if(type==POSITION_TYPE_SELL) {
//---
              signal="VENDA";
              for (int j=0;j<order_open;j++) {
                if ((orderStick[j].order==position) && (orderStick[j].contract==signal)) price=orderStick[j].price;
              }
//---
              green=price<close? true: false;
              if(green) op=EditPosition(COMPRA,i);
            }
          }
        }
      }
    }
//---
    
  }  
//+------------------------------------------------------------------+
//| Load position opening                                            |
//+------------------------------------------------------------------+
void MountPositionOpen(PositionStick &positionStick[])
  {
//---
    ArrayFree(positionStick);
//---
    if(IsTimeDo()){
//---
      if(IsPositioned()){
//---
        int total_position=PositionsTotal();
        ArrayResize(positionStick,total_position+1);
        if(total_position==0) return;
        int ticket_quantity=0;
        for(int i=total_position-1;i>=0;i--){
//---
          ulong ticket_position = PositionGetTicket(i);
          if(ticket_position>0){
            positionStick[ticket_quantity]=new PositionStick();
            string symbol=PositionGetString(POSITION_SYMBOL);
            long kind=PositionGetInteger(POSITION_TYPE);
            double volume=PositionGetDouble(POSITION_VOLUME);
            double bid_price = SymbolInfoDouble(symbol, SYMBOL_BID);
            double ask_price = SymbolInfoDouble(symbol, SYMBOL_ASK);
            double price = PositionGetDouble(POSITION_PRICE_OPEN);
            double profit = PositionGetDouble(POSITION_PROFIT);
            double sl = PositionGetDouble(POSITION_SL);
            positionStick[ticket_quantity].Add(ticket_position,symbol,kind,volume,bid_price,ask_price,price,profit,sl);
//---
            ticket_quantity++;
          }                  
        }
      }
    }
//---

  }
//+------------------------------------------------------------------+
//| manage position closing                                          |
//+------------------------------------------------------------------+
void ClosePosition(PositionStick &positionStick)
  {
//---    
    int deviation=5;
    string message_close="Closed by the system.";
//---
    ulong ticket=positionStick.ticket;
    long kind=positionStick.kind;
    string symbol=positionStick.symbol;
    double volume=positionStick.volume;
    double bid=positionStick.bid;
    double ask=positionStick.ask;
//---
    ClearRequest();
    trade_request.position=ticket;
    trade_request.action=TRADE_ACTION_DEAL;
    trade_request.magic=MAGIC_NUMBER;
    trade_request.symbol=symbol;
    trade_request.volume=volume;
    trade_request.deviation=deviation;
    trade_request.type_filling=ORDER_FILLING_IOC; 
    trade_request.comment=message_close;
//---      
    if(kind==POSITION_TYPE_BUY){
      trade_request.price=bid;
      trade_request.type=ORDER_TYPE_BUY;
    }else{
      trade_request.price=ask;
      trade_request.type=ORDER_TYPE_SELL;
    }
//---
    CloseRequest();
//---

  }
//+------------------------------------------------------------------+
//| Close open position based on the pattern                         |
//+------------------------------------------------------------------+
void ClosePattern(PositionStick &positionStick[])
  {
//---
    if(IsTimeDo()){
//---
      if(IsPositioned()){
//---
        int total_position=ArraySize(positionStick);
//---
        Strategy *strategy;
        strategy=new Strategy();
//---        
        bool macd=false;
        for(int i=total_position-1;i>=0;i--){
          macd=strategy.MACDClose(positionStick[i]);
          if(macd) ClosePosition(positionStick[i]);
        }                        
      }
    }  
//---

  }
//+------------------------------------------------------------------+
//| open a position                                                  |
//+------------------------------------------------------------------+
bool OpenPosition(long brand)
  {
//---    
    int deviation=5;
    string message_open="Opened by the system.";
//---
    long kind=brand;
    ENUM_TRADE_REQUEST_ACTIONS action=TRADE_ACTION_DEAL;
    string symbol=Symbol();
    double volume=GetVolume(symbol);
    double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
    double ask=SymbolInfoDouble(symbol,SYMBOL_ASK);
    int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);   
//---
    ClearRequest();
    trade_request.action=action;
    trade_request.symbol=symbol;
    trade_request.volume=volume;  
    if(kind==POSITION_TYPE_BUY){
      trade_request.type=ORDER_TYPE_BUY; 
      trade_request.price=NormalizeDouble(ask,digits);
    }else{
      trade_request.type=ORDER_TYPE_SELL; 
      trade_request.price=NormalizeDouble(bid,digits);
    }
    trade_request.deviation=deviation; 
    trade_request.magic=MAGIC_NUMBER;
    trade_request.comment=message_open;
//---
    return SendRequest();
//---

  }  
//+------------------------------------------------------------------+
//| Open position based on the pattern                               |
//+------------------------------------------------------------------+
void OpenPattner()
  {
//---
    if(IsTimeDo()){
//---
      Strategy *strategy;
      strategy=new Strategy();
//---        
      bool macd_buy=false;
      bool macd_sell=false;
      macd_buy=strategy.MACDOpen(POSITION_TYPE_BUY);
      macd_sell=strategy.MACDOpen(POSITION_TYPE_SELL);
      if(macd_buy) OpenPosition(POSITION_TYPE_BUY);
      if(macd_sell) OpenPosition(POSITION_TYPE_SELL);
    }  
//---

  }   
//+------------------------------------------------------------------+
//| Manage pattern 1                                                 |
//+------------------------------------------------------------------+
void CheckPattern()
  {
//---
    PositionStick positionStick[];
    MountPositionOpen(positionStick);
    int position_quantity = ArraySize(positionStick);
//---
    if(position_quantity>0){
      ClosePattern(positionStick);    
    }
//---
    OpenPattner();
//---

  }  
//+------------------------------------------------------------------+
