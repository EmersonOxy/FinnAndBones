package main_game.dungeon
{
   import main_game.item_containers.OneTimeSlot;
   import main_game.item_containers.Slot;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import util.ProbabilisticSet;
   
   public class Loot
   {
      
      private var slots:Vector.<Slot>;
      
      public function Loot(param1:DungeonConfigData, param2:ProbabilisticSet)
      {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:Slot = null;
         var _loc8_:String = null;
         super();
         this.slots = new Vector.<Slot>();
         var _loc3_:ProbabilisticSet = new ProbabilisticSet();
         for each(_loc4_ in param1.lootData)
         {
            _loc3_.add(_loc4_[0],_loc4_[1]);
         }
         _loc5_ = 0;
         while(_loc5_ < 3 && param2.length > 0)
         {
            _loc6_ = this.makeSlot(param2.pop() as String);
            this.slots.push(_loc6_);
            _loc5_++;
         }
         var _loc7_:int = int(_loc5_);
         while(_loc7_ < 3)
         {
            _loc8_ = _loc3_.pop() as String;
            _loc6_ = this.makeSlot(_loc8_);
            this.slots.push(_loc6_);
            _loc7_++;
         }
      }
      
      private function makeSlot(param1:String = null) : Slot
      {
         var _loc2_:Item = null;
         if(param1 != null)
         {
            _loc2_ = ItemFactory.getInstance().getItem(param1);
         }
         return new OneTimeSlot(_loc2_);
      }
      
      public function getSlot(param1:int) : Slot
      {
         return this.slots[param1];
      }
      
      public function getBooty() : Vector.<Slot>
      {
         return this.slots;
      }
      
      public function clear() : void
      {
         var _loc1_:OneTimeSlot = null;
         for each(_loc1_ in this.slots)
         {
            _loc1_.clear();
         }
         this.slots = null;
      }
   }
}

