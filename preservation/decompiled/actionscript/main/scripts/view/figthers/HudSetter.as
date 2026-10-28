package view.figthers
{
   import flash.display.MovieClip;
   import main_game.character.Fighter;
   import main_game.character.stats.Stats;
   
   public class HudSetter
   {
      
      public function HudSetter()
      {
         super();
      }
      
      public function setNameAndLevel(param1:MovieClip, param2:Fighter) : void
      {
         param1.player_name.title.text = param2.getNameToShow();
         param1.level.title.text = main.locale.get("enemy_level",[param2.stats.getLevel()]);
      }
      
      public function setHud(param1:MovieClip, param2:Stats = null) : void
      {
         if(param2 == null)
         {
            param1.player_name.title.text = "";
            param1.level.title.text = "";
         }
      }
   }
}

