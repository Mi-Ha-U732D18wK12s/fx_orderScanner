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
		
		public int getOrderTicket();
		public void setOrderTicket(int orderTicket);
		public string getSymbol();
		public void setSymbol(string symbol);
		public double getOpenPrice();
		public void setOpenPrice(double openPrice);
		public double getOrderLots();
		public void setOrderLots(double orderLots);
		public datetime getOrderOpenTime();
		public void setOrderOpenTime(datetime orderOpenTime);
		public int getOrderType();
		public void setOrderType(int orderType);
		public string getStrOrderType();
		public void setStrOrderType(string strOrderType);
		public double getOrderTakeProfit();
		public void setOrderTakeProfit(double orderTakeProfit);
		public double getOrderStopLoss();
		public void setOrderStopLoss(double orderStopLoss);
		public string toJson();

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

public int orderState::getOrderTicket() {
	return orderTicket;
}

public void orderState::setOrderTicket(int orderTicket) {
	this.orderTicket = orderTicket;
}

public string orderState::getSymbol() {
	return symbol;
}

public void orderState::setSymbol(string symbol) {
	this.symbol = symbol;
}

public double orderState::getOpenPrice() {
	return openPrice;
}

public void orderState::setOpenPrice(double openPrice) {
	this.openPrice = openPrice;
}

public double orderState::getOrderLots() {
	return orderLots;
}

public void orderState::setOrderLots(double orderLots) {
	this.orderLots = orderLots;
}

public datetime orderState::getOrderOpenTime() {
	return orderOpenTime;
}

public void orderState::setOrderOpenTime(datetime orderOpenTime) {
	this.orderOpenTime = orderOpenTime;
}

public int orderState::getOrderType() {
	return orderType;
}

public void orderState::setOrderType(int orderType) {
	this.orderType = orderType;
	switch()
	{
		case 0: strOrderType = "OP_BUY";
		case 1: strOrderType = "OP_SELL";
		case 2: strOrderType = "OP_BUYLIMIT";
		case 3: strOrderType = "OP_SELLLIMIT";
		case 4: strOrderType = "OP_BUYSTOP";
		case 5: strOrderType = "OP_SELLSTOP";
	}
}

public string orderState::getStrOrderType() {
	return strOrderType;
}

public void orderState::setStrOrderType(string strOrderType) {
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

public double orderState::getOrderTakeProfit() {
	return orderTakeProfit;
}

public void orderState::setOrderTakeProfit(double orderTakeProfit) {
	this.orderTakeProfit = orderTakeProfit;
}

public double orderState::getOrderStopLoss() {
	return orderStopLoss;
}

public void orderState::setOrderStopLoss(double orderStopLoss) {
	this.orderStopLoss = orderStopLoss;
}

public string orderState::toJson(){
		
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


