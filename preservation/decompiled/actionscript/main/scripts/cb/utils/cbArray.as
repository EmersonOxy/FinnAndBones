package cb.utils
{
   public dynamic class cbArray extends Array
   {
      
      public function cbArray(... rest)
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         super();
         var _loc2_:uint = uint(rest.length);
         if(_loc2_ == 1 && rest[0] is Number)
         {
            _loc3_ = Number(rest[0]);
            _loc4_ = _loc3_;
            if(_loc4_ != _loc3_)
            {
               throw new RangeError("Array index is not a 32-bit unsigned integer (" + _loc3_ + ")");
            }
            length = _loc4_;
         }
         else
         {
            length = _loc2_;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               this[_loc5_] = rest[_loc5_];
               _loc5_++;
            }
         }
      }
      
      public static function createFromArray(param1:Array) : cbArray
      {
         var _loc3_:* = undefined;
         var _loc2_:cbArray = new cbArray();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function shuffle() : cbArray
      {
         var _loc1_:cbArray = this.clone();
         var _loc2_:cbArray = new cbArray();
         while(_loc1_.length > 0)
         {
            _loc2_.push(_loc1_.splice(Math.round(Math.random() * (_loc1_.length - 1)),1)[0]);
         }
         return _loc2_;
      }
      
      public function pushIfNotPresent(param1:*) : void
      {
         if(indexOf(param1) < 0)
         {
            push(param1);
         }
      }
      
      public function remove(param1:*, param2:* = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            _loc3_ = indexOf(param1);
         }
         else
         {
            _loc3_ = this.indexOfField(param1,param2);
         }
         if(_loc3_ < 0)
         {
            return;
         }
         splice(_loc3_,1);
      }
      
      public function indexOfField(param1:*, param2:*) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < length)
         {
            if(param1 === this[_loc3_][param2])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function indexOfMethodValue(param1:*, param2:String) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < length)
         {
            if(param1 === this[_loc3_][param2]())
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function findFirstOfField(param1:*, param2:*) : *
      {
         var _loc3_:int = 0;
         while(_loc3_ < length)
         {
            if(param1 === this[_loc3_][param2])
            {
               return this[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function findFirstFromMethodValue(param1:*, param2:String) : *
      {
         var _loc3_:int = 0;
         while(_loc3_ < length)
         {
            if(param1 === this[_loc3_][param2]())
            {
               return this[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function clone() : cbArray
      {
         var _loc1_:cbArray = new cbArray();
         var _loc2_:int = 0;
         while(_loc2_ < length)
         {
            _loc1_.push(this[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function subtract(param1:Array) : cbArray
      {
         var _loc4_:int = 0;
         var _loc2_:cbArray = this.clone();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = _loc2_.indexOf(param1[_loc3_]);
            if(_loc4_ >= 0)
            {
               _loc2_.splice(_loc4_,1);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

