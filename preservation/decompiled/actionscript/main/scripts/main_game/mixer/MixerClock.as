package main_game.mixer
{
   import cb.signals.Signal;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.items.Item;
   
   public class MixerClock
   {
      
      public var atEndMix:Signal;
      
      public var onTic:Signal;
      
      private var timer:Timer;
      
      private var duration:Number;
      
      public function MixerClock(param1:Item, param2:Item)
      {
         super();
         this.atEndMix = new Signal();
         this.onTic = new Signal();
         this.duration = param1.getMixTime() + param2.getMixTime();
      }
      
      public function start() : void
      {
         this.timer = new Timer(this.duration * 10,100);
         this.timer.addEventListener(TimerEvent.TIMER,this.tic);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.endMix);
         this.timer.start();
      }
      
      private function tic(param1:TimerEvent) : void
      {
         this.onTic.emit((param1.target as Timer).currentCount);
      }
      
      private function endMix(param1:TimerEvent) : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.endMix);
         this.timer.removeEventListener(TimerEvent.TIMER,this.onTic.emit);
         this.onTic.clear();
         this.timer = null;
         this.atEndMix.emit();
         this.clear();
      }
      
      public function stop() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
         }
         this.clear();
      }
      
      public function clear() : void
      {
         this.atEndMix.clear();
         this.onTic.clear();
         if(this.timer != null)
         {
            this.timer.stop();
         }
      }
   }
}

