package cb.utils
{
   import cb.signals.Signal;
   import flash.utils.Dictionary;
   
   public class Rule
   {
      
      public var completed:Signal = new Signal();
      
      private var rules:Dictionary = new Dictionary();
      
      public function Rule(... rest)
      {
         var _loc2_:String = null;
         super();
         for each(_loc2_ in rest)
         {
            this.set(_loc2_);
         }
      }
      
      public function isCompleted() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(_loc1_ in this.rules)
         {
            if(_loc1_ === false)
            {
               return false;
            }
         }
         return true;
      }
      
      public function check(param1:String) : void
      {
         this.rules[param1] = true;
         if(this.isCompleted())
         {
            this.completed.emit();
         }
      }
      
      public function set(param1:String, param2:Boolean = false) : void
      {
         this.rules[param1] = param2;
      }
      
      public function reason() : Array
      {
         var _loc3_:String = null;
         var _loc1_:Array = [];
         var _loc2_:Boolean = true;
         for(_loc3_ in this.rules)
         {
            _loc2_ = false;
            if(this.rules[_loc3_] !== true)
            {
               _loc1_.push(_loc3_ + " is " + this.rules[_loc3_]);
            }
         }
         if(_loc2_)
         {
            _loc1_.push("empty!");
         }
         return _loc1_;
      }
   }
}

