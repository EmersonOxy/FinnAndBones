package view.effect
{
   import cb.actions.RemoveFromParent;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class Effect
   {
      
      protected var effect:MovieClip;
      
      public function Effect(param1:MovieClip)
      {
         super();
         this.effect = param1;
      }
      
      public function playOn(param1:DisplayObjectContainer, param2:DisplayObjectContainer = null) : void
      {
         var _loc4_:Point = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Point = null;
         if(param2 == null)
         {
            _loc4_ = param1.localToGlobal(new Point(0,0));
            _loc5_ = main.popUpHolder;
            _loc6_ = _loc5_.globalToLocal(_loc4_);
            this.effect.x = _loc6_.x;
            this.effect.y = _loc6_.y;
            param2 = _loc5_;
         }
         param2.addChild(this.effect);
         this.effect.gotoAndPlay(1);
         var _loc3_:SmartMC = new SmartMC(this.effect);
         _loc3_.trigger(new EndAnimation(),new RemoveFromParent());
      }
      
      public function clear() : void
      {
         if(this.effect.parent != null)
         {
            this.effect.stop();
            this.effect.parent.removeChild(this.effect);
         }
         this.effect = null;
      }
   }
}

