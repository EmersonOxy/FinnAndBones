package main_game.character.stats
{
   public class Stat
   {
      
      protected var value:Number;
      
      protected var type:int;
      
      public function Stat(param1:int, param2:Number = 0)
      {
         super();
         this.value = param2;
         this.type = param1;
      }
      
      public function modifyValue(param1:Number) : void
      {
         this.value += param1;
      }
      
      public function getValue() : Number
      {
         return this.value;
      }
      
      public function clear() : void
      {
      }
   }
}

