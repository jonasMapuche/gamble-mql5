//+------------------------------------------------------------------+
//|                                                    Heuristic.mqh |
//|                   Copyright 2023, Jonas Mapuche & Stomach.com.br |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Jonas Mapuche & Stomach.com.br"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "../Golang.mqh"
#include "../SQlite.mqh"
//+------------------------------------------------------------------+
//| Class                                                           |
//+------------------------------------------------------------------+
class Heuristic
  {
    private:
            
    public:
      Heuristic();
      ~Heuristic();
      double Euclidean(double &colum1[],double &colum2[],int quantity);
      void Save(const int line,const int colum,const double value);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
Heuristic::Heuristic()
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
Heuristic::~Heuristic()
  {
  }
//+------------------------------------------------------------------+
//| Calc position x,y                                                |
//+------------------------------------------------------------------+
double Heuristic::Euclidean(double &colum1[],double &colum2[],int quantity)
  {
    ArrayResize(colum1,quantity);
    ArrayResize(colum2,quantity);
    double subtract,power=0;
    double sum=0;
    for(int c=0;c<quantity;c++){
      subtract=colum1[c]-colum2[c];
      power=MathPow(subtract,2);
      sum=sum+power;
    }
    return MathSqrt(sum);
  } 
//+------------------------------------------------------------------+
//| Save position x,y                                                |
//+------------------------------------------------------------------+
void Heuristic::Save(const int line,const int colum,const double value)
  {
    const string name="EUCLIDEAN";
    SQLite *sqlite;
    sqlite=new SQLite();
    sqlite.SaveLink(name,line,colum,value);
  } 
//+------------------------------------------------------------------+
