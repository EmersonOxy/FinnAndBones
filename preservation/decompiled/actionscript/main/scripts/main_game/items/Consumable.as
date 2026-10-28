package main_game.items
{
   import cb.signals.Signal;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.item_containers.ItemContainer;
   
   public class Consumable extends Category
   {
      
      public var atEndEffect:Signal;
      
      public var onChange:Signal;
      
      private var percent:int;
      
      private var timer:Timer;
      
      public function Consumable(param1:Item, param2:Object)
      {
         super(param1,param2);
         this.atEndEffect = new Signal();
         this.onChange = new Signal();
      }
      
      public function isInstant() : Boolean
      {
         return item.getPrimaryModifier().isInstant() && item.getSecondaryModifier().isInstant();
      }
      
      public function degrade() : void
      {
         if(this.timer == null)
         {
            main.game.onPause.add(this.pause);
            this.percent = 100;
            this.timer = new Timer(item.getDuration() * 10,100);
            this.timer.addEventListener(TimerEvent.TIMER,this.tick);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.complete);
            this.timer.start();
            this.onChange.emit(this.percent);
         }
      }
      
      private function pause(param1:Boolean) : void
      {
         if(param1)
         {
            this.timer.stop();
         }
         else
         {
            this.timer.start();
         }
      }
      
      private function tick(param1:TimerEvent) : void
      {
         --this.percent;
         this.onChange.emit(this.percent);
      }
      
      private function complete(param1:TimerEvent) : void
      {
         this.clearTimer();
         this.atEndEffect.emit(item);
      }
      
      override public function get type() : String
      {
         return CONSUMABLE_CATEGORY;
      }
      
      override public function canBeContained(param1:ItemContainer) : Boolean
      {
         return param1.canContainConsumable();
      }
      
      private function clearTimer() : void
      {
         if(this.timer != null)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.tick);
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.complete);
            this.timer.stop();
            this.timer = null;
            main.game.onPause.remove(this.pause);
         }
      }
      
      override public function clear() : void
      {
         this.clearTimer();
         this.atEndEffect.clear();
         this.atEndEffect = null;
         this.onChange.clear();
         this.onChange = null;
         super.clear();
      }
   }
}

