package view.screens.main_game.inventory
{
   import cb.utils.Tween;
   import drag_and_drop.DragListener;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import main_game.character.Gear;
   import main_game.character.stats.Experience;
   import main_game.character.stats.HealthStat;
   import main_game.character.stats.PersistentExperience;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   import util.Util;
   import view.screens.main_game.BarView;
   import view.screens.main_game.slot.LeftSlotView;
   import view.screens.main_game.slot.SlotView;
   
   public class StatsView
   {
      
      private var bg:MovieClip;
      
      private var drag_listener:DragListener;
      
      private var weapon_slot:SlotView;
      
      private var shield_slot:SlotView;
      
      private var equip_slot_1:SlotView;
      
      private var equip_slot_2:SlotView;
      
      private var liver:LiverView;
      
      private var lastLevel:uint;
      
      private var experience:BarView;
      
      public function StatsView()
      {
         super();
         this.liver = new LiverView(this);
      }
      
      public function initialize(param1:MovieClip) : void
      {
         this.bg = param1;
         this.drag_listener = new DragListener(param1,main.game.getFinn().liver);
         var _loc2_:Stats = main.game.getFinn().stats;
         var _loc3_:Experience = _loc2_.getStat(StatType.EXPERIENCE) as Experience;
         this.experience = new BarView(this.bg.xp as MovieClip,main.locale,"experience_status",_loc3_.getValue(),_loc3_.getUpperBound());
         this.initializeStats();
         this.initializeSlots();
         this.liver.initialize(main.game.getFinn().liver,this.bg.potion);
      }
      
      private function initializeStats() : void
      {
         main.game.getFinn().stats.onChange.add(this.refresh);
         var _loc1_:Stats = main.game.getFinn().stats;
         this.bg.health.title.title.text = (_loc1_.getStat(StatType.HEALTH) as HealthStat).getUpperBound().getValue();
         this.bg.defence.title.title.text = _loc1_.getDefense();
         this.bg.weapon.title.title.text = _loc1_.getAttack();
         this.bg.luck.title.title.text = _loc1_.getLuck();
         this.lastLevel = _loc1_.getLevel();
         this.refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:Stats = main.game.getFinn().stats;
         this.updateLevelAndXp(_loc1_.getLevel(),_loc1_.getStat(StatType.EXPERIENCE) as PersistentExperience);
         this.updateHealth((_loc1_.getStat(StatType.HEALTH) as HealthStat).getUpperBound().getValue());
         this.updateDefense(_loc1_.getDefense());
         this.updateAttack(_loc1_.getAttack());
         this.updateLuck(_loc1_.getLuck());
      }
      
      private function initializeSlots() : void
      {
         var _loc1_:Gear = main.game.getFinn().gear;
         this.weapon_slot = new LeftSlotView(_loc1_.weapon);
         this.shield_slot = new LeftSlotView(_loc1_.shield);
         this.equip_slot_1 = new LeftSlotView(_loc1_.equipment_1);
         this.equip_slot_2 = new LeftSlotView(_loc1_.equipment_2);
         this.equip_slot_1.initialize(this.bg.modifiers_slot_1);
         this.equip_slot_2.initialize(this.bg.modifiers_slot_2);
         this.weapon_slot.initialize(this.bg.weapon_slot_2);
         this.shield_slot.initialize(this.bg.weapon_slot_1);
      }
      
      private function updateLevelAndXp(param1:uint, param2:PersistentExperience) : void
      {
         this.bg["level"].title_1.text = main.locale.get("level",[param1]);
         if(param1 != this.lastLevel)
         {
            this.experience.current = 0;
            this.experience.total = param2.getUpperBound();
         }
         this.updateBar(this.experience,param2.getValue(),param2.getUpperBound());
         this.lastLevel = param1;
      }
      
      private function updateBar(param1:BarView, param2:Number, param3:Number) : void
      {
         Tween.killTweensOf(param1);
         Tween.to(param1,300,{
            "current":param2,
            "total":param3
         });
      }
      
      private function makeGlow(param1:Boolean, param2:TextField) : void
      {
         if(param1)
         {
            param2.textColor = 16776960;
         }
         else
         {
            param2.textColor = 14605481;
         }
      }
      
      public function glowDefense(param1:Boolean) : void
      {
         this.makeGlow(param1,this.bg.defence.title.title);
      }
      
      public function glowAttack(param1:Boolean) : void
      {
         this.makeGlow(param1,this.bg.weapon.title.title);
      }
      
      public function glowLuck(param1:Boolean) : void
      {
         this.makeGlow(param1,this.bg.luck.title.title);
      }
      
      private function updateHealth(param1:int) : void
      {
         this.updateText(this.bg.health.title.title,param1);
      }
      
      private function updateDefense(param1:int) : void
      {
         this.updateText(this.bg.defence.title.title,param1);
      }
      
      private function updateAttack(param1:int) : void
      {
         this.updateText(this.bg.weapon.title.title,param1);
      }
      
      private function updateLuck(param1:int) : void
      {
         this.updateText(this.bg.luck.title.title,param1);
      }
      
      private function updateText(param1:TextField, param2:Number) : void
      {
         Tween.killTweensOf(param1);
         Tween.to(param1,300,{"text":param2},null,Util.l(this.interize,param1));
      }
      
      private function interize(param1:TextField) : void
      {
         var _loc2_:String = param1.text;
         param1.text = _loc2_.split(".")[0];
      }
      
      private function killTweens() : void
      {
         Tween.killTweensOf(this.experience);
         Tween.killTweensOf(this.bg.health.title.title);
         Tween.killTweensOf(this.bg.defence.title.title);
         Tween.killTweensOf(this.bg.weapon.title.title);
         Tween.killTweensOf(this.bg.luck.title.title);
      }
      
      public function clear() : void
      {
         this.killTweens();
         this.drag_listener.clear();
         this.equip_slot_1.clear();
         this.equip_slot_2.clear();
         this.weapon_slot.clear();
         this.shield_slot.clear();
         this.liver.clear();
         this.experience.clear();
      }
   }
}

