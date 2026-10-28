package view.figthers
{
   import main_game.character.Fighter;
   
   public class AnimatedHudView extends HudView
   {
      
      public function AnimatedHudView(param1:Class, param2:HudSetter)
      {
         super(param1,param2);
         this.mc.gotoAndStop("in");
      }
      
      override public function changeFighter(param1:Fighter) : void
      {
         if(stats == null && param1 != null)
         {
            mc.gotoAndPlay("in");
         }
         else if(stats != null && param1 == null)
         {
            mc.gotoAndPlay("out");
         }
         super.changeFighter(param1);
      }
   }
}

