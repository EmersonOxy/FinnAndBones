package view.effect
{
   import cb.utils.Random;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import sound.GameSounds;
   
   public class SmokeEffect extends Effect
   {
      
      public function SmokeEffect()
      {
         var _loc1_:MovieClip = main.swfLoader.getObject("assets.Smoke") as MovieClip;
         _loc1_.rotation = Random.nextInt(360);
         super(_loc1_);
      }
      
      override public function playOn(param1:DisplayObjectContainer, param2:DisplayObjectContainer = null) : void
      {
         super.playOn(param1,param2);
         main.soundManager.playFx(GameSounds.SMOKE);
      }
   }
}

