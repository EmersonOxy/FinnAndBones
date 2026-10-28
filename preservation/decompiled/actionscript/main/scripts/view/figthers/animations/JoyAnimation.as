package view.figthers.animations
{
   import sound.GameSounds;
   import view.figthers.FighterView;
   
   public class JoyAnimation extends FighterAnimation
   {
      
      public function JoyAnimation()
      {
         super("win");
      }
      
      override public function make(param1:FighterView) : void
      {
         main.soundManager.playFx(GameSounds.DUNGEON_COMPLETED);
         super.make(param1);
      }
   }
}

