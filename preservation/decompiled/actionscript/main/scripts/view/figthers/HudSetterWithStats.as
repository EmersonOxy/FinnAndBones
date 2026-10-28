package view.figthers
{
   import flash.display.MovieClip;
   import main_game.character.stats.Stats;
   
   public class HudSetterWithStats extends HudSetter
   {
      
      public function HudSetterWithStats()
      {
         super();
      }
      
      override public function setHud(param1:MovieClip, param2:Stats = null) : void
      {
         super.setHud(param1,param2);
         if(param2 != null)
         {
            param1.bar.title.visible = true;
            param1.attack.title.title.text = param2.getAttack();
            param1.luck.title.title.text = param2.getLuck();
            param1.defence.title.title.text = param2.getDefense();
         }
         else
         {
            param1.bar.title.visible = false;
            param1.attack.title.title.text = "-";
            param1.luck.title.title.text = "-";
            param1.defence.title.title.text = "-";
         }
      }
   }
}

