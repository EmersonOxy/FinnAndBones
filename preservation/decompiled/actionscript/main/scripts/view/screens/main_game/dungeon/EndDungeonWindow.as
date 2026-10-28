package view.screens.main_game.dungeon
{
   import cb.signals.Signal;
   import flash.display.DisplayObjectContainer;
   import view.screens.main_game.states.IPausable;
   
   public interface EndDungeonWindow extends IPausable
   {
      
      function getOnReplay() : Signal;
      
      function getOnBackToMap() : Signal;
      
      function enter(param1:Function = null) : void;
      
      function putIn(param1:DisplayObjectContainer) : void;
   }
}

