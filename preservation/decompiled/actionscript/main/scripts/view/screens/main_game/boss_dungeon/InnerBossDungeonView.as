package view.screens.main_game.boss_dungeon
{
   import view.screens.main_game.dungeon.InnerDungeonView;
   
   public interface InnerBossDungeonView extends InnerDungeonView
   {
      
      function playMusic() : void;
      
      function stopMusic() : void;
   }
}

