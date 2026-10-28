package view.screens.main_game.bubblegum
{
   import cb.actions.Functor;
   import cb.data.ButtonGroup;
   import cb.display.Screen;
   import cb.display.SmartMC;
   import cb.signals.Signal;
   import conditions.EndCurrentLabel;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import main_game.bubblegum.BubbleGumTip;
   import sound.GameSounds;
   import util.Buttons;
   import util.Util;
   import view.screens.main_game.slot.SlotView;
   
   public class BubblegumPopUp
   {
      
      private var screen:Screen;
      
      private var showing:Boolean;
      
      private var principalSlot:SlotView;
      
      private var secondarySlot:SlotView;
      
      private var onCancelSignal:Signal;
      
      public function BubblegumPopUp()
      {
         super();
         this.screen = new Screen(main.swfLoader.getClass("assets.PrincessPopUp"),this.getButtonInfo());
         this.showing = false;
         this.onCancelSignal = new Signal();
         this.mc.gotoAndStop("in");
         this.mc.visible = false;
      }
      
      public function get onCancel() : Signal
      {
         return this.onCancelSignal;
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["container.cancel"] = ButtonGroup.get("gui").createButton(this.cancel,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function cancel(param1:MouseEvent) : void
      {
         this.onCancel.emit();
      }
      
      public function get mc() : MovieClip
      {
         return this.screen.getBg();
      }
      
      public function addIn(param1:DisplayObjectContainer) : void
      {
         param1.addChild(this.screen);
      }
      
      public function hide(param1:Function = null) : void
      {
         if(this.showing)
         {
            Buttons.setButtons(this.screen.getBg(),["container.cancel"],false);
            this.mc.gotoAndPlay("out");
            this.showing = false;
            new SmartMC(this.mc).trigger(new EndCurrentLabel(this.mc),Functor.wrap(Util.l(this.trueHide,param1)));
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      private function trueHide(param1:Function = null) : void
      {
         this.clearSlots();
         this.mc.visible = false;
         if(param1 != null)
         {
            param1();
         }
      }
      
      public function show(param1:Function = null) : void
      {
         this.mc.visible = true;
         Buttons.setButtons(this.screen.getBg(),["container.cancel"],true);
         if(!this.showing)
         {
            this.mc.gotoAndPlay("in");
            if(param1 != null)
            {
               new SmartMC(this.mc).trigger(new EndCurrentLabel(this.mc),Functor.wrap(param1));
            }
            this.showing = true;
            main.soundManager.playFx(GameSounds.POP_UP);
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      private function get container() : MovieClip
      {
         return this.mc.container;
      }
      
      private function clearSlots() : void
      {
         if(this.principalSlot != null)
         {
            this.principalSlot.clear();
            this.principalSlot = null;
         }
         if(this.secondarySlot != null)
         {
            this.secondarySlot.clear();
            this.secondarySlot = null;
         }
      }
      
      public function refreshTip(param1:BubbleGumTip) : void
      {
         this.clearSlots();
         if(!param1.principalSlot.isEmpty() && !param1.secondarySlot.isEmpty())
         {
            this.container.gotoAndStop("item_2");
         }
         else if(!param1.principalSlot.isEmpty() || !param1.secondarySlot.isEmpty())
         {
            this.container.gotoAndStop("item");
         }
         else
         {
            this.container.gotoAndStop("basic");
         }
         this.principalSlot = new SlotView(param1.principalSlot);
         this.principalSlot.initialize(this.container.slot_1);
         this.secondarySlot = new SlotView(param1.secondarySlot);
         this.secondarySlot.initialize(this.container.slot_2);
         this.container.slot_1.mouseEnabled = false;
         this.container.slot_1.mouseChildren = false;
         this.container.slot_2.mouseEnabled = false;
         this.container.slot_2.mouseChildren = false;
         this.container.title.text = param1.tipText;
         if(param1.secondarySlot.isEmpty())
         {
            this.container.slot_2.visible = false;
         }
         else
         {
            this.container.slot_2.visible = true;
         }
      }
      
      public function clear() : void
      {
         this.onCancelSignal.clear();
         this.onCancelSignal = null;
         this.screen.clear();
         this.screen = null;
         this.clearSlots();
      }
   }
}

