package main_game.dungeon
{
   import cb.signals.Signal;
   import main_game.character.Enemy;
   
   public interface IFight
   {
      
      function getEnemy() : Enemy;
      
      function leave(param1:Function) : void;
      
      function fight() : void;
      
      function start() : void;
      
      function suddenDeath() : void;
      
      function deactivate() : void;
      
      function clear() : void;
      
      function isFirst() : Boolean;
      
      function get onEnter() : Signal;
      
      function get onExit() : Signal;
      
      function get onHit() : Signal;
      
      function get onLose() : Signal;
      
      function get onWin() : Signal;
   }
}

