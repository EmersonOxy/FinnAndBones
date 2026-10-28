package main_game.item_containers
{
   import main_game.items.Item;
   
   public class SlotChange
   {
      
      private var slot:ISlot;
      
      private var old_item:Item;
      
      private var new_item:Item;
      
      public function SlotChange(param1:ISlot, param2:Item, param3:Item)
      {
         super();
         this.slot = param1;
         this.old_item = param2;
         this.new_item = param3;
      }
      
      public function getSlot() : ISlot
      {
         return this.slot;
      }
      
      public function getOldItem() : Item
      {
         return this.old_item;
      }
      
      public function getNewItem() : Item
      {
         return this.new_item;
      }
   }
}

