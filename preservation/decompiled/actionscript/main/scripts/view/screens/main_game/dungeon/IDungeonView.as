package view.screens.main_game.dungeon
{
   import main_game.dungeon.IFight;
   
   public interface IDungeonView
   {
      
      function get background() : BackgroundView;
      
      function onFight(param1:IFight) : void;
      
      function close() : void;
   }
}

