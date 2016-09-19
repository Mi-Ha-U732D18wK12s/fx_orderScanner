//+------------------------------------------------------------------+
//|                                                   scanOrders.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "orderState.mqh"
//#include "hash.mqh"
//#include "json.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class scanOrders
  {
private:
		string strFileName;

public:
		scanOrders(string nameStorage);
		~scanOrders();
		string scan();
		bool scanAndSave();
		string StringArrayToJson( int sizeArray, string& strArray[] );
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
scanOrders::scanOrders()
  {
	strFileName = "";
  }*/
  
scanOrders::scanOrders(string nameStorage)
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
		return "";
		
	  string strJson = "[";
	  orderState arrayOrderSt[];
	  ArrayResize(arrayOrderSt,cnt,2);
	  //ArrayInitialize(arrayOrderSt,new orderState());
	  
	  string arrayStrJson[];
	  ArrayResize(arrayStrJson,cnt,2);
	 // ArrayInitialize(arrayStrJson, "");
	  
	  int cntOrders = 0;
	  
      for (int ind=0; ind<cnt; ind++) {
      
			if (!OrderSelect(ind, SELECT_BY_POS, MODE_TRADES)) continue;
	  
			arrayOrderSt[ind].setOrderTicket(OrderTicket());
			arrayOrderSt[ind].setSymbol(OrderSymbol());
			arrayOrderSt[ind].setOpenPrice(OrderOpenPrice());
			arrayOrderSt[ind].setOrderLots(OrderLots());
			arrayOrderSt[ind].setOrderOpenTime(OrderOpenTime());
			arrayOrderSt[ind].setOrderType(OrderType());
			
			arrayOrderSt[ind].setOrderTakeProfit(OrderTakeProfit());
			arrayOrderSt[ind].setOrderStopLoss(OrderStopLoss());
			cntOrders++;
			string str = arrayOrderSt[ind].toJson();
			arrayStrJson[ind] = arrayOrderSt[ind].toJson();
			str = arrayStrJson[ind];
			str = "";
			
      }

	  return StringArrayToJson( cntOrders, arrayStrJson);
}

bool scanOrders::scanAndSave()
{
	string strOrders = scan();
	  
	if(StringLen(strOrders) <2 )  
	   return true;
	  
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

string scanOrders::StringArrayToJson( int sizeArray, string& strArray[] ) {

	string strJson = "[";
	//int n = ArraySize( strArray );
	for( int ind = 0; ind < sizeArray; ind++ ) {
		
		if(ind>0)
			strJson = strJson + ",";
			
		string str = strArray[ind];
		strJson = strJson + strArray[ind];
	
	};
	strJson = strJson + "]";
	return strJson;
	
}