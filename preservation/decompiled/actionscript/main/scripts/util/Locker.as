package util
{
   import cb.signals.Signal;
   
   public class Locker
   {
      
      private var locked:Boolean;
      
      private var lockSignal:Signal;
      
      public function Locker(param1:Boolean = false)
      {
         super();
         this.locked = param1;
         this.lockSignal = new Signal();
      }
      
      public function get onLock() : Signal
      {
         return this.lockSignal;
      }
      
      public function get isLocked() : Boolean
      {
         return this.locked;
      }
      
      public function lock() : void
      {
         if(!this.locked)
         {
            this.locked = true;
            this.onLock.emit(this);
         }
      }
      
      public function unlock() : void
      {
         if(this.locked)
         {
            this.locked = false;
            this.onLock.emit(this);
         }
      }
      
      public function clear() : void
      {
         this.lockSignal.clear();
         this.lockSignal = null;
      }
   }
}

