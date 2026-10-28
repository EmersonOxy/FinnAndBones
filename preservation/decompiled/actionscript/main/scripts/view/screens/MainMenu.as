package view.screens
{
   import bonus.DailyBonus;
   import bonus.IDailyBonus;
   import cb.data.ButtonGroup;
   import cb.display.Screen;
   import cb.signals.Signal;
   import cb.utils.Rule;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import sound.GameSounds;
   import util.Buttons;
   
   public class MainMenu extends Screen
   {
      
      private static var BUTTONS:Array = ["new_game","continue_game","sound"];
      
      public static const ActiveMessage:String = "dailyBonusCurrent";
      
      public static const NextMessage:String = "dailyBonusNext";
      
      public var onNewGame:Signal;
      
      public var onContinueGame:Signal;
      
      private var currentBonus:DailyBonusView;
      
      private var nextBonus:DailyBonusView;
      
      public function MainMenu()
      {
         super(main.swfLoader.getClass("assets.MainMenu"),this.getButtonInfo());
         container = "container";
         this.initialize();
         this.initializeDailyBonus();
         bg.gotoAndStop(0);
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["new_game"] = _loc2_.createButton(this.newGame,"mouseOver","mouseOut");
         _loc1_["continue_game"] = _loc2_.createButton(this.continueGame,"mouseOver","mouseOut");
         _loc1_["sound"] = ButtonGroup.get("sound_gui").createButton(null,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function initialize() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.size = 43;
         bg.container.new_game.title.title.defaultTextFormat = _loc1_;
         bg.container.continue_game.title.title.defaultTextFormat = _loc1_;
         bg.container.new_game.title.title.text = main.locale.get("new_game");
         bg.container.continue_game.title.title.text = main.locale.get("continue");
         Buttons.setButtons(bg.container,["new_game","sound"],true);
         if(main.saveSystem.hasPlayed())
         {
            bg.container["continue_game"].gotoAndStop("idle");
            Buttons.setButtons(bg.container,["continue_game"],true);
         }
         else
         {
            bg.container["continue_game"].gotoAndStop("locked");
            Buttons.setButtons(bg.container,["continue_game"],false);
         }
         this.onNewGame = new Signal();
         this.onContinueGame = new Signal();
         main.soundManager.updateSoundButton(bg.container.getChildByName("sound"));
         main.soundManager.playMusic(GameSounds.INTRO_MUSIC);
      }
      
      private function initializeDailyBonus() : void
      {
         var _loc4_:String = null;
         if(main.activeBonus)
         {
            this.currentBonus = new DailyBonusView(main.activeBonus,main.locale.get(ActiveMessage));
            bg.container.hoder_1.addChild(this.currentBonus);
         }
         var _loc1_:Date = new Date();
         var _loc2_:IDailyBonus = null;
         var _loc3_:int = 0;
         while(_loc3_ < 7)
         {
            _loc1_ = new Date(_loc1_.time + 1000 * 60 * 60 * 24);
            _loc2_ = DailyBonus.getBonusOfDate(_loc1_);
            if(_loc2_)
            {
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            _loc1_ = DailyBonus.getNextSpecialBonusDate(new Date());
            if(_loc1_)
            {
               _loc2_ = DailyBonus.getBonusOfDate(_loc1_);
            }
         }
         if(_loc2_)
         {
            _loc4_ = main.locale.get(NextMessage,[_loc1_.getFullYear(),_loc1_.getMonth() + 1,_loc1_.getDate()]);
            this.nextBonus = new DailyBonusView(_loc2_,_loc4_);
            bg.container.hoder_2.addChild(this.nextBonus);
         }
      }
      
      public function enter(param1:Function = null) : void
      {
         this.showBonus(param1);
      }
      
      private function showBonus(param1:Function = null) : void
      {
         var rule:Rule = null;
         var next:Function = param1;
         rule = new Rule("start");
         if(next != null)
         {
            rule.completed.add(next);
         }
         if(this.currentBonus != null)
         {
            rule.set("current");
            this.currentBonus.enter(function():void
            {
               rule.check("current");
            });
         }
         if(this.nextBonus != null)
         {
            rule.set("next");
            this.nextBonus.enter(function():void
            {
               rule.check("next");
            });
         }
         rule.check("start");
      }
      
      private function continueGame(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg.container,BUTTONS,false);
         this.onContinueGame.emit();
      }
      
      public function newGame(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg.container,BUTTONS,false);
         if(main.saveSystem.hasPlayed())
         {
            this.showConfirmationPopUp();
         }
         else
         {
            this.onNewGame.emit();
         }
      }
      
      private function showConfirmationPopUp() : void
      {
         var _loc1_:String = main.locale.get("new_gameConfirmation");
         var _loc2_:ConfirmationPopUp = new ConfirmationPopUp(bg.container,this.onNewGame.emit,this.cancelPopUp,_loc1_);
         bg.addChild(_loc2_);
         _loc2_.enter();
      }
      
      private function cancelPopUp() : void
      {
         Buttons.setButtons(bg.container,BUTTONS,true);
      }
      
      public function exit() : void
      {
         removeEvents();
         pop();
      }
      
      override public function clear() : void
      {
         this.onNewGame.clear();
         this.onContinueGame.clear();
         this.onNewGame = null;
         this.onContinueGame = null;
         if(this.currentBonus != null)
         {
            this.currentBonus.clear();
         }
         if(this.nextBonus != null)
         {
            this.nextBonus.clear();
         }
         super.clear();
      }
   }
}

