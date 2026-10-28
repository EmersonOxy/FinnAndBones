package view.screens.main_game.inventory
{
   import cb.display.Screen;
   import flash.utils.Dictionary;
   import main_game.mixer.MixerClock;
   import view.effect.Effect;
   
   public class MixerClockView extends Screen
   {
      
      public function MixerClockView(param1:MixerClock)
      {
         super(main.swfLoader.getClass("assets.Time"),new Dictionary());
         param1.onTic.add(this.refresh);
         param1.atEndMix.add(this.removeClock);
         bg.gotoAndStop(0);
      }
      
      public function refresh(param1:uint) : void
      {
         this.bg.gotoAndStop(param1);
      }
      
      private function removeClock() : void
      {
         var _loc1_:Class = main.swfLoader.getClass("assets.Stars");
         var _loc2_:Effect = new Effect(new _loc1_());
         _loc2_.playOn(bg.parent);
         pop();
      }
   }
}

