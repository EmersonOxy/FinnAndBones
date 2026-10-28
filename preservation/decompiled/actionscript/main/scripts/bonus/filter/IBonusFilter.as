package bonus.filter
{
   import main_game.element.Element;
   
   public interface IBonusFilter
   {
      
      function doesApply(param1:Element) : Boolean;
      
      function getIcons() : Vector.<BonusIcon>;
   }
}

