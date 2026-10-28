package main_game.character
{
   import main_game.element.Element;
   
   public interface CharacterConfigData
   {
      
      function get baseHP() : Number;
      
      function get baseAttack() : Number;
      
      function get baseDefense() : Number;
      
      function get baseLuck() : Number;
      
      function get baseXP() : Number;
      
      function get element() : Element;
      
      function get nameString() : String;
   }
}

