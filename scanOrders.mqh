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
		string strFileName;

public:
		scanOrders();
		~scanOrders();
		string scan();
		bool scanAndSave();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
scanOrders::scanOrders(String nameStorage)
  {
	strFileName = nameStorage;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
scanOrders::~scanOrders()
  {
  }
//+------------------------------------------------------------------+
string scanOrders::scan()
{
      int cnt = OrdersTotal();
	  
	  if(cnt <= 0)
		return;
		
	  string strJson = "[";
	  orderState arrayOrderSt[];
	  ArrayResize(arrayOrderSt,cnt,2);
	  ArrayInitialize(arrayOrderSt,new orderState());
	  
	  string arrayStrJson[];
	  ArrayResize(arrayStrJson,cnt,2);
	  ArrayInitialize(arrayStrJson, "");
	  
	  int cntOrders = 0;
	  
      for (int ind=0; ind<cnt; ind++) {
      
			if (!OrderSelect(ind, SELECT_BY_POS, MODE_TRADES)) continue;
	  
			arrayOrderSt[ind].setOrderTicket(OrderTicket());
			arrayOrderSt[ind].setSymbol(OrderSymbol());
			arrayOrderSt[ind].setOpenPrice(OrderOpenPrice());
			arrayOrderSt[ind].setOrderLots(OrderLots());
			arrayOrderSt[ind].setOrderOpenTime(OrderOpenTime());
			arrayOrderSt[ind].setOrderType(OrderType());
			arrayOrderSt[ind].setStrOrderType(string strOrderType);
			arrayOrderSt[ind].setOrderTakeProfit(OrderTakeProfit());
			arrayOrderSt[ind].setOrderStopLoss(OrderStopLoss());
			cntOrders++;
			arrayStrJson[ind] = arrayOrderSt[ind].toJson();
      }

	  return StringArrayToJson( cntOrders, arrayStrJson);
}

bool scanOrders::scanAndSave()
{
	string strOrders = scan();
	  
	//Стираем файлы
	if(FileIsExist(strFileName)){
		FileDelete(strFileName);
	}

	int handle=FileOpen( strFileName,FILE_READ|FILE_WRITE|FILE_TXT );
	if(handle!=INVALID_HANDLE){
		FileWriteString(handle, strOrders);
		//Закрываем
		FileFlush(handle);
		FileClose(handle);
		
		return true;
	}
	return false;
	  
}