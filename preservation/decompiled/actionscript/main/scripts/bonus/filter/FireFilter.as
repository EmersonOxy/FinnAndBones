package bonus.filter
{
   import main_game.element.Element;
   
   public class FireFilter implements IBonusFilter
   {
      
      public function FireFilter()
      {
         super();
      }
      
      public function doesApply(param1:Element) : Boolean
      {
         return param1.isOfFire;
      }
      
      public function getIcons() : Vector.<BonusIcon>
      {
         var _loc1_:Vector.<BonusIcon> = new Vector.<BonusIcon>();
         _loc1_.push(BonusIcon.getFire());
         return _loc1_;
      }
   }
}

