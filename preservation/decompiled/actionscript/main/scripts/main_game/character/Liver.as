package main_game.character
{
   import cb.signals.Signal;
   import cb.utils.cbArray;
   import drag_and_drop.IDragContainer;
   import main_game.item_containers.Slot;
   import main_game.item_containers.SlotChange;
   import main_game.items.Category;
   import main_game.items.Consumable;
   import main_game.items.Item;
   import sound.GameSounds;
   
   public class Liver extends Slot
   {
      
      public var fighter:Finn;
      
      public var onLock:Signal = new Signal();
      
      public function Liver(param1:Finn)
      {
         this.fighter = param1;
         super();
         this.lock();
      }
      
      override public function lock() : void
      {
         super.lock();
         this.onLock.emit(true);
      }
      
      override public function unlock() : void
      {
         super.unlock();
         this.onLock.emit(false);
      }
      
      override public function moveFrom(param1:Item, param2:IDragContainer) : void
      {
         param2.remove(param1);
         this.add(param1);
      }
      
      override public function add(param1:Item) : void
      {
         var _loc2_:Consumable = param1.getCategory() as Consumable;
         if(!_loc2_.isInstant())
         {
            _loc2_.atEndEffect.add(this.remove);
            _loc2_.degrade();
            super.add(param1);
         }
         else
         {
            onChange.emit(new SlotChange(this,param1,null));
         }
         this.fighter.stats.getEffectGuardian().addEfectsOfItem(param1);
         this.fighter.consumePotion(param1);
         if(_loc2_.isInstant())
         {
            param1.clear();
         }
         main.saveSystem.savePendingItems();
         main.soundManager.playFx(GameSounds.CONSUMABLE);
      }
      
      public function activeBuffs() : cbArray
      {
         var _loc2_:Item = null;
         var _loc1_:cbArray = new cbArray();
         if(!isEmpty())
         {
            _loc2_ = getContent();
            _loc1_.pushIfNotPresent(_loc2_.getPrimaryModifier().getCategory());
            _loc1_.pushIfNotPresent(_loc2_.getSecondaryModifier().getCategory());
         }
         return _loc1_;
      }
      
      override public function remove(param1:Item) : void
      {
         this.fighter.stats.getEffectGuardian().removeEfectsOfItem(param1);
         this.fighter.endPotionEffect(param1);
         super.remove(param1);
         param1.clear();
      }
      
      override public function canRemove(param1:Item) : Boolean
      {
         return false;
      }
      
      override public function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean
      {
         var _loc3_:Boolean = param1.getCategory().type == Category.CONSUMABLE_CATEGORY && (param1.getCategory() as Consumable).isInstant();
         return !this.isLocked() && (_loc3_ || isEmpty() && param1.canBeContained(this));
      }
      
      override public function isLocked() : Boolean
      {
         return Boolean(super.isLocked()) || this.fighter.stats.isDead();
      }
      
      override public function canSwap(param1:IDragContainer) : Boolean
      {
         return false;
      }
      
      override public function itsCompatible(param1:Item, param2:IDragContainer) : Boolean
      {
         return param1.canBeContained(this);
      }
      
      override public function canContainEquipment() : Boolean
      {
         return false;
      }
      
      override public function canContainWeapon() : Boolean
      {
         return false;
      }
      
      override public function canContainShield() : Boolean
      {
         return false;
      }
      
      public function clearBuffs() : void
      {
         if(!isEmpty())
         {
            this.remove(getContent());
         }
      }
      
      override public function clear() : void
      {
         super.clear();
         this.onLock.clear();
         this.fighter = null;
      }
   }
}

