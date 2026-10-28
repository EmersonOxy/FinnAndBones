package view.items
{
   import flash.display.MovieClip;
   import main_game.items.Item;
   import view.screens.main_game.slot.SlotView;
   
   public class WeaponView extends ItemView
   {
      
      public function WeaponView(param1:Item)
      {
         super(param1);
      }
      
      override public function getMC() : MovieClip
      {
         var _loc1_:MovieClip = super.getMC();
         item.getSecondaryModifier().modifyIcon(_loc1_.sword.gem);
         return _loc1_;
      }
      
      override public function getStateForSlot(param1:SlotView) : String
      {
         return SlotView.WEAPONS;
      }
   }
}

