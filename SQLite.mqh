//+------------------------------------------------------------------+
//|                                                       SQLite.mqh |
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
#include "Golang.mqh"
//+------------------------------------------------------------------+
//| Variable                                                        |
//+------------------------------------------------------------------+
string filename="worm.db";
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
      bool TestConnect(const string value);
      void SaveChoise(const string date,const string pattern,const string symbol,const string time,const string value,const string state,const long volume);
      void SaveHistory(const string date,const string order,const string type,const string symbol,const string state,const string price,const string takeprofit,const string stoploss,const string volume,const string root);
      void SaveRule(const string date,const string pattern,const string symbol,const string time,const string type,const string logic);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SQLite::SQLite()
  {
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
bool SQLite::TestConnect(const string value)
  {
//--- create or open the database in the common terminal folder
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE | DATABASE_OPEN_COMMON);
    if(db==INVALID_HANDLE){
      WriteConnect(DoubleToString(GetLastError()));
      return false;
    }
//---
/*
    if(!DatabaseExecute(db, "CREATE TABLE DEALS("
                          "ID          INT KEY NOT NULL,"
                          "ORDER_ID    INT     NOT NULL);")){
         Print("DB: create the DEALS table  failed with code ", GetLastError());
         return(false);
    }
    */
//---
    if(DatabaseTableExists(db,"Hit")){
      WriteDatabaseExist(value);
      //--- close the database
      DatabaseClose(db);
      return true;
    }
    //--- close the database
    DatabaseClose(db);
    return false;
  }
//+------------------------------------------------------------------+
//| Save datatabase hit                                              |
//+------------------------------------------------------------------+
void SQLite::SaveData(const string date,const string pattern,const string symbol,const string time)
  {
//---
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
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
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
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
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
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
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
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
    int db=DatabaseOpen(filename, DATABASE_OPEN_READWRITE | DATABASE_OPEN_CREATE |DATABASE_OPEN_COMMON);
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
