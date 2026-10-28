package view.screens.main_game.boss_dungeon
{
   import main_game.dungeon.DungeonStats;
   import main_game.dungeon.Loot;
   import view.screens.main_game.dungeon.WinWindow;
   
   public class WinBossDungeonWindow extends WinWindow
   {
      
      private var _showMapAndReplay:Boolean;
      
      public function WinBossDungeonWindow(param1:Loot, param2:DungeonStats, param3:Boolean, param4:Function = null)
      {
         super(param1,param2,param4);
         this._showMapAndReplay = param3;
      }
      
      override public function enter(param1:Function = null) : void
      {
         super.enter(param1);
         if(!this._showMapAndReplay)
         {
            bg.removeChild(bg.replay);
            bg.removeChild(bg.level_select);
         }
      }
   }
}

