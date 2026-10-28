package bonus
{
   import bonus.filter.BonusIcon;
   import bonus.filter.IBonusFilter;
   import bonus.filter.NoneFilter;
   import main_game.element.Element;
   import main_game.map.Level;
   
   public class ExtraDungeon implements IDailyBonus
   {
      
      private var dungeonId:String;
      
      private var element:String;
      
      public function ExtraDungeon(param1:String, param2:String)
      {
         super();
         this.dungeonId = param1;
         this.element = param2;
      }
      
      public function activate() : void
      {
         var _loc1_:Level = main.game.getMap().getLevel(this.dungeonId);
         _loc1_.unlock();
         main.game.getMap().unlockUnlocked();
      }
      
      public function getElement() : Element
      {
         return Element.parseElement(this.element);
      }
      
      public function getIcon() : BonusIcon
      {
         return BonusIcon.getExtraDungeon(this.element);
      }
      
      public function getFilter() : IBonusFilter
      {
         return new NoneFilter();
      }
      
      public function getAction() : String
      {
         return "";
      }
   }
}

