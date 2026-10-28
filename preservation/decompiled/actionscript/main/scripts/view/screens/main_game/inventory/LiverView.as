package view.screens.main_game.inventory
{
   import cb.utils.cbArray;
   import flash.display.MovieClip;
   import main_game.character.Liver;
   import main_game.character.stats.StatType;
   import main_game.item_containers.SlotChange;
   import main_game.items.Consumable;
   import main_game.items.Item;
   import view.effect.PotionEffect;
   import view.screens.main_game.slot.LeftSlotView;
   
   public class LiverView
   {
      
      private var bg:MovieClip;
      
      private var stats:StatsView;
      
      private var slot:LeftSlotView;
      
      private var showing:Boolean;
      
      public function LiverView(param1:StatsView)
      {
         super();
         this.stats = param1;
      }
      
      public function initialize(param1:Liver, param2:MovieClip) : void
      {
         this.bg = param2;
         this.showing = false;
         param2.gotoAndStop("stop");
         this.bg.potion_mask.mouseEnabled = false;
         this.bg.potion_mask.mouseChildren = false;
         this.slot = new LeftSlotView(param1);
         this.slot.initialize(param2.modifiers_slot_3);
         param1.onLock.add(this.animate);
         param1.onChange.add(this.refresh);
         this.trueRefresh(param1);
      }
      
      public function animate(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(param1 == this.showing)
         {
            this.showing = !param1;
            _loc2_ = param1 ? "out" : "in";
            this.bg.gotoAndPlay(_loc2_);
         }
      }
      
      public function refresh(param1:SlotChange) : void
      {
         var _loc2_:Liver = param1.getSlot() as Liver;
         this.trueRefresh(_loc2_);
         if(param1.getOldItem() != null)
         {
            this.removeConsumable(param1.getOldItem());
         }
      }
      
      private function refreshGlow(param1:Liver) : void
      {
         var _loc2_:cbArray = param1.activeBuffs();
         this.stats.glowAttack(_loc2_.indexOf(StatType.ATTACK) >= 0);
         this.stats.glowDefense(_loc2_.indexOf(StatType.DEFENSE) >= 0);
         this.stats.glowLuck(_loc2_.indexOf(StatType.LUCK) >= 0);
      }
      
      private function trueRefresh(param1:Liver) : void
      {
         var _loc2_:PotionEffect = null;
         var _loc3_:Consumable = null;
         this.refreshGlow(param1);
         if(!param1.isEmpty())
         {
            this.slot.blockSelection();
            _loc2_ = new PotionEffect(param1.getContent(),this.bg);
            _loc2_.y += this.bg.modifiers_slot_3.slot.height / 2;
            _loc3_ = param1.getContent().getCategory() as Consumable;
            _loc3_.onChange.add(this.refreshMask);
         }
         else
         {
            this.removeMask();
         }
      }
      
      private function refreshMask(param1:int) : void
      {
         this.bg.potion_mask.gotoAndStop(100 - param1);
      }
      
      private function removeConsumable(param1:Item) : void
      {
         var _loc2_:Consumable = param1.getCategory() as Consumable;
         _loc2_.onChange.remove(this.refreshMask);
         _loc2_.atEndEffect.remove(this.removeConsumable);
         this.removeMask();
      }
      
      private function removeMask() : void
      {
         this.slot.unblockSelection();
         this.bg.potion_mask.gotoAndStop(0);
      }
      
      public function clear() : void
      {
         this.removeMask();
         this.slot.clear();
         this.slot = null;
         this.bg = null;
         this.stats = null;
      }
   }
}

