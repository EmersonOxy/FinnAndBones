package main_game.item_containers
{
   import drag_and_drop.IDragContainer;
   import main_game.items.Item;
   
   public class OneTimeSlot extends Slot
   {
      
      public function OneTimeSlot(param1:Item)
      {
         super();
         this.add(param1);
      }
      
      override public function remove(param1:Item) : void
      {
         super.remove(param1);
         main.saveSystem.savePendingItems();
      }
      
      override public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
      
      override public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
      
      override public function canSwap(param1:IDragContainer) : Boolean
      {
         return false;
      }
   }
}

