package bonus.filter
{
   import main_game.element.Element;
   
   public class IceFilter implements IBonusFilter
   {
      
      public function IceFilter()
      {
         super();
      }
      
      public function doesApply(param1:Element) : Boolean
      {
         return param1.isOfIce;
      }
      
      public function getIcons() : Vector.<BonusIcon>
      {
         var _loc1_:Vector.<BonusIcon> = new Vector.<BonusIcon>();
         _loc1_.push(BonusIcon.getIce());
         return _loc1_;
      }
   }
}

