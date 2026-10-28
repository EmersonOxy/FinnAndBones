package view.figthers.animations
{
   import main_game.element.Element;
   import view.figthers.FighterView;
   
   public class DieAnimation extends FighterAnimation
   {
      
      private static const DIE:String = "die";
      
      private var element:Element;
      
      public function DieAnimation(param1:Element = null)
      {
         super(DIE);
      }
      
      override public function make(param1:FighterView) : void
      {
         param1.fighterSoundManager.playDie();
         super.make(param1);
         setEffect(param1.getMC(),this.element);
      }
      
      override public function forceKill() : Boolean
      {
         return true;
      }
      
      override public function mustGoToIdle() : Boolean
      {
         return false;
      }
   }
}

