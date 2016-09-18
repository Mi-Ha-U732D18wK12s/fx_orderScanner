//+------------------------------------------------------------------+
//|                                                   scanOrders.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class scanOrders
  {
private:

public:
                     scanOrders();
                    ~scanOrders();
                    
                    void scan();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
scanOrders::scanOrders()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
scanOrders::~scanOrders()
  {
  }
//+------------------------------------------------------------------+
void scanOrders::scan()
  {
      int cnt = OrdersTotal();
      for (int i=0; i<cnt; i++) {
      
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
         string sumb = OrderSymbol();
         Print("sumb:" + sumb);
         
         int omag = OrderMagicNumber();
         Print("omag:" + omag);
       
         double openpric = OrderOpenPrice();
         Print("openpric:" + openpric);
       
         double  ol = OrderLots();
         Print("ol:" + ol);
         
         datetime  otime = OrderOpenTime();
         Print("otime:" + otime);
         
         double  profit = OrderTakeProfit();
         Print("profit:" + profit);
         
         double  stop = OrderStopLoss();
         Print("stop:" + stop);
         
         int  tic = OrderTicket();
         Print("tic:#" + tic);
         
         int  type = OrderType();
         Print("type:" + type);
       
      }
  }