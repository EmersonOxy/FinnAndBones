package bonus.filter
{
   import main_game.element.Element;
   
   public class AllFilter implements IBonusFilter
   {
      
      public function AllFilter()
      {
         super();
      }
      
      public function doesApply(param1:Element) : Boolean
      {
         return true;
      }
      
      public function getIcons() : Vector.<BonusIcon>
      {
         var _loc1_:Vector.<BonusIcon> = new Vector.<BonusIcon>();
         _loc1_.push(BonusIcon.getNormal());
         _loc1_.push(BonusIcon.getFire());
         _loc1_.push(BonusIcon.getIce());
         return _loc1_;
      }
   }
}

