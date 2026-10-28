package view.screens.main_game.boss_dungeon
{
   import cb.signals.Signal;
   import view.screens.main_game.GameView;
   import view.screens.main_game.states.DungeonState;
   
   public class BossDungeonState extends DungeonState
   {
      
      private var _onToOutro:Signal = new Signal();
      
      public function BossDungeonState(param1:String, param2:GameView, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get onToOutro() : Signal
      {
         return this._onToOutro;
      }
   }
}

