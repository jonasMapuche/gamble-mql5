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
class Message
  {
    private:

    public:
      Message();
      ~Message();
      string GetTradeServer(int retcode);
      string GetRuntime(int retcode);
      int GetVolume(string symbol);
      bool GetPeriodDay(ENUM_TIMEFRAMES period);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Message::Message()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
Message::~Message()
  {
  }
//+------------------------------------------------------------------+
//| Decoder code of the trade server                                 |
//+------------------------------------------------------------------+
string GetTradeServer(int retcode)
  {
    switch(retcode)
    {
      case 10004: return("TRADE_RETCODE_REQUOTE"); break;
      case 10006: return("TRADE_RETCODE_REJECT"); break;
      case 10007: return("TRADE_RETCODE_CANCEL"); break;
      case 10008: return("TRADE_RETCODE_PLACED"); break;
      case 10009: return("TRADE_RETCODE_DONE"); break;
      case 10010: return("TRADE_RETCODE_DONE_PARTIAL"); break;
      case 10011: return("TRADE_RETCODE_ERROR"); break;
      case 10012: return("TRADE_RETCODE_TIMEOUT"); break;
      case 10013: return("TRADE_RETCODE_INVALID"); break;
      case 10014: return("TRADE_RETCODE_INVALID_VOLUME"); break;
      case 10015: return("TRADE_RETCODE_INVALID_PRICE"); break;
      case 10016: return("TRADE_RETCODE_INVALID_STOPS"); break;
      case 10017: return("TRADE_RETCODE_TRADE_DISABLED"); break;
      case 10018: return("TRADE_RETCODE_MARKET_CLOSED"); break;
      case 10019: return("TRADE_RETCODE_NO_MONEY"); break;
      case 10020: return("TRADE_RETCODE_PRICE_CHANGED"); break;
      case 10021: return("TRADE_RETCODE_PRICE_OFF"); break;
      case 10022: return("TRADE_RETCODE_INVALID_EXPIRATION"); break;
      case 10023: return("TRADE_RETCODE_ORDER_CHANGED"); break;
      case 10024: return("TRADE_RETCODE_TOO_MANY_REQUESTS"); break;
      case 10025: return("TRADE_RETCODE_NO_CHANGES"); break;
      case 10026: return("TRADE_RETCODE_SERVER_DISABLES_AT"); break;
      case 10027: return("TRADE_RETCODE_CLIENT_DISABLES_AT"); break;
      case 10028: return("TRADE_RETCODE_LOCKED"); break;
      case 10029: return("TRADE_RETCODE_FROZEN"); break;
      case 10030: return("TRADE_RETCODE_INVALID_FILL"); break;
      case 10031: return("TRADE_RETCODE_CONNECTION"); break;
      case 10032: return("TRADE_RETCODE_ONLY_REAL"); break;
      case 10033: return("TRADE_RETCODE_LIMIT_ORDERS"); break;
      case 10034: return("TRADE_RETCODE_LIMIT_VOLUME"); break;
      case 10035: return("TRADE_RETCODE_INVALID_ORDER"); break;
      case 10036: return("TRADE_RETCODE_POSITION_CLOSED"); break;
      default: return("TRADE_RETCODE_UNKNOWN="+IntegerToString(retcode)); break;
    }
//---

  }
//+------------------------------------------------------------------+
//| Decoder code runtime error                                       |
//+------------------------------------------------------------------+
 string GetRuntime(int retcode)
  {
    switch(retcode)
    {
      case 4701: return("ERR_ACCOUNT_WRONG_PROPERTY"); break;
      case 4751: return("ERR_TRADE_WRONG_PROPERTY"); break;
      case 4752: return("ERR_TRADE_DISABLED"); break;
      case 4753: return("ERR_TRADE_POSITION_NOT_FOUND"); break;
      case 4754: return("ERR_TRADE_ORDER_NOT_FOUND"); break;
      case 4755: return("ERR_TRADE_DEAL_NOT_FOUND"); break;
      case 4756: return("ERR_TRADE_SEND_FAILED"); break;
      case 4758: return("ERR_TRADE_CALC_FAILED"); break;
      default: return("ERR_UNKNOWN="+IntegerToString(retcode)); break;
    }
//---

  }
//+------------------------------------------------------------------+
//| Decoder volume                                                   |
//+------------------------------------------------------------------+
int GetVolume(string symbol)
  {
    if(symbol=="BGI$N") return 1;
    if(symbol=="ICF$N") return 1;
    if(symbol=="CCM$N") return 1;
    if(symbol=="CMIG3") return 100;
    if(symbol=="CMIG4") return 100;
    if(symbol=="LIGT3") return 100;
    if(symbol=="PETR4") return 100;
    if(symbol=="SOJA3") return 100;
    if(symbol=="GOLD11") return 1;
//---    
    return 1;
//---

  }
//+------------------------------------------------------------------+
//| Decoder period                                                   |
//+------------------------------------------------------------------+
bool GetPeriodDay(ENUM_TIMEFRAMES period)
  {
    switch(period)
    {
      case PERIOD_M1: return false; break;
      case PERIOD_M2: return false; break;
      case PERIOD_M3: return false; break;
      case PERIOD_M4: return false; break;
      case PERIOD_M5: return false; break;
      case PERIOD_M6: return false; break;
      case PERIOD_M10: return false; break;
      case PERIOD_M12: return false; break;
      case PERIOD_M15: return false; break;
      case PERIOD_M20: return false; break;
      case PERIOD_M30: return false; break;
      case PERIOD_H1: return false; break;
      case PERIOD_H2: return false; break;
      case PERIOD_H3: return false; break;
      case PERIOD_H4: return false; break;
      case PERIOD_H6: return false; break;
      case PERIOD_H8: return false; break;
      case PERIOD_H12: return false; break;
      default: return true; break;
    }
//---

  }
//+------------------------------------------------------------------+
