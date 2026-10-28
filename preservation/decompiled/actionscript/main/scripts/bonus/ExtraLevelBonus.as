package bonus
{
   import bonus.filter.BonusIcon;
   import bonus.filter.IBonusFilter;
   import bonus.filter.NoneFilter;
   import main_game.character.CharacterConfigData;
   import main_game.character.stats.LevelingEnemies;
   import main_game.element.Element;
   
   public class ExtraLevelBonus implements IDailyBonus
   {
      
      private var extraLevel:int;
      
      private var filter:IBonusFilter;
      
      public function ExtraLevelBonus(param1:Number = 0, param2:IBonusFilter = null)
      {
         super();
         this.extraLevel = param1;
         if(param2 == null)
         {
            param2 = new NoneFilter();
         }
         this.filter = param2;
      }
      
      public function activate() : void
      {
         LevelingEnemies.setBonus(this);
      }
      
      public function apply(param1:CharacterConfigData, param2:LevelingEnemies) : void
      {
         var _loc3_:Element = param1.element;
         if(this.filter.doesApply(_loc3_))
         {
            param2.setExtraLevel(this.extraLevel);
         }
      }
      
      public function getIcon() : BonusIcon
      {
         return BonusIcon.getLevelIcon(this.extraLevel >= 0);
      }
      
      public function getFilter() : IBonusFilter
      {
         return this.filter;
      }
      
      public function getAction() : String
      {
         return BonusIcon.Kill;
      }
   }
}

