package util
{
   public class ProbabilisticSet
   {
      
      private var items:Array;
      
      private var probs:Array;
      
      private var totalProb:Number;
      
      public function ProbabilisticSet()
      {
         super();
         this.items = new Array();
         this.probs = new Array();
         this.totalProb = 0;
      }
      
      public function get length() : uint
      {
         return this.items.length;
      }
      
      public function pop() : Object
      {
         var _loc1_:int = this.getOne();
         return this.remove(_loc1_);
      }
      
      public function getElement() : Object
      {
         var _loc1_:int = this.getOne();
         return this.items[_loc1_];
      }
      
      private function remove(param1:int) : Object
      {
         var _loc2_:Number = Number(this.probs[param1]);
         var _loc3_:Object = this.items[param1];
         this.probs.splice(param1,1);
         this.items.splice(param1,1);
         this.totalProb -= _loc2_;
         return _loc3_;
      }
      
      private function getOne() : int
      {
         var _loc1_:Number = Math.random() * this.totalProb;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.items.length)
         {
            _loc2_ = Number(this.probs[_loc3_]);
            if(_loc1_ <= _loc2_)
            {
               return _loc3_;
            }
            _loc1_ -= _loc2_;
            _loc3_++;
         }
         return this.items.length;
      }
      
      public function contains(param1:Object) : Boolean
      {
         return this.getIndexOf(param1) >= 0;
      }
      
      private function getIndexOf(param1:Object) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = this.items.indexOf(param1);
         if(_loc2_ < 0 && param1.hasOwnProperty("equals"))
         {
            _loc3_ = 0;
            while(_loc3_ < this.items.length)
            {
               if(param1.equals(this.items[_loc3_]))
               {
                  return _loc3_;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function add(param1:Object, param2:Number = 1) : void
      {
         this.items.push(param1);
         this.probs.push(param2);
         this.totalProb += param2;
      }
   }
}

