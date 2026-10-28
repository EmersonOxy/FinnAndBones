package main_game.mixer
{
   import drag_and_drop.IDragContainer;
   import main_game.item_containers.Slot;
   import main_game.items.Item;
   
   public class MixSlot extends Slot
   {
      
      public function MixSlot()
      {
         super();
      }
      
      override public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
      
      override public function canSwap(param1:IDragContainer) : Boolean
      {
         return false;
      }
      
      override public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
   }
}

