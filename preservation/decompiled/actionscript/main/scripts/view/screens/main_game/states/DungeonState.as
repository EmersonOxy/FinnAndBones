package view.screens.main_game.states
{
   import cb.signals.Signal;
   import flash.display.DisplayObjectContainer;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.DungeonFactory;
   import main_game.map.Level;
   import view.screens.main_game.GameView;
   import view.screens.main_game.dungeon.DungeonView;
   
   public class DungeonState extends BasicPausableState implements IDungeonState
   {
      
      private var dungeon_view:DungeonView;
      
      private var dungeon:Dungeon;
      
      private var mainView:GameView;
      
      private var next_dungeon:Level;
      
      private var theOnToDungeon:Signal = new Signal();
      
      private var theOnToMap:Signal = new Signal();
      
      public function DungeonState(param1:String, param2:GameView, param3:Function = null, param4:Function = null)
      {
         this.mainView = param2;
         super(param1,param3,param4);
      }
      
      public function get onToDungeon() : Signal
      {
         return this.theOnToDungeon;
      }
      
      public function get onToMap() : Signal
      {
         return this.theOnToMap;
      }
      
      public function get pauseHolder() : DisplayObjectContainer
      {
         return this.mainView.pauseHolder;
      }
      
      override public function enter() : void
      {
         main.game.goToDungeon(this.next_dungeon);
         this.dungeon = main.game.getDungeon();
         this.dungeon_view = DungeonFactory.getInstance().getViewFor(this);
         this.mainView.gameHolder["dungeonView"] = this.dungeon_view;
         this.mainView.gameHolder.addChild(this.dungeon_view);
         super.enter();
      }
      
      override public function pause() : void
      {
         this.dungeon_view.pauseFight();
      }
      
      override public function resume() : void
      {
         this.dungeon_view.resumeFight();
      }
      
      public function setNextDungeon(param1:Level) : void
      {
         this.next_dungeon = param1;
      }
      
      override public function leave() : void
      {
         this.dungeon_view.close();
         main.game.getFinn().stats.refillHealth();
         main.game.exitDungeon();
         super.leave();
         this.dungeon = null;
      }
      
      public function getDungeon() : Dungeon
      {
         return this.dungeon;
      }
      
      override public function clear() : void
      {
         this.onToDungeon.clear();
         this.onToMap.clear();
         super.clear();
      }
   }
}

