package cb.signals
{
   import cb.utils.cbArray;
   
   public class Signal
   {
      
      private var slots:cbArray = new cbArray();
      
      public function Signal()
      {
         super();
      }
      
      public function add(param1:Function) : void
      {
         this.slots.push(param1);
      }
      
      public function addAtFirst(param1:Function) : void
      {
         this.slots.unshift(param1);
      }
      
      public function emit(... rest) : void
      {
         var _loc3_:Function = null;
         var _loc2_:cbArray = this.slots.clone();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.apply(null,rest);
         }
      }
      
      public function clear() : void
      {
         this.slots = new cbArray();
      }
      
      public function remove(param1:Function) : void
      {
         this.slots.remove(param1);
      }
   }
}

