package view.screens
{
   import cb.data.ButtonGroup;
   import cb.signals.Signal;
   import cb.utils.Random;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import main_game.map.Level;
   import sound.GameSounds;
   import util.Buttons;
   import util.Util;
   
   public class Pause extends AnimatedScreen
   {
      
      private static var BUTTONS:Array = ["cancel","help","level_select","replay","sound"];
      
      public var onLevelSelect:Signal;
      
      public var onReplay:Signal;
      
      public var onCancel:Signal;
      
      private var level:Level;
      
      public function Pause(param1:Level)
      {
         this.level = param1;
         super(main.swfLoader.getClass("assets.Pause"),this.getButtonInfo());
         this.initializeSignals();
         this.initialize();
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["cancel"] = _loc2_.createButton(this.cancel,"mouseOver","mouseOut");
         _loc1_["help"] = _loc2_.createButton(this.help,"mouseOver","mouseOut");
         _loc1_["level_select"] = _loc2_.createButton(this.levelSelect,"mouseOver","mouseOut");
         _loc1_["replay"] = _loc2_.createButton(this.replay,"mouseOver","mouseOut");
         _loc1_["sound"] = ButtonGroup.get("sound_gui").createButton(null,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function initializeSignals() : void
      {
         this.onCancel = new Signal();
         this.onLevelSelect = new Signal();
         this.onReplay = new Signal();
      }
      
      private function initialize() : void
      {
         bg.container.dungeon.title.text = this.level.getName();
         Buttons.setButtons(bg,BUTTONS,true);
         main.soundManager.updateSoundButton(bg["sound"]);
         main.soundManager.playMusic(GameSounds.MAP_MUSIC);
         this.putAdvice(bg.tips.tip_text.title);
      }
      
      private function putAdvice(param1:TextField) : void
      {
         var _loc2_:uint = 1;
         if(!main.theTutorial.isMixKnown())
         {
            _loc2_ = main.config.get("InitialConfig").mixAdvices + 1;
         }
         var _loc3_:String = main.locale.get("advice" + Random.nextRange(_loc2_,main.config.get("InitialConfig").advices).toString());
         param1.text = _loc3_;
      }
      
      override public function enter(param1:Function = null) : void
      {
         main.game.onPause.emit(true);
         super.enter(param1);
      }
      
      override public function leave(param1:Function = null) : void
      {
         main.game.onPause.emit(false);
         Buttons.setButtons(bg,BUTTONS,false);
         super.leave(param1);
      }
      
      override public function clear() : void
      {
         super.clear();
         this.onCancel.clear();
         this.onLevelSelect.clear();
         this.onReplay.clear();
      }
      
      private function replay(param1:MouseEvent = null) : void
      {
         this.showConfirmation(Util.l(this.emitAndLeave,this.onReplay),Util.pass);
      }
      
      private function levelSelect(param1:MouseEvent = null) : void
      {
         this.showConfirmation(Util.l(this.emitAndLeave,this.onLevelSelect),Util.pass);
      }
      
      private function emitAndLeave(param1:Signal) : void
      {
         var signal:Signal = param1;
         signal.emit();
         this.leave(function():void
         {
            pop();
         });
      }
      
      private function showConfirmation(param1:Function, param2:Function) : void
      {
         var _loc3_:String = main.locale.get("leave_dungeonConfirmation");
         var _loc4_:ConfirmationPopUp = new ConfirmationPopUp(bg,param1,param2,_loc3_);
         main.tutorialHolder.addChild(_loc4_);
         _loc4_.enter();
      }
      
      private function help(param1:MouseEvent = null) : void
      {
      }
      
      private function cancel(param1:MouseEvent = null) : void
      {
         var ev:MouseEvent = param1;
         this.leave(function():void
         {
            onCancel.emit();
            pop();
         });
      }
   }
}

