package main_game.item_containers
{
   import cb.signals.Signal;
   import drag_and_drop.IDragContainer;
   import main_game.items.Item;
   
   public class NullSlot implements ISlot
   {
      
      private var onChangeSignal:Signal;
      
      private var content:Item;
      
      public function NullSlot()
      {
         super();
         this.onChangeSignal = new Signal();
      }
      
      public function get onChange() : Signal
      {
         return this.onChangeSignal;
      }
      
      public function remove(param1:Item) : void
      {
      }
      
      public function add(param1:Item) : void
      {
         this.content = param1;
      }
      
      public function moveFrom(param1:Item, param2:IDragContainer) : void
      {
      }
      
      public function getContent() : Item
      {
         return this.content;
      }
      
      public function isEmpty() : Boolean
      {
         return this.content == null;
      }
      
      public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
      
      public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return false;
      }
      
      public function canSwap(param1:IDragContainer) : Boolean
      {
         return false;
      }
      
      public function getContainToDrag() : Item
      {
         return null;
      }
      
      public function isLocked() : Boolean
      {
         return true;
      }
      
      public function canRemove(param1:Item) : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
         this.onChangeSignal.clear();
         this.onChangeSignal = null;
      }
   }
}

