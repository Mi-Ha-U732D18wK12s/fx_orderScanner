//+------------------------------------------------------------------+
//|                                                      Storage.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ItemStorage
{
public:
	string key;
	string val;
};

class Storage
  {
   private:
		int sizearr;
		ItemStorage arrstor[];
		string strFileName;
		string strval;
		void ParseString(string str, ItemStorage *item);

   public:
        Storage();
        ~Storage();
      void clear();
      void set(string key, string val);
		string get(string key);
		void save(string filename);
		void read(string filename);
		
		void setDouble(string key, double val);
		double getDouble(string key);
		void setInt(string key, int val);
		int getInt(string key);
		void setBool(string key, bool val);
		bool getBool(string key);
		
		string checkBool(bool val1, bool val2, string name);
		string checkInt(int val1, int val2, string name);
		string checkDouble(double val1, double val2, string name);
        
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Storage::Storage()
  {
	sizearr = 32;
	int resAR = ArrayResize(arrstor, sizearr+1);
	if(resAR<0)
		Alert("Класс Storage, функция initStorage: ошибка при ресайзе массива");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Storage::~Storage()
  {
  }
//+------------------------------------------------------------------+
Storage::clear(){
  
   for(int ind = 0; ind < sizearr; ind++){
      arrstor[ind].key = "";
      arrstor[ind].val = "";
   }
  
 }

void Storage::set(string key, string val)
{
	//Сначала ищем запись с заданным ключем. Если находим, то присваиваем значение и выходим.
	for(int ind = 0; ind < sizearr; ind++){
		if( StringLen(arrstor[ind].key) > 0){
			int result=StringCompare(key,arrstor[ind].key);
			if( result == 0){
				arrstor[ind].val = val;
				return;
			}
		} 
	}
	//≈сли сюда пришли, значит ключ не нашли. Ищем запись с нулевым ключем и записываем пару "ключ-значение"
	for(int ind = 0; ind < sizearr; ind++){
		if( StringLen(arrstor[ind].key) > 0){

		} else {
			arrstor[ind].key = key;
			arrstor[ind].val = val;
			return;
		}
	}
	
	
}

string Storage::get(string key)
{
	for(int ind = 0; ind < sizearr; ind++){
		if( StringLen(arrstor[ind].key) > 0){
			int result=StringCompare(key,arrstor[ind].key);
			if( result == 0){
				return arrstor[ind].val;
			}
		} else {
			return "";
		}
	}
	return "";
}

void Storage::save(string filename)
{
	strFileName = filename;
	//Стираем файлы
	FileDelete(filename);
	//Открываем	
	int handle=FileOpen( strFileName,FILE_READ|FILE_WRITE|FILE_CSV );
	//Пишем
	for(int ind = 0; ind < sizearr; ind++){
	   if( StringLen(arrstor[ind].key) >0 ){
   		string strOut = arrstor[ind].key + "=" + arrstor[ind].val + "\r\n";
   		FileWriteString(handle, strOut);
		}
	}
	//«акрываем
	FileFlush(handle);
	FileClose(handle);
}

void Storage::read(string filename)
{
	string readstr;
	strFileName = filename;
	int handle=FileOpen( strFileName,FILE_READ|FILE_CSV );
	
	ItemStorage *item = new ItemStorage();
	while(!FileIsEnding(handle)){
      readstr =  FileReadString(handle);
	  ParseString(readstr, item);
	  set(item.key, item.val);
    }
	delete item;
	
	FileClose(handle);
}

void Storage::ParseString(string str, ItemStorage *item)
{
	string arrayres[];
	string sep="=";
	ushort u_sep=StringGetCharacter(sep,0);
    int k=StringSplit(str,u_sep,arrayres);
    item.key = arrayres[0];
    item.val = arrayres[1];
}

void Storage::setDouble(string key, double val)
{
	set(key, DoubleToString(val));
}
double Storage::getDouble(string key)
{
	strval = get(key);
	if( StringLen(strval) > 0){
		return(StringToDouble(strval));
	}
	return 0;
}
void Storage::setInt(string key, int val)
{
	set(key, IntegerToString(val));
}
int Storage::getInt(string key)
{
	strval = get(key);
	if( StringLen(strval) > 0){
		return(StringToInteger(strval));
	}
	return 0;
}
void Storage::setBool(string key, bool val)
{
	if(val)
		set(key, "1");
	else
		set(key, "0");
}
bool Storage::getBool(string key)
{
	strval = get(key);
	if( StringLen(strval) > 0){
		int result=StringCompare("1",strval);
		if(result == 0)
			return(true);
		else
			return(false);
	}
	return(false);
}
	
string Storage::checkBool(bool val1, bool val2, string name)
{
   string strres = "";
   if(val1 != val2){
	   strres = name + " ( " + val1 + " / " + val2 + " )  ";
	}
	return strres;
}
string Storage::checkInt(int val1, int val2, string name)
{
   string strres = "";
   if(val1 != val2){
	   strres = name + " ( " + IntegerToString(val1) + " / " + IntegerToString(val2) + " )  ";
	}
	return strres;
}
string Storage::checkDouble(double val1, double val2, string name)
{
   string strres = "";
   double vd1 = val1 * 10000;
   double vd2 = val2 * 10000;
   int vi1 = (int)vd1;
   int vi2 = (int)vd2;
   
   if(vi1 != vi2){
	   strres = name + " ( " + DoubleToString(val1,8) + " / " + DoubleToString(val2,8) + " )  ";
	}
	return strres;
}	


/*
void ParseString(string str, ItemStorage *item)
{
	uchar array[255];
	StringToCharArray(str,array,0,StringLen(str));
	int istart = 0;
	for(int ind = 1; ind<StringLen(str); ind++){
      if(array[ind] == ':'){
         item.key = CharArrayToString(array, istart, ind-istart, CP_ACP);
         istart = ind+1;
      }
	}
	item.val = CharArrayToString(array, istart, StringLen(str)-istart, CP_ACP);
}
*/
