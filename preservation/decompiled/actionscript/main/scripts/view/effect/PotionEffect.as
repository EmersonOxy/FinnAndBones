package view.effect
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.character.stats.StatType;
   import main_game.items.Item;
   import main_game.items.modifiers.IModifier;
   
   public class PotionEffect
   {
      
      private var primaryEffect:MovieClip;
      
      private var secondaryEffect:MovieClip;
      
      private var timer:Timer;
      
      public function PotionEffect(param1:Item, param2:MovieClip)
      {
         super();
         this.primaryEffect = this.addPotionEffect(param1.getPrimaryModifier(),param2);
         this.secondaryEffect = this.addPotionEffect(param1.getSecondaryModifier(),param2,-9,7);
         this.timer = new Timer(2000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.endTimer);
         this.timer.start();
      }
      
      private function addPotionEffect(param1:IModifier, param2:MovieClip, param3:Number = 0, param4:Number = 0) : MovieClip
      {
         if(param1.getCategory() == StatType.NULL)
         {
            return null;
         }
         var _loc5_:MovieClip = main.swfLoader.getObject("assets.potionFeedback") as MovieClip;
         _loc5_.x += param3;
         _loc5_.y += param4;
         _loc5_.mouseEnabled = false;
         _loc5_.mouseChildren = false;
         param1.modifyIcon(_loc5_);
         param2.addChild(_loc5_);
         return _loc5_;
      }
      
      private function endTimer(param1:TimerEvent) : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.endTimer);
         this.timer.stop();
         this.timer = null;
         this.clear();
      }
      
      private function removeFromParent(param1:MovieClip) : void
      {
         if(Boolean(param1) && Boolean(param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
      
      private function clear() : void
      {
         this.removeFromParent(this.primaryEffect);
         this.primaryEffect = null;
         this.removeFromParent(this.secondaryEffect);
         this.secondaryEffect = null;
      }
      
      public function get x() : Number
      {
         if(this.primaryEffect)
         {
            return this.primaryEffect.x;
         }
         if(this.secondaryEffect)
         {
            return this.secondaryEffect.x;
         }
         return 0;
      }
      
      public function set x(param1:Number) : void
      {
         if(this.primaryEffect)
         {
            this.primaryEffect.x = param1;
         }
         if(this.secondaryEffect)
         {
            this.secondaryEffect.x = param1;
         }
      }
      
      public function get y() : Number
      {
         if(this.primaryEffect)
         {
            return this.primaryEffect.y;
         }
         if(this.secondaryEffect)
         {
            return this.secondaryEffect.y;
         }
         return 0;
      }
      
      public function set y(param1:Number) : void
      {
         if(this.primaryEffect)
         {
            this.primaryEffect.y = param1;
         }
         if(this.secondaryEffect)
         {
            this.secondaryEffect.y = param1;
         }
      }
      
      public function get scaleX() : Number
      {
         if(this.primaryEffect)
         {
            return this.primaryEffect.scaleX;
         }
         if(this.secondaryEffect)
         {
            return this.secondaryEffect.scaleX;
         }
         return 0;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(this.primaryEffect)
         {
            this.primaryEffect.scaleX = param1;
         }
         if(this.secondaryEffect)
         {
            this.secondaryEffect.scaleX = param1;
         }
      }
      
      public function get scaleY() : Number
      {
         if(this.primaryEffect)
         {
            return this.primaryEffect.scaleY;
         }
         if(this.secondaryEffect)
         {
            return this.secondaryEffect.scaleY;
         }
         return 0;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(this.primaryEffect)
         {
            this.primaryEffect.scaleY = param1;
         }
         if(this.secondaryEffect)
         {
            this.secondaryEffect.scaleY = param1;
         }
      }
   }
}

