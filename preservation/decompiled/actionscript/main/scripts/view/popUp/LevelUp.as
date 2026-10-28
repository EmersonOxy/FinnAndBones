package view.popUp
{
   import cb.actions.RemoveFromParent;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import flash.display.MovieClip;
   import sound.GameSounds;
   
   public class LevelUp
   {
      
      private var mc:MovieClip;
      
      public function LevelUp()
      {
         super();
         this.mc = main.swfLoader.getObject("assets.LevelUp") as MovieClip;
         main.tutorialHolder.addChild(this.mc);
         this.mc.gotoAndPlay(1);
         main.soundManager.playFx(GameSounds.LEVEL_UP);
         new SmartMC(this.mc).trigger(new EndAnimation(),new RemoveFromParent());
      }
   }
}

