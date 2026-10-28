package view.screens.main_game.map
{
   import actions.Lambda;
   import cb.data.ButtonGroup;
   import cb.display.Screen;
   import cb.display.SmartMC;
   import cb.signals.Signal;
   import cb.utils.cbArray;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import main_game.character.CharacterFactory;
   import main_game.dungeon.DungeonConfigData;
   import main_game.dungeon.DungeonFactory;
   import main_game.element.Element;
   import main_game.map.LegendaryLevel;
   import main_game.map.Level;
   import util.Buttons;
   import util.Sepializer;
   import util.Util;
   import view.screens.main_game.states.MapState;
   
   public class MapView extends Screen
   {
      
      private static const NEXT_BUTTON:String = "pages.arrow_right";
      
      private static const PREV_BUTTON:String = "pages.arrow_left";
      
      public var onToMainMenu:Signal;
      
      public var onToDungeon:Signal;
      
      private var buttonsNames:Array;
      
      private var map:MapState;
      
      private var nextArrow:ArrowView;
      
      private var prevArrow:ArrowView;
      
      private var actual_page:uint;
      
      private var lastPlayedTimer:Timer = new Timer(500,1);
      
      public function MapView(param1:MapState)
      {
         this.map = param1;
         this.lastPlayedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.refreshLastLevel);
         super(main.swfLoader.getClass("assets.Map"),this.getButtonInfo());
         this.actual_page = this.pageOfLevel(this.map.getMap().getLevel(main.saveSystem.getLastPlayed()));
         this.initialize();
         bg.pages.gotoAndStop("page_" + this.actual_page);
         this.nextArrow = new ArrowView(MovieClip(Util.getSprite(bg,NEXT_BUTTON)),this.nextPage);
         this.prevArrow = new ArrowView(MovieClip(Util.getSprite(bg,PREV_BUTTON)),this.previousPage);
         this.refreshArrows(this.actual_page);
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc3_:Level = null;
         var _loc4_:String = null;
         this.buttonsNames = new Array();
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["sound"] = ButtonGroup.get("sound_gui").createButton(null,"mouseOver","mouseOut");
         this.buttonsNames.push("sound");
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["back"] = _loc2_.createButton(this.toMainMenu,"mouseOver","mouseOut");
         this.buttonsNames.push("back");
         for each(_loc3_ in this.map.getMap().getLevels())
         {
            _loc4_ = this.getButtonName(_loc3_);
            _loc1_[_loc4_] = _loc2_.createButton(this.getGoToDungeon(_loc3_),"mouseOver","mouseOut");
            this.buttonsNames.push(_loc4_);
         }
         return _loc1_;
      }
      
      private function getButtonName(param1:Level) : String
      {
         return "pages.page_" + this.pageOfLevel(param1) + ".dungeon_" + param1.getDungeonId();
      }
      
      private function pageOfLevel(param1:Level) : uint
      {
         return param1.getArea();
      }
      
      private function getGoToDungeon(param1:Level) : Function
      {
         var level:Level = param1;
         return function(param1:MouseEvent):void
         {
            Buttons.setButtons(bg,buttonsNames,false);
            onToDungeon.emit(level);
         };
      }
      
      private function initialize() : void
      {
         var _loc1_:Level = null;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Date = null;
         this.onToMainMenu = new Signal();
         this.onToDungeon = new Signal();
         main.soundManager.updateSoundButton(bg.sound);
         Buttons.setButtons(bg,this.buttonsNames,true);
         for each(_loc1_ in this.map.getMap().getLevels())
         {
            _loc2_ = this.getButtonName(_loc1_);
            _loc3_ = Util.getSprite(bg,_loc2_) as MovieClip;
            if(_loc1_.isLocked())
            {
               if(!_loc1_.isLegendary())
               {
                  _loc3_.icon.gotoAndStop("locked");
               }
               else
               {
                  Sepializer.getInstance().sepializeDark(_loc3_);
                  _loc4_ = main.swfLoader.getObject("assets.BonusMap") as MovieClip;
                  _loc3_.addChild(_loc4_);
                  _loc5_ = (_loc1_ as LegendaryLevel).getDate();
                  _loc4_.title.title.text = main.locale.get("legendaryDate",[_loc5_.getFullYear(),_loc5_.getMonth() + 1,_loc5_.getDate()]);
               }
               Buttons.setButtons(bg,[_loc2_],false);
            }
            else if(_loc1_.isCleared())
            {
               if(!_loc1_.isLegendary())
               {
                  _loc3_.icon.gotoAndStop("cleared");
                  if(!_loc1_.isSpecial())
                  {
                     _loc3_.icon.title.title.text = _loc1_.getDungeonId();
                  }
               }
               Buttons.setButtons(bg,[_loc2_],true);
               this.putEnemies(_loc3_,_loc1_);
            }
            else if(_loc1_.isUnlocked())
            {
               if(!_loc1_.isLegendary())
               {
                  _loc3_.icon.gotoAndStop("unlocked");
                  if(!_loc1_.isSpecial())
                  {
                     _loc3_.icon.title.title.text = _loc1_.getDungeonId();
                  }
               }
               Buttons.setButtons(bg,[_loc2_],true);
               this.putEnemies(_loc3_,_loc1_);
            }
            if(_loc3_.lastLevel)
            {
               _loc3_.lastLevel.stop();
               _loc3_.lastLevel.visible = false;
            }
         }
      }
      
      private function putEnemies(param1:MovieClip, param2:Level) : void
      {
         var _loc5_:Array = null;
         var _loc6_:MovieClip = null;
         var _loc8_:Element = null;
         var _loc9_:Element = null;
         var _loc3_:DungeonConfigData = DungeonFactory.getConfigFor(param2.getDungeonId());
         var _loc4_:cbArray = new cbArray();
         for each(_loc5_ in _loc3_.enemiesData)
         {
            _loc9_ = CharacterFactory.getInstance().getConfig(_loc5_[0]).element;
            _loc4_.pushIfNotPresent(_loc9_);
         }
         if(_loc4_.length == 1)
         {
            _loc6_ = main.swfLoader.getObject("assets.SkullsX3") as MovieClip;
            _loc6_.skull2.visible = false;
            _loc6_.skull3.visible = false;
         }
         else if(_loc4_.length == 2)
         {
            _loc6_ = main.swfLoader.getObject("assets.SkullsX2") as MovieClip;
         }
         else
         {
            if(_loc4_.length != 3)
            {
               throw new Error("WTF?!");
            }
            _loc6_ = main.swfLoader.getObject("assets.SkullsX3") as MovieClip;
         }
         var _loc7_:int = 1;
         for each(_loc8_ in _loc4_)
         {
            _loc6_["skull" + _loc7_].gotoAndStop(_loc8_.type);
            _loc7_++;
         }
         param1.addChild(_loc6_);
      }
      
      private function updatePage(param1:*, param2:uint) : void
      {
         this.actual_page = param2;
         this.refreshArrows(param2);
      }
      
      public function nextPage() : void
      {
         this.goToPage(this.actual_page + 1);
      }
      
      public function previousPage() : void
      {
         this.goToPage(this.actual_page - 1);
      }
      
      private function goToPage(param1:uint) : void
      {
         if(this.actual_page == param1)
         {
            this.updatePage(null,param1);
            return;
         }
         if(param1 > this.pageOfLevel(this.map.getMap().biggestUnlockedLevel()))
         {
            return;
         }
         this.hideArrows();
         var _loc2_:String = "page_" + this.actual_page + "/page_" + param1;
         bg.pages.gotoAndPlay(_loc2_);
         var _loc3_:SmartMC = new SmartMC(bg.pages);
         _loc3_.trigger(new EndCurrentLabel(bg.pages),new Lambda(this.updatePage,param1));
      }
      
      private function hideArrows() : void
      {
         this.nextArrow.hide();
         this.prevArrow.hide();
      }
      
      private function refreshArrows(param1:uint) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 + 1 <= this.pageOfLevel(this.map.getMap().biggestUnlockedLevel()))
         {
            this.nextArrow.show();
         }
         if(param1 != 1)
         {
            this.prevArrow.show();
         }
      }
      
      private function toMainMenu(param1:MouseEvent) : void
      {
         this.onToMainMenu.emit();
      }
      
      public function close() : void
      {
         pop();
      }
      
      override public function clear() : void
      {
         super.clear();
         this.lastPlayedTimer.stop();
         this.lastPlayedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.refreshLastLevel);
         this.lastPlayedTimer = null;
         this.onToDungeon.clear();
         this.onToMainMenu.clear();
         this.map = null;
      }
      
      public function refreshUnlocked(param1:cbArray) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Level = null;
         var _loc4_:String = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.getButtonName(_loc3_);
            if(_loc3_.isCleared())
            {
               _loc2_ = Util.getSprite(bg,_loc4_) as MovieClip;
               if(!_loc3_.isLegendary())
               {
                  _loc2_.icon.gotoAndStop("cleared");
                  if(!_loc3_.isSpecial())
                  {
                     _loc2_.icon.title.title.text = _loc3_.getDungeonId();
                  }
               }
               Buttons.setButtons(bg,[_loc4_],true);
               this.putEnemies(_loc2_,_loc3_);
            }
            else if(_loc3_.isUnlocked())
            {
               _loc2_ = Util.getSprite(bg,_loc4_) as MovieClip;
               if(!_loc3_.isLegendary())
               {
                  _loc2_.icon.gotoAndStop("unlocked");
                  if(!_loc3_.isSpecial())
                  {
                     _loc2_.icon.title.title.text = _loc3_.getDungeonId();
                  }
               }
               Buttons.setButtons(bg,[_loc4_],true);
               this.putEnemies(_loc2_,_loc3_);
            }
         }
         this.lastPlayedTimer.reset();
         this.lastPlayedTimer.start();
         this.refreshArrows(this.actual_page);
      }
      
      private function refreshLastLevel(param1:TimerEvent) : void
      {
         var _loc2_:MovieClip = Util.getSprite(bg,this.getButtonName(this.map.getMap().getLevel(main.saveSystem.getLastPlayed()))) as MovieClip;
         if(_loc2_.lastLevel)
         {
            _loc2_.lastLevel.visible = true;
            _loc2_.lastLevel.gotoAndPlay(1);
         }
      }
   }
}

