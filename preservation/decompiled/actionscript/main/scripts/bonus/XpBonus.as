package bonus
{
   import bonus.filter.AllFilter;
   import bonus.filter.BonusIcon;
   import bonus.filter.IBonusFilter;
   import main_game.character.Enemy;
   import main_game.character.stats.StatType;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.IXpCalculator;
   import main_game.dungeon.XpCalculator;
   
   public class XpBonus implements IDailyBonus, IXpCalculator
   {
      
      private var value:Number;
      
      private var filter:IBonusFilter;
      
      private var xpCalculator:IXpCalculator;
      
      public function XpBonus(param1:Number = 100, param2:IBonusFilter = null)
      {
         super();
         this.value = param1 / 100;
         if(param2 == null)
         {
            param2 = new AllFilter();
         }
         this.filter = param2;
      }
      
      public function activate() : void
      {
         this.xpCalculator = new XpCalculator();
         Dungeon.xpCalulator = this;
      }
      
      public function getXp(param1:Array) : int
      {
         var _loc3_:Enemy = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.stats.getStat(StatType.EXPERIENCE).getValue();
            if(this.filter.doesApply(_loc3_.getElement()))
            {
               _loc4_ = Math.ceil(_loc4_ * this.value);
            }
            _loc2_ += _loc4_;
         }
         return _loc2_;
      }
      
      public function getMixXp(param1:int) : Number
      {
         return this.xpCalculator.getMixXp(param1);
      }
      
      public function getCriticalXp(param1:int) : Number
      {
         return this.xpCalculator.getCriticalXp(param1);
      }
      
      public function getIcon() : BonusIcon
      {
         return BonusIcon.getXpIcon();
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

