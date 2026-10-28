package cb.gameloop
{
   import cb.signals.Signal;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class GameLoop
   {
      
      private var displayObject:DisplayObject;
      
      public var updated:Signal;
      
      private var lastUpdate:int;
      
      public function GameLoop(param1:DisplayObject)
      {
         super();
         this.displayObject = param1;
         this.updated = new Signal();
      }
      
      public function start() : void
      {
         this.lastUpdate = getTimer();
         this.displayObject.addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function update(param1:Event) : void
      {
         var _loc2_:int = getTimer() - this.lastUpdate;
         this.lastUpdate = getTimer();
         this.updated.emit(_loc2_);
      }
      
      public function stop() : void
      {
         this.displayObject.removeEventListener(Event.ENTER_FRAME,this.update);
      }
   }
}

