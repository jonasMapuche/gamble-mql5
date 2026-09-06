//+------------------------------------------------------------------+
//|                                                       SQLite.mqh |
//|             Copyright 2026, César Cardoso Silva & Stomach.com.br |
//|                                             https://www.mql5.com |
//|                  AppData\Roaming\MetaQuotes\Terminal\Common\File |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Trade/SymbolInfo.mqh> 
#include "Golang.mqh"
//+------------------------------------------------------------------+
//| Variable                                                        |
//+------------------------------------------------------------------+
string file_name;
//+------------------------------------------------------------------+
//| Class                                                           |
//+------------------------------------------------------------------+
class SQLite
  {
    private:

    public:
      SQLite();
      ~SQLite();
      void SaveData(const string date,const string pattern,const string symbol,const string time);
      void SaveFault(const string date,const string pattern,const string symbol,const string time);
      void InitDatabase(const string value);
      void DropDatabase(const string value);
      void SaveChoise(const string date,const string pattern,const string symbol,const string time,const string value,const string state,const long volume);
      void SaveHistory(const string date,const string order,const string type,const string symbol,const string state,const string price,const string takeprofit,const string stoploss,const string volume,const string root);
      void SaveRule(const string date,const string pattern,const string symbol,const string time,const string type,const string logic);
      void SaveTrend(const string date,const string pattern,const string symbol,const string time);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
SQLite::SQLite()
  {
    file_name="raffle.db";
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
SQLite::~SQLite()
  {
  }
//+------------------------------------------------------------------+
//| Save datatabase                                                  |
//+------------------------------------------------------------------+
void SQLite::InitDatabase(const string value)
  {
//--- create or open the database in the common terminal folder
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE | DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseTableExists(db, "HIT")){
      string hit = "CREATE TABLE HIT ( ";
      hit += "date TEXT NOT NULL, ";
      hit += "symbol TEXT NOT NULL, ";
      hit += "pattern TEXT NOT NULL, ";
      hit += "date_time TEXT NOT NULL, ";
      hit += "period TEXT NOT NULL ";
      hit += "); ";
      if(!DatabaseExecute(db, hit)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(!DatabaseTableExists(db, "FAULT")){
      string fault = "CREATE TABLE FAULT ( ";
      fault += "date TEXT NOT NULL, ";
      fault += "symbol TEXT NOT NULL, ";
      fault += "pattern TEXT NOT NULL, ";
      fault += "date_time TEXT NOT NULL, ";
      fault += "period TEXT NOT NULL ";
      fault += "); ";
      if(!DatabaseExecute(db, fault)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(!DatabaseTableExists(db, "CHOISE")){
      string choise = "CREATE TABLE CHOISE ( ";
      choise += "date TEXT NOT NULL, ";
      choise += "symbol TEXT NOT NULL, ";
      choise += "pattern TEXT NOT NULL, ";
      choise += "date_time TEXT NOT NULL, ";
      choise += "value TEXT NOT NULL, ";
      choise += "state TEXT NOT NULL, ";
      choise += "volume TEXT NOT NULL, ";
      choise += "period TEXT NOT NULL ";
      choise += "); ";
      if(!DatabaseExecute(db, choise)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(!DatabaseTableExists(db, "RULE")){
      string rule = "CREATE TABLE RULE ( ";
      rule += "date TEXT NOT NULL, ";
      rule += "symbol TEXT NOT NULL, ";
      rule += "pattern TEXT NOT NULL, ";
      rule += "type TEXT NOT NULL, ";
      rule += "logic TEXT NOT NULL, ";
      rule += "date_time TEXT NOT NULL, ";
      rule += "period TEXT NOT NULL ";
      rule += "); ";
      if(!DatabaseExecute(db, rule)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(!DatabaseTableExists(db, "HISTORY")){
      string history = "CREATE TABLE HISTORY ( ";
      history += "date TEXT NOT NULL, ";
      history += "ticket TEXT NOT NULL, ";
      history += "type TEXT NOT NULL, ";
      history += "symbol TEXT NOT NULL, ";
      history += "state TEXT NOT NULL, ";
      history += "price TEXT NOT NULL, ";
      history += "takeprofit TEXT NOT NULL, ";
      history += "stoploss TEXT NOT NULL, ";
      history += "volume TEXT NOT NULL, ";
      history += "ticketroot TEXT NOT NULL, ";
      history += "period TEXT NOT NULL ";
      history += "); ";
      if(!DatabaseExecute(db, history)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(!DatabaseTableExists(db, "TREND")){
      string rule = "CREATE TABLE TREND ( ";
      rule += "date TEXT NOT NULL, ";
      rule += "symbol TEXT NOT NULL, ";
      rule += "pattern TEXT NOT NULL, ";
      rule += "date_time TEXT NOT NULL, ";
      rule += "period TEXT NOT NULL ";
      rule += "); ";
      if(!DatabaseExecute(db, rule)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
//---
    if(DatabaseTableExists(db,"HIT")){
      WriteDatabaseExist(value);
      //--- close the database
      DatabaseClose(db);
      return;
    }
    //--- close the database
    DatabaseClose(db);
    return;
  }
//+------------------------------------------------------------------+
//| Drop datatabase                                                  |
//+------------------------------------------------------------------+
void SQLite::DropDatabase(const string value)
  {
//--- create or open the database in the common terminal folder
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE | DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(DatabaseTableExists(db, "HIT")){
      string hit = "DROP TABLE HIT;";
      if(!DatabaseExecute(db, hit)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(DatabaseTableExists(db, "FAULT")){
      string fault = "DROP TABLE FAULT;";
      if(!DatabaseExecute(db, fault)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(DatabaseTableExists(db, "CHOISE")){
      string choise = "DROP TABLE CHOISE;";
      if(!DatabaseExecute(db, choise)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(DatabaseTableExists(db, "RULE")){
      string rule = "DROP TABLE RULE;";
      if(!DatabaseExecute(db, rule)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
    if(DatabaseTableExists(db, "HISTORY")){
      string history = "DROP TABLE HISTORY;";
      if(!DatabaseExecute(db, history)){
        CreateDatabaseError(DoubleToString(GetLastError()));
        DatabaseClose(db);
        return;
      }
    }
//---
    if(!DatabaseTableExists(db,"HIT")){
      WriteDatabaseExist(value);
      //--- close the database
      DatabaseClose(db);
      return;
    }
    //--- close the database
    DatabaseClose(db);
    return;
  }
//+------------------------------------------------------------------+
//| Save datatabase hit                                              |
//+------------------------------------------------------------------+
void SQLite::SaveData(const string date,const string pattern,const string symbol,const string time)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO HIT (PATTERN,SYMBOL,DATE,DATE_TIME,PERIOD) VALUES ('"+pattern+"','"+symbol+"','"+date+"','"+time+"','"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
//| Save datatabase fault                                            |
//+------------------------------------------------------------------+
void SQLite::SaveFault(const string date,const string pattern,const string symbol,const string time)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO FAULT (PATTERN,SYMBOL,DATE,DATE_TIME,PERIOD) VALUES ('"+pattern+"','"+symbol+"','"+date+"','"+time+"','"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
//| Save datatabase choise                                           |
//+------------------------------------------------------------------+
void SQLite::SaveChoise(const string date,const string pattern,const string symbol,const string time,const string value,const string state,const long volume)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO CHOISE (PATTERN,SYMBOL,DATE,DATE_TIME,VALUE,STATE,VOLUME,PERIOD) VALUES ('"+pattern+"','"+symbol+"','"+date+"','"+time+"','"+value+"','"+state+"',"+DoubleToString(volume)+",'"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
//| Save datatabase history                                          |
//+------------------------------------------------------------------+
void SQLite::SaveHistory(const string date,const string ticket,const string type,const string symbol,const string state,const string price,const string takeprofit,const string stoploss,const string volume,const string root)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO HISTORY (DATE,TICKET,TYPE,SYMBOL,STATE,PRICE,TAKEPROFIT,STOPLOSS,VOLUME,TICKETROOT,PERIOD) VALUES ('"+date+"','"+ticket+"','"+type+"','"+symbol+"','"+state+"','"+price+"','"+takeprofit+"','"+stoploss+"','"+volume+"','"+root+"','"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
//| Save datatabase rule                                             |
//+------------------------------------------------------------------+
void SQLite::SaveRule(const string date,const string pattern,const string symbol,const string time, const string type,const string logic)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO RULE (PATTERN,SYMBOL,DATE,TYPE,LOGIC,DATE_TIME,PERIOD) VALUES ('"+pattern+"','"+symbol+"','"+date+"','"+type+"','"+logic+"','"+time+"','"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
//| Save datatabase trend                                            |
//+------------------------------------------------------------------+
void SQLite::SaveTrend(const string date,const string pattern,const string symbol,const string time)
  {
//---
    int db=DatabaseOpen(file_name, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return;
    }
//---
    if(!DatabaseExecute(db, "INSERT INTO TREND (PATTERN,SYMBOL,DATE,DATE_TIME,PERIOD) VALUES ('"+pattern+"','"+symbol+"','"+date+"','"+time+"','"+EnumToString(_Period)+"');")){
      WriteExecution(DoubleToString(GetLastError()));
      DatabaseClose(db);
      return;
    }
//--- close the database
    DatabaseClose(db);
  }
//+------------------------------------------------------------------+
