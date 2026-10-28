package view.items
{
   import flash.display.MovieClip;
   import main_game.items.Item;
   import view.screens.main_game.slot.SlotView;
   
   public class EquipmentView extends ItemView
   {
      
      public function EquipmentView(param1:Item)
      {
         super(param1);
      }
      
      override public function getMC() : MovieClip
      {
         var _loc1_:MovieClip = super.getMC();
         if(_loc1_.hasOwnProperty("equip"))
         {
            item.getPrimaryModifier().modifyIcon(_loc1_.equip.gem1);
            item.getSecondaryModifier().modifyIcon(_loc1_.equip.gem2);
         }
         return _loc1_;
      }
      
      override public function getStateForSlot(param1:SlotView) : String
      {
         return SlotView.EQUIPMENT;
      }
   }
}

