package main_game.inventory
{
   import main_game.item_containers.Slot;
   import main_game.item_containers.SlotChange;
   import main_game.items.Item;
   
   public class Inventory
   {
      
      public static var SLOTS:uint = 12;
      
      private var slots:Array;
      
      private var trash:Trash;
      
      public function Inventory()
      {
         super();
         this.trash = new Trash();
         this.slots = new Array(SLOTS);
         var _loc1_:uint = 0;
         while(_loc1_ < SLOTS)
         {
            this.slots[_loc1_] = new Slot();
            _loc1_++;
         }
         this.loadData();
      }
      
      private function loadData() : void
      {
         var _loc1_:Item = null;
         var _loc2_:uint = 0;
         while(_loc2_ < SLOTS)
         {
            _loc1_ = main.saveSystem.loadInventoryItem(_loc2_);
            if(_loc1_ != null)
            {
               this.slots[_loc2_].add(_loc1_);
            }
            this.slots[_loc2_].onChange.add(this.saveSlot(_loc2_));
            _loc2_++;
         }
      }
      
      private function saveSlot(param1:uint) : Function
      {
         var i:uint = param1;
         return function(param1:SlotChange):void
         {
            main.saveSystem.saveInventorySlot(i,param1.getNewItem());
         };
      }
      
      public function getEmptySlot() : Slot
      {
         var _loc1_:Slot = null;
         for each(_loc1_ in this.slots)
         {
            if(_loc1_.isEmpty())
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getTrash() : Trash
      {
         return this.trash;
      }
      
      public function itemOfSlot(param1:uint) : Item
      {
         return (this.slots[param1] as Slot).getContent() as Item;
      }
      
      public function getSlot(param1:uint) : Slot
      {
         return this.slots[param1] as Slot;
      }
      
      public function get fullSlots() : uint
      {
         var _loc2_:Slot = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this.slots)
         {
            if(!_loc2_.isEmpty())
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function clear() : void
      {
         var _loc1_:Slot = null;
         this.trash.clear();
         for each(_loc1_ in this.slots)
         {
            _loc1_.clear();
         }
      }
   }
}

