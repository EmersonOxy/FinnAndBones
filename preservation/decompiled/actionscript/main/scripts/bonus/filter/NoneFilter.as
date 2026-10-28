package bonus.filter
{
   import main_game.element.Element;
   
   public class NoneFilter implements IBonusFilter
   {
      
      public function NoneFilter()
      {
         super();
      }
      
      public function doesApply(param1:Element) : Boolean
      {
         return false;
      }
      
      public function getIcons() : Vector.<BonusIcon>
      {
         return new Vector.<BonusIcon>();
      }
   }
}

