package main_game.items.modifiers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import main_game.character.stats.Stats;
   
   public interface IModifier
   {
      
      function modifyIcon(param1:MovieClip) : void;
      
      function modifyValue(param1:TextField, param2:int) : void;
      
      function affect(param1:Stats) : void;
      
      function disaffect(param1:Stats) : void;
      
      function getValue() : Number;
      
      function getCategory() : int;
      
      function isInstant() : Boolean;
      
      function toObject() : *;
      
      function clear() : void;
   }
}

