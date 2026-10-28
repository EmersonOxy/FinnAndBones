package view.screens.main_game.states
{
   import cb.signals.Signal;
   import flash.display.DisplayObjectContainer;
   import main_game.dungeon.Dungeon;
   import main_game.map.Level;
   
   public interface IDungeonState
   {
      
      function enter() : void;
      
      function leave() : void;
      
      function get pauseHolder() : DisplayObjectContainer;
      
      function getDungeon() : Dungeon;
      
      function setNextDungeon(param1:Level) : void;
      
      function get onToDungeon() : Signal;
      
      function get onToMap() : Signal;
      
      function clear() : void;
   }
}

