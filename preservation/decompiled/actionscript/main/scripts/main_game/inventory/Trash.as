package main_game.inventory
{
   import cb.signals.Signal;
   import drag_and_drop.IDragContainer;
   import main_game.items.Item;
   import sound.GameSounds;
   
   public class Trash implements IDragContainer
   {
      
      public var onThrow:Signal;
      
      private var locked:Boolean;
      
      public function Trash()
      {
         super();
         this.locked = false;
         this.onThrow = new Signal();
      }
      
      public function remove(param1:Item) : void
      {
         throw new Error("Trash Cant Remove Items");
      }
      
      public function canRemove(param1:Item) : Boolean
      {
         return false;
      }
      
      public function moveFrom(param1:Item, param2:IDragContainer) : void
      {
         param2.remove(param1);
         this.add(param1);
      }
      
      public function getContainToDrag() : Item
      {
         return null;
      }
      
      public function add(param1:Item) : void
      {
         this.onThrow.emit(param1);
         param1.clear();
         main.saveSystem.savePendingItems();
         main.soundManager.playFx(GameSounds.ITEM_TRASH);
      }
      
      public function getContent() : Item
      {
         return null;
      }
      
      public function isEmpty() : Boolean
      {
         return true;
      }
      
      public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         return !this.locked;
      }
      
      public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return true;
      }
      
      public function clear() : void
      {
         this.onThrow.clear();
      }
      
      public function canSwap(param1:IDragContainer) : Boolean
      {
         return false;
      }
      
      public function lock() : void
      {
         this.locked = true;
      }
      
      public function unlock() : void
      {
         this.locked = false;
      }
   }
}

