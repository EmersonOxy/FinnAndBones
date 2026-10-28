package view.screens
{
   import cb.actions.Functor;
   import cb.data.ButtonGroup;
   import cb.display.SmartMC;
   import cb.signals.Signal;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import util.Buttons;
   import util.Util;
   import view.screens.main_game.map.ArrowView;
   
   public class ComicWindow extends AnimatedScreen
   {
      
      public var onNext:Signal;
      
      public var onBack:Signal;
      
      private var nextArrow:ArrowView;
      
      private var actualPage:uint;
      
      private var totalPages:uint;
      
      public function ComicWindow(param1:Class, param2:uint)
      {
         this.totalPages = param2;
         super(param1,this.getButtonInfo(),"pic_1","end_pic_" + param2);
         this.onNext = new Signal();
         this.onBack = new Signal();
         this.initializeText();
         this.nextArrow = new ArrowView(MovieClip(Util.getSprite(bg,"arrow_right")),this.nextPage);
         main.soundManager.updateSoundButton(bg.sound);
         this.actualPage = 1;
         bg.gotoAndStop(1);
      }
      
      protected function initializeText() : void
      {
         throw new Error("Abstract Class");
      }
      
      protected function get music() : String
      {
         throw new Error("Abstract Class");
      }
      
      override public function enter(param1:Function = null) : void
      {
         super.enter(param1);
         this.nextArrow.show();
         main.soundManager.playMusic(this.music);
         Buttons.setButtons(bg,["sound","ok","back"],true);
      }
      
      protected function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["ok"] = ButtonGroup.get("gui").createButton(this.next,"mouseOver","mouseOut");
         _loc1_["back"] = ButtonGroup.get("gui").createButton(this.toMainMenu,"mouseOver","mouseOut");
         _loc1_["sound"] = ButtonGroup.get("sound_gui").createButton(null,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function nextPage() : void
      {
         this.nextArrow.hide();
         bg.gotoAndPlay("end_pic_" + this.actualPage);
         new SmartMC(bg).trigger(new EndCurrentLabel(bg),Functor.wrap(this.endPageTransition));
      }
      
      private function endPageTransition() : void
      {
         this.actualPage += 1;
         if(this.actualPage != this.totalPages)
         {
            this.nextArrow.show();
         }
      }
      
      protected function next(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg,["sound","ok","back"],false);
         this.onNext.emit();
      }
      
      private function toMainMenu(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg,["sound","ok","back"],false);
         this.onBack.emit();
      }
      
      public function exit() : void
      {
         removeEvents();
         pop();
      }
      
      override public function clear() : void
      {
         super.clear();
         this.onNext.clear();
         this.onBack.clear();
      }
   }
}

