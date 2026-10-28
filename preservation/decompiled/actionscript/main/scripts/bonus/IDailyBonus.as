package bonus
{
   import bonus.filter.BonusIcon;
   import bonus.filter.IBonusFilter;
   
   public interface IDailyBonus
   {
      
      function activate() : void;
      
      function getIcon() : BonusIcon;
      
      function getFilter() : IBonusFilter;
      
      function getAction() : String;
   }
}

