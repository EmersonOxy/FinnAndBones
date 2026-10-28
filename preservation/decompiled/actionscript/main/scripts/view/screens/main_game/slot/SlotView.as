package view.screens.main_game.slot
{
   import main_game.item_containers.ISlot;
   import view.items.ItemView;
   
   public class SlotView extends BasicSlotView
   {
      
      public static var EMPTY:String = "empty";
      
      public static var EQUIPMENT:String = "equipment";
      
      public static var WEAPONS:String = "weapons";
      
      public static var CONSUMABLE:String = "consumables";
      
      public function SlotView(param1:ISlot)
      {
         super(param1);
      }
      
      override protected function updateState(param1:ItemView) : void
      {
         if(param1 == null || hide)
         {
            bg.slot.gotoAndStop(EMPTY);
         }
         else
         {
            bg.slot.gotoAndStop(param1.getStateForSlot(this));
         }
      }
   }
}

