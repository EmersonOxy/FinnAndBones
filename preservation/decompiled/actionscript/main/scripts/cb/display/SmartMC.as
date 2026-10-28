package cb.display
{
   import cb.actions.Action;
   import cb.conditions.Condition;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SmartMC
   {
      
      private var conditions:Array;
      
      private var mc:MovieClip;
      
      private var actions:Array;
      
      public function SmartMC(param1:MovieClip)
      {
         super();
         param1.addEventListener(Event.ENTER_FRAME,this.enterFrame);
         this.conditions = new Array();
         this.mc = param1;
         this.actions = new Array();
      }
      
      private function enterFrame(param1:Event) : void
      {
         var _loc3_:Action = null;
         var _loc4_:Object = null;
         var _loc2_:* = 0;
         while(_loc2_ < this.conditions.length)
         {
            _loc4_ = this.conditions[_loc2_];
            if(_loc4_.condition.complete(this.mc))
            {
               this.actions.push(_loc4_.action);
               this.conditions.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
         for each(_loc3_ in this.actions)
         {
            _loc3_.execute(this.mc);
         }
         this.actions = new Array();
         if(this.conditions == null || this.conditions.length == 0)
         {
            this.mc.removeEventListener(Event.ENTER_FRAME,this.enterFrame);
         }
      }
      
      public function trigger(param1:Condition, param2:Action) : void
      {
         this.conditions.push({
            "condition":param1,
            "action":param2
         });
      }
      
      public function clear() : void
      {
         this.mc.removeEventListener(Event.ENTER_FRAME,this.enterFrame);
         this.conditions = null;
      }
      
      public function equals(param1:MovieClip) : Boolean
      {
         return this.mc == param1;
      }
      
      public function rewind() : void
      {
         this.mc.parent.addEventListener(Event.ENTER_FRAME,this.rewindFrame);
      }
      
      public function stopRewind() : void
      {
         this.mc.parent.removeEventListener(Event.ENTER_FRAME,this.rewindFrame);
      }
      
      private function rewindFrame(param1:Event) : void
      {
         var _loc2_:int = this.mc.currentFrame;
         if(_loc2_ == 1)
         {
            this.stopRewind();
            return;
         }
         this.mc.prevFrame();
      }
   }
}

