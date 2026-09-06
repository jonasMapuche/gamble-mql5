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
#define INTERNET_OPEN_TYPE_DIRECT 1
#define INTERNET_SERVICE_HTTP     3
#define INTERNET_FLAG_RELOAD      0x80000000
#define INTERNET_FLAG_SECURE      0x00800000 // Necessário para HTTPS
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
#import "mql.dll"
//int EnviarRequisicaoGet(string url, string &buffer, int bufferSize);
long SendRequestGet(string url, string response, int maxLen);
int WriteBuffer(string text, string &buffer, int bufferSize);
int RequestGet(string text, string &buffer, int bufferSize);
int RequestPost(string text, string &buffer, int bufferSize, string data);
#import
#import "push.dll"
int HelloWorld(string text, string &buffer, int bufferSize);
int Token(string text);
int Push(string text, int bufferSize);
#import
//+------------------------------------------------------------------+
//| Variable                                                         |
//+------------------------------------------------------------------+
string url_request = "http://192.168.0.3:8885";
string token_push = "eDstusWdTRWf8_s_QOcYBD:APA91bE_je7sCVQXHeIlVhYwKqMJv6B6HEhkqr_LVACQ9ld5OfbdO2Gu7evocrYNkZF2VSJ6WoAnOHygKptp4mW-URnwHaUeBrGfB7PGo5oJSgxZIR5BlMY";
//+------------------------------------------------------------------+
//| Function                                                         |
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

void CreateDatabaseError(const string value) 
  {
    printf("| Database create error %s",value); 
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

void WriteMovingAverage(const string text,const string kind) 
  {
    printf("| Moving Average %s: %s",kind,text);  
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

void GetRequest(const string text) 
  {
    printf("| Request GET: %s",text); 
  };

void PostRequest(const string text) 
  {
    printf("| Request POST: %s",text); 
  };

void PushMessage(const string text) 
  {
    printf("| Push: %s",text); 
  };
  
void GolangDLLGet()
  {
    string url = url_request;
    string answer; 
    StringInit(answer, 2048, 0);
    int code = RequestGet(url, answer, 2048); 
    GetRequest(answer);
  }; 
  
void GolangDLLPost(string data)
  {
    string url = url_request;
    string answer; 
    StringInit(answer, 2048, 0);
    int code = RequestPost(url, answer, 2048, data); 
    PostRequest(answer);
  };  

void SendPush(string notification)
  {
    string token;
    StringInit(token, 2048, 0);
    token=token_push;
    int code = Token(token);
    if (code != 1) return;
    string data;
    StringInit(data, 2048, 0);
    data=notification;
    int feedback = Push(data, 2048);
    if (feedback != 1) return; 
    PushMessage(notification);
  }; 
  
/*
//--- enviamos a notificação
    if(!TerminalInfoInteger(TERMINAL_NOTIFICATIONS_ENABLED))
      Print("Error. The client terminal does not have permission to send notifications");
    ResetLastError();
    if(!SendNotification("Ola"))
      Print("SendNotification() failed. Error ",GetLastError());
*/
  
