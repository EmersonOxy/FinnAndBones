package main_game.dungeon
{
   import main_game.element.Element;
   
   public class ElementBonus
   {
      
      public var element:Element;
      
      public var value:Number;
      
      public function ElementBonus(param1:Element, param2:Number)
      {
         super();
         this.element = param1;
         this.value = param2;
      }
   }
}

