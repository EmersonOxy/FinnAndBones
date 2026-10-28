package main_game.item_containers
{
   import cb.signals.Signal;
   import drag_and_drop.IDragContainer;
   import main_game.items.Item;
   
   public class Slot implements ItemContainer, ISlot
   {
      
      private var onChangeSignal:Signal;
      
      private var content:Item;
      
      private var locked:Boolean;
      
      public function Slot()
      {
         super();
         this.locked = false;
         this.onChangeSignal = new Signal();
      }
      
      public function get onChange() : Signal
      {
         return this.onChangeSignal;
      }
      
      public function moveFrom(param1:Item, param2:IDragContainer) : void
      {
         var _loc3_:Item = null;
         if(!this.isEmpty())
         {
            _loc3_ = this.getContent();
            this.remove(_loc3_);
         }
         param2.remove(param1);
         this.add(param1);
         if(_loc3_ != null)
         {
            param2.add(_loc3_);
         }
      }
      
      public function add(param1:Item) : void
      {
         var _loc2_:SlotChange = new SlotChange(this,this.content,param1);
         if(this.content != param1)
         {
            this.content = param1;
            this.onChange.emit(_loc2_);
         }
      }
      
      public function getContainToDrag() : Item
      {
         if(this.isEmpty() || this.isLocked() || !this.canRemove(this.getContent()))
         {
            return null;
         }
         return this.getContent();
      }
      
      public function remove(param1:Item) : void
      {
         assert(this.content == param1,"The content its not present");
         this.empty();
      }
      
      private function empty() : void
      {
         var _loc1_:SlotChange = new SlotChange(this,this.content,null);
         if(this.content != null)
         {
            this.content = null;
            this.onChange.emit(_loc1_);
         }
      }
      
      public function isEmpty() : Boolean
      {
         return this.content == null;
      }
      
      public function lock() : void
      {
         this.locked = true;
      }
      
      public function unlock() : void
      {
         this.locked = false;
      }
      
      public function isLocked() : Boolean
      {
         return this.locked;
      }
      
      public function getContent() : Item
      {
         return this.content;
      }
      
      public function canRemove(param1:Item) : Boolean
      {
         return !this.isLocked() && param1 == this.getContent();
      }
      
      public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         return !this.isLocked() && (this.isEmpty() || param2.canSwap(this)) && this.itsCompatible(param1,param2);
      }
      
      public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return param1.canBeContained(this);
      }
      
      public function canSwap(param1:IDragContainer) : Boolean
      {
         if(param1 == this)
         {
            return false;
         }
         var _loc2_:Item = param1.getContainToDrag();
         return _loc2_ != null && _loc2_.canBeContained(this);
      }
      
      public function canContainEquipment() : Boolean
      {
         return true;
      }
      
      public function canContainWeapon() : Boolean
      {
         return true;
      }
      
      public function canContainConsumable() : Boolean
      {
         return true;
      }
      
      public function canContainShield() : Boolean
      {
         return true;
      }
      
      public function clear() : void
      {
         this.onChange.clear();
         this.onChangeSignal = null;
      }
   }
}

