//+------------------------------------------------------------------+
//|                                                       Golang.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
void SayHere(const string text) 
  {
    printf("| Here there %s",text); 
  };

void SayInit(const string text) 
  {
    printf("| Init %s",text); 
  };

void SayTimeDo(const string text) 
  {
    printf("| Is Time Do %s",text); 
  };

void SayCandle(const string text) 
  {
    printf("| New bars %s",text); 
  };
  
void PeriodInput(const string text) 
  {
    printf("| Period input %s",text); 
  };

void PeriodSymbol(const string text) 
  {
    printf("| Period symbol %s",text); 
  };
  
void TimeError() 
  {
    printf("| Time error"); 
  };
  
void SignalBehind(const string text) 
  {
    printf("| Signal %s",text); 
  };
  
void ErrorSendRequest(const string text) 
  {
    printf("| Erro em OrderCheck %s",text); 
  };
  
void ErrorCodSendRequest(const string text) 
  {
    printf("| Erro em OrderCheck Cod %s",text); 
  };
  
void BetweenCloseEnd(const string text) 
  {
    printf("| Close and End %s",text); 
  };

void WriteCandle(const string high,const string open,const string close,const string low,const string i) 
  {
    printf("| Count %s = High %s - Open %s - Close %s - Low %s",i,high,open,close,low); 
  };

void WriteCandle(const string high,const string open,const string close,const string low,const string i,const string time,const string volume,const string pattern,const string symbol) 
  {
    printf("| Count %s = High %s - Open %s - Close %s - Low %s - Time %s - Volume %s - Pattern %s - Symbol %s",i,high,open,close,low,time,volume,pattern,symbol); 
  };
    
void WriteArquive(int arquive,const string text) 
  {
    if(arquive!=INVALID_HANDLE) {
      FileWrite(arquive,"TimeCurrent();"+(string)TimeCurrent());
      FileWrite(arquive,"Symbol();"+(string)Symbol());
      FileWrite(arquive,"_Period;"+(string)EnumToString(_Period));
      string terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
      FileWrite(arquive,"TerminalInfoString(TERMINAL_DATA_PATH);"+terminal_data_path);
      printf("| Path file = %s",terminal_data_path);
      FileWrite(arquive,text);
   }
  }

void WritePattern(string value) 
  {
    printf("| "+value+" pattern"); 
  };

void WriteSymbol(string value)
  {
    printf("| "+value+" symbol");
  }
void WriteDatabaseExist(const string value) 
  {
    printf("| Database %s exist",value); 
  };
void WriteConnect(const string value) 
  {
    printf("| Connect error: %s",value); 
  };
void WriteExecution(const string value) 
  {
    printf("| Execution error: %s",value); 
  };
void WriteTrade(const string value) 
  {
    printf("| Trade: %s",value); 
  };
  
void TrendFirst(const string text,const string kind) 
  {
    printf("| Trend First %s: %s",kind,text); 
  };

void TrendLast(const string text,const string kind) 
  {
    printf("| Trend Last %s: %s",kind,text); 
  };
  
void Fibonacci0382(const string text) 
  {
    printf("| Fibonacci 38.2%: %s",text); 
  };
  
void Fibonacci0618(const string text) 
  {
    printf("| Fibonacci 61.8%: %s",text); 
  };  