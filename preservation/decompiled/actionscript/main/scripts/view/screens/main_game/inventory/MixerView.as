package view.screens.main_game.inventory
{
   import cb.actions.RemoveFromParent;
   import cb.data.ButtonInfo;
   import cb.display.SmartMC;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import main_game.item_containers.Slot;
   import main_game.mixer.Mixer;
   import util.Buttons;
   import view.screens.main_game.slot.AutoSelectSlotView;
   import view.screens.main_game.slot.SlotView;
   
   public class MixerView
   {
      
      private var bg:MovieClip;
      
      private var slots:Array;
      
      private var clock_view:MixerClockView;
      
      private var top:MovieClip = null;
      
      public function MixerView()
      {
         super();
         this.slots = new Array();
      }
      
      public function initialize(param1:MovieClip) : void
      {
         var _loc4_:Slot = null;
         var _loc5_:SlotView = null;
         this.bg = param1;
         this.bg.mouseEnabled = false;
         this.bg.mix_button.title.title.text = main.locale.get("mix");
         var _loc2_:Mixer = main.game.getMixer();
         this.refreshButton();
         var _loc3_:int = 1;
         while(_loc3_ <= 3)
         {
            _loc4_ = _loc2_.getSlot(_loc3_);
            _loc4_.onChange.add(this.change);
            _loc5_ = new AutoSelectSlotView(_loc4_);
            this.slots[_loc3_ - 1] = _loc5_;
            _loc5_.initialize(this.bg["mix_slot_" + _loc3_]);
            _loc3_++;
         }
      }
      
      public function disable() : void
      {
         if(this.top == null)
         {
            this.top = main.swfLoader.getObject("assets.MixTop") as MovieClip;
            this.top.gotoAndStop("idle");
            this.bg.parent.addChild(this.top);
         }
      }
      
      public function enable() : void
      {
         if(this.top != null)
         {
            this.top.gotoAndPlay("out");
            new SmartMC(this.top).trigger(new EndCurrentLabel(this.top),new RemoveFromParent());
            this.top = null;
         }
      }
      
      private function change(param1:* = null) : void
      {
         this.refreshButton();
      }
      
      public function mix(param1:MouseEvent) : void
      {
         var _loc2_:Mixer = main.game.getMixer();
         _loc2_.startMix();
         this.clock_view = new MixerClockView(_loc2_.clock);
         this.bg["mix_slot_3"].addChild(this.clock_view);
         this.refreshButton();
      }
      
      private function refreshButton() : void
      {
         var _loc1_:Mixer = main.game.getMixer();
         Buttons.setButtons(this.bg,["mix_button"],_loc1_.canMix());
         if(_loc1_.canMix())
         {
            this.bg["mix_button"].gotoAndStop("idle");
         }
         else
         {
            this.bg["mix_button"].gotoAndStop("locked");
         }
      }
      
      public function mixButtonOut(param1:MouseEvent) : void
      {
         if(!main.game.getMixer().canMix())
         {
            param1.stopPropagation();
            this.bg["mix_button"].gotoAndStop("locked");
         }
         else
         {
            ButtonInfo.defaultGoto("mouseOut",true)(param1);
         }
      }
      
      public function clear() : void
      {
         var _loc1_:SlotView = null;
         for each(_loc1_ in this.slots)
         {
            _loc1_.clear();
         }
         this.slots = null;
      }
   }
}

