package main_game.character
{
   import main_game.character.stats.StatsEffectGuardian;
   import main_game.item_containers.EquipmentSlot;
   import main_game.item_containers.ShieldSlot;
   import main_game.item_containers.Slot;
   import main_game.item_containers.SlotChange;
   import main_game.item_containers.WeaponSlot;
   import main_game.items.Item;
   
   public class Gear
   {
      
      private var locked:Boolean;
      
      private var fighter:Fighter;
      
      public var weapon:Slot;
      
      public var shield:Slot;
      
      public var equipment_1:Slot;
      
      public var equipment_2:Slot;
      
      public function Gear(param1:Fighter)
      {
         super();
         this.fighter = param1;
         this.locked = false;
         this.weapon = new WeaponSlot();
         this.shield = new ShieldSlot();
         this.equipment_1 = new EquipmentSlot();
         this.equipment_2 = new EquipmentSlot();
         this.weapon.onChange.add(this.change);
         this.shield.onChange.add(this.change);
         this.equipment_1.onChange.add(this.change);
         this.equipment_2.onChange.add(this.change);
         this.loadData();
      }
      
      private function loadData() : void
      {
         var _loc1_:Item = null;
         _loc1_ = main.saveSystem.loadGearItem(1);
         if(_loc1_ != null)
         {
            this.weapon.add(_loc1_);
         }
         this.weapon.onChange.add(this.saveSlot(1));
         _loc1_ = main.saveSystem.loadGearItem(2);
         if(_loc1_ != null)
         {
            this.shield.add(_loc1_);
         }
         this.shield.onChange.add(this.saveSlot(2));
         _loc1_ = main.saveSystem.loadGearItem(3);
         if(_loc1_ != null)
         {
            this.equipment_1.add(_loc1_);
         }
         this.equipment_1.onChange.add(this.saveSlot(3));
         _loc1_ = main.saveSystem.loadGearItem(4);
         if(_loc1_ != null)
         {
            this.equipment_2.add(_loc1_);
         }
         this.equipment_2.onChange.add(this.saveSlot(4));
      }
      
      private function saveSlot(param1:uint) : Function
      {
         var i:uint = param1;
         return function(param1:SlotChange):void
         {
            main.saveSystem.saveGear(i,param1.getNewItem());
         };
      }
      
      private function change(param1:SlotChange) : void
      {
         var _loc2_:StatsEffectGuardian = this.fighter.stats.getEffectGuardian();
         _loc2_.removeEfectsOfItem(param1.getOldItem());
         _loc2_.addEfectsOfItem(param1.getNewItem());
      }
      
      public function lock() : void
      {
         if(this.locked)
         {
            return;
         }
         this.locked = true;
         this.weapon.lock();
         this.shield.lock();
         this.equipment_1.lock();
         this.equipment_2.lock();
      }
      
      public function unlock() : void
      {
         if(!this.locked)
         {
            return;
         }
         this.locked = false;
         this.weapon.unlock();
         this.shield.unlock();
         this.equipment_1.unlock();
         this.equipment_2.unlock();
      }
      
      public function clear() : void
      {
         this.equipment_1.clear();
         this.equipment_1 = null;
         this.equipment_2.clear();
         this.equipment_2 = null;
         this.fighter = null;
         this.shield.clear();
         this.shield = null;
         this.weapon.clear();
         this.weapon = null;
      }
   }
}

