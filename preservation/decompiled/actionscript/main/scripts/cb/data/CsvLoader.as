package cb.data
{
   import cb.utils.cbArray;
   import flash.utils.Dictionary;
   
   public class CsvLoader extends TextLoader
   {
      
      public function CsvLoader(param1:String)
      {
         super(param1);
         loaded.addAtFirst(this.verifyData);
      }
      
      private function verifyData(param1:TextLoader) : void
      {
         var _loc3_:String = null;
         loaded.remove(this.verifyData);
         var _loc2_:Array = [];
         for each(_loc3_ in data)
         {
            if(_loc3_ != "")
            {
               _loc2_.push(_loc3_.split(","));
            }
         }
         data = cbArray.createFromArray(_loc2_);
      }
      
      public function getLines() : int
      {
         return data.length;
      }
      
      public function get(param1:int, param2:int = -1) : Object
      {
         if(param2 == -1)
         {
            return data[param1 - 1];
         }
         return data[param1 - 1][param2 - 1];
      }
      
      public function getColumns() : int
      {
         return data[0].length;
      }
      
      public function convertToObjects() : Dictionary
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc1_:Array = [];
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:int = 0;
         while(_loc3_ < data.length)
         {
            _loc4_ = "";
            _loc5_ = 0;
            while(_loc5_ < data[_loc3_].length)
            {
               if(_loc3_ == 0)
               {
                  _loc1_[_loc5_] = data[_loc3_][_loc5_];
               }
               else if(_loc5_ == 0)
               {
                  _loc4_ = data[_loc3_][_loc5_];
                  _loc2_[_loc4_] = new Object();
               }
               else
               {
                  _loc6_ = _loc2_[_loc4_];
                  _loc7_ = _loc1_[_loc5_];
                  _loc8_ = _loc7_.split(".");
                  if(_loc8_.length > 1)
                  {
                     if(_loc6_[_loc8_[0]] == null)
                     {
                        _loc6_[_loc8_[0]] = new Object();
                     }
                     _loc6_ = _loc6_[_loc8_[0]];
                     _loc7_ = _loc8_[1];
                  }
                  if(data[_loc3_][_loc5_] == "null")
                  {
                     _loc6_[_loc7_] = null;
                  }
                  else if(isNaN(data[_loc3_][_loc5_]))
                  {
                     _loc6_[_loc7_] = data[_loc3_][_loc5_];
                  }
                  else
                  {
                     _loc6_[_loc7_] = Number(data[_loc3_][_loc5_]);
                  }
               }
               _loc5_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

