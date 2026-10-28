package main_game.mixer
{
   import cb.signals.Signal;
   import main_game.item_containers.Slot;
   import main_game.item_containers.SlotChange;
   import main_game.items.Item;
   import sound.GameSounds;
   
   public class Mixer
   {
      
      public var clock:MixerClock;
      
      public var onMixStart:Signal;
      
      public var onMixEnd:Signal;
      
      private var slot_1:Slot;
      
      private var slot_2:Slot;
      
      private var slot_3:Slot;
      
      private var strat:MixStrategy;
      
      public function Mixer()
      {
         super();
         this.slot_1 = new Slot();
         this.slot_2 = new Slot();
         this.slot_3 = new MixSlot();
         this.strat = new MixStrategy();
         this.onMixEnd = new Signal();
         this.onMixStart = new Signal();
         this.loadData();
      }
      
      private function loadData() : void
      {
         var _loc1_:Item = null;
         _loc1_ = main.saveSystem.loadMixItem(1);
         if(_loc1_ != null)
         {
            this.slot_1.add(_loc1_);
         }
         this.slot_1.onChange.add(this.saveSlot(1));
         _loc1_ = main.saveSystem.loadMixItem(2);
         if(_loc1_ != null)
         {
            this.slot_2.add(_loc1_);
         }
         this.slot_2.onChange.add(this.saveSlot(2));
         _loc1_ = main.saveSystem.loadMixItem(3);
         if(_loc1_ != null)
         {
            this.slot_3.add(_loc1_);
         }
         this.slot_3.onChange.add(this.saveSlot(3));
      }
      
      private function saveSlot(param1:uint) : Function
      {
         var i:uint = param1;
         return function(param1:SlotChange):void
         {
            main.saveSystem.saveMix(i,param1.getNewItem());
         };
      }
      
      public function canMix() : Boolean
      {
         return !this.slot_1.isEmpty() && !this.slot_2.isEmpty() && this.slot_3.isEmpty() && this.clock == null;
      }
      
      public function startMix() : void
      {
         if(!this.canMix())
         {
            return;
         }
         this.lock();
         this.clock = new MixerClock(this.slot_1.getContent(),this.slot_2.getContent());
         this.clock.atEndMix.add(this.endMix);
         this.clock.start();
         this.onMixStart.emit();
      }
      
      private function endMix() : void
      {
         this.unlock();
         var _loc1_:Item = this.slot_1.getContent();
         var _loc2_:Item = this.slot_2.getContent();
         var _loc3_:MixResult = this.strat.getMix(_loc1_,_loc2_);
         var _loc4_:Item = _loc3_.item;
         this.slot_1.remove(_loc1_);
         this.slot_2.remove(_loc2_);
         this.slot_3.add(_loc4_);
         this.clock = null;
         this.onMixEnd.emit(_loc3_);
         if(_loc3_.recipe != null && _loc3_.recipe.mustShow)
         {
            main.saveSystem.saveRecipe(_loc3_.recipe);
         }
         main.saveSystem.savePendingItems();
         main.soundManager.playFx(GameSounds.MIX_DONE);
         if(_loc4_.getID() == "FriendlyRockJr")
         {
            main.achievementDispatcher.friendlyRockJrObtained();
         }
         main.achievementDispatcher.madeMix();
      }
      
      private function lock() : void
      {
         this.slot_1.lock();
         this.slot_2.lock();
         this.slot_3.lock();
      }
      
      private function unlock() : void
      {
         this.slot_1.unlock();
         this.slot_2.unlock();
         this.slot_3.unlock();
      }
      
      public function getSlot(param1:uint) : Slot
      {
         return this["slot_" + param1];
      }
      
      public function clear() : void
      {
         this.slot_1.clear();
         this.slot_2.clear();
         this.slot_3.clear();
         this.onMixEnd.clear();
         this.onMixEnd = null;
         this.onMixStart.clear();
         this.onMixStart = null;
         if(this.clock != null)
         {
            this.clock.stop();
         }
         this.clock = null;
      }
   }
}

