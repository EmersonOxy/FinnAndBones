package view.screens.main_game.dungeon
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.dungeon.Loot;
   import main_game.item_containers.Slot;
   import main_game.items.Item;
   import view.effect.Effect;
   import view.effect.SmokeEffect;
   import view.screens.main_game.slot.SlotView;
   import view.screens.main_game.states.IPausable;
   
   public class LootView implements IPausable
   {
      
      private var loot:Loot;
      
      private var slots:Vector.<SlotView>;
      
      private var bg:MovieClip;
      
      private var timer:Timer;
      
      private var showing:int;
      
      public function LootView(param1:Loot, param2:MovieClip)
      {
         super();
         this.bg = param2;
         this.loot = param1;
         this.slots = new Vector.<SlotView>();
         this.initialize();
      }
      
      public function pause() : void
      {
         if(this.showing < 3)
         {
            this.clearTimer();
            while(this.showing < 3)
            {
               this.showing += 1;
               (this.slots[this.showing - 1] as SlotView).unHideItem();
            }
            this.showing += 1;
         }
      }
      
      public function resume() : void
      {
      }
      
      private function initialize() : void
      {
         this.showing = 0;
         var _loc1_:uint = 1;
         while(_loc1_ <= 3)
         {
            this.slots[_loc1_ - 1] = new SlotView(this.loot.getSlot(_loc1_ - 1));
            this.slots[_loc1_ - 1].initialize(this.bg["slot_" + _loc1_]);
            (this.slots[_loc1_ - 1] as SlotView).hideItem();
            _loc1_++;
         }
      }
      
      public function showLoot() : void
      {
         if(this.showing >= 3)
         {
            return;
         }
         this.timer = new Timer(300,3);
         this.timer.addEventListener(TimerEvent.TIMER,this.showOneLoot);
         this.timer.start();
      }
      
      private function showOneLoot(... rest) : void
      {
         if(this.showing >= 3)
         {
            this.clearTimer();
            return;
         }
         this.showing += 1;
         this.showLootOf(this.showing);
         if(this.showing >= 3)
         {
            this.clearTimer();
         }
      }
      
      private function showLootOf(param1:int) : void
      {
         var _loc2_:Effect = new SmokeEffect();
         _loc2_.playOn(this.bg["slot_" + param1]);
         (this.slots[param1 - 1] as SlotView).unHideItem();
      }
      
      public function takeAll() : void
      {
         var _loc1_:Slot = null;
         var _loc2_:Slot = null;
         var _loc3_:Item = null;
         this.clearTimer();
         if(this.showing < 3)
         {
            while(this.showing < 3)
            {
               this.showing += 1;
               this.showLootOf(this.showing);
            }
            this.takeAll();
         }
         else
         {
            for each(_loc1_ in this.loot.getBooty())
            {
               if(!_loc1_.isEmpty())
               {
                  _loc2_ = main.game.getInventory().getEmptySlot();
                  if(_loc2_ == null)
                  {
                     return;
                  }
                  _loc3_ = _loc1_.getContent();
                  _loc1_.remove(_loc3_);
                  _loc2_.add(_loc3_);
               }
            }
         }
      }
      
      private function clearTimer() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
            this.timer = null;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:SlotView = null;
         for each(_loc1_ in this.slots)
         {
            _loc1_.clear();
         }
         this.loot.clear();
         this.clearTimer();
      }
      
      public function isEmpty() : Boolean
      {
         return this.loot.getSlot(0).isEmpty();
      }
   }
}

