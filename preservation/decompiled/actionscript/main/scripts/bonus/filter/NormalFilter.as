package bonus.filter
{
   import main_game.element.Element;
   
   public class NormalFilter implements IBonusFilter
   {
      
      public function NormalFilter()
      {
         super();
      }
      
      public function doesApply(param1:Element) : Boolean
      {
         return !param1.isOfFire && !param1.isOfIce;
      }
      
      public function getIcons() : Vector.<BonusIcon>
      {
         var _loc1_:Vector.<BonusIcon> = new Vector.<BonusIcon>();
         _loc1_.push(BonusIcon.getNormal());
         return _loc1_;
      }
   }
}

