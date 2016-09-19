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
class orderState
  {
private:

		int orderTicket;
		string symbol;
		double openPrice;
		double orderLots;
		datetime orderOpenTime;
		int orderType;
		string strOrderType;
		double orderTakeProfit;
		double orderStopLoss;
		

public:
		 orderState();
		~orderState();
		
		int getOrderTicket();
		void setOrderTicket(int orderTicket);
		string getSymbol();
		void setSymbol(string symbol);
		double getOpenPrice();
		void setOpenPrice(double openPrice);
		double getOrderLots();
		void setOrderLots(double orderLots);
		datetime getOrderOpenTime();
		void setOrderOpenTime(datetime orderOpenTime);
		int getOrderType();
		void setOrderType(int orderType);
		string getStrOrderType();
		void setStrOrderType(string strOrderType);
		double getOrderTakeProfit();
		void setOrderTakeProfit(double orderTakeProfit);
		double getOrderStopLoss();
		void setOrderStopLoss(double orderStopLoss);
		string toJson();

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
orderState::orderState()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
orderState::~orderState()
  {
  }
//+------------------------------------------------------------------+

int orderState::getOrderTicket() {
	return orderTicket;
}

void orderState::setOrderTicket(int orderTicket) {
	this.orderTicket = orderTicket;
}

string orderState::getSymbol() {
	return symbol;
}

void orderState::setSymbol(string symbol) {
	this.symbol = symbol;
}

double orderState::getOpenPrice() {
	return openPrice;
}

void orderState::setOpenPrice(double openPrice) {
	this.openPrice = openPrice;
}

double orderState::getOrderLots() {
	return orderLots;
}

void orderState::setOrderLots(double orderLots) {
	this.orderLots = orderLots;
}

datetime orderState::getOrderOpenTime() {
	return orderOpenTime;
}

void orderState::setOrderOpenTime(datetime orderOpenTime) {
	this.orderOpenTime = orderOpenTime;
}

int orderState::getOrderType() {
	return orderType;
}

void orderState::setOrderType(int orderType) {
	this.orderType = orderType;
	switch(orderType)
	{
		case 0: strOrderType = "OP_BUY"; break;
		case 1: strOrderType = "OP_SELL";  break;
		case 2: strOrderType = "OP_BUYLIMIT";  break;
		case 3: strOrderType = "OP_SELLLIMIT";  break;
		case 4: strOrderType = "OP_BUYSTOP";  break;
		case 5: strOrderType = "OP_SELLSTOP";  break;
	}
}

string orderState::getStrOrderType() {
	return strOrderType;
}

void orderState::setStrOrderType(string strOrderType) {
	this.strOrderType = strOrderType;
	
	if(!StringCompare(strOrderType,"OP_BUY",false))
		orderType = 0;
	else if(!StringCompare(strOrderType,"OP_SELL",false))
		orderType = 1;
	else if(!StringCompare(strOrderType,"OP_BUYLIMIT",false))
		orderType = 2;	
	else if(!StringCompare(strOrderType,"OP_SELLLIMIT",false))
		orderType = 3;	
	else if(!StringCompare(strOrderType,"OP_BUYSTOP",false))
		orderType = 4;	
	else if(!StringCompare(strOrderType,"OP_SELLSTOP",false))
		orderType = 5;	

}

double orderState::getOrderTakeProfit() {
	return orderTakeProfit;
}

void orderState::setOrderTakeProfit(double orderTakeProfit) {
	this.orderTakeProfit = orderTakeProfit;
}

double orderState::getOrderStopLoss() {
	return orderStopLoss;
}

void orderState::setOrderStopLoss(double orderStopLoss) {
	this.orderStopLoss = orderStopLoss;
}

string orderState::toJson(){
		
		string res = "{" 
			+ "\"orderTicket\":" + orderTicket
			+ ",\"symbol\":\""+symbol+"\""
			+ ",\"openPrice\":" + openPrice
			+ ",\"orderLots\":" + orderLots
			+ ",\"orderOpenTime\":\""+orderOpenTime+"\""
			+ ",\"orderType\":" + orderType
			+ ",\"strOrderType\":\""+strOrderType+"\""
			+ ",\"orderTakeProfit\":" + orderTakeProfit
			+ ",\"orderStopLoss\":" + orderStopLoss
			+ "}";
		
		return res;
}


