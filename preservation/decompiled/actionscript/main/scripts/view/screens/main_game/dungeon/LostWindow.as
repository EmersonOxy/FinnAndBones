package view.screens.main_game.dungeon
{
   import cb.data.ButtonGroup;
   import cb.signals.Signal;
   import cb.utils.Tween;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import main_game.character.stats.Stats;
   import main_game.dungeon.DungeonStats;
   import util.Buttons;
   import util.Util;
   import view.popUp.LevelUp;
   import view.screens.AnimatedScreen;
   
   public class LostWindow extends AnimatedScreen implements EndDungeonWindow
   {
      
      private var onReplay:Signal;
      
      private var onBackToMap:Signal;
      
      private var experience:int;
      
      private var stats:DungeonStats;
      
      public function LostWindow(param1:DungeonStats)
      {
         super(main.swfLoader.getClass("assets.LevelLose"),this.getButtonInfo());
         this.stats = param1;
         this.onReplay = new Signal();
         this.onBackToMap = new Signal();
         this.initialize();
      }
      
      public function getOnReplay() : Signal
      {
         return this.onReplay;
      }
      
      public function getOnBackToMap() : Signal
      {
         return this.onBackToMap;
      }
      
      public function putIn(param1:DisplayObjectContainer) : void
      {
         param1.addChild(this);
      }
      
      public function pause() : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function initialize() : void
      {
         bg.total.total_xp.numbers.gotoAndStop(1);
         bg.total.total.title.text = main.locale.get("lose_combat",[this.stats.level.getName()]);
         this.xp = 0;
      }
      
      public function get xp() : int
      {
         return this.experience;
      }
      
      public function set xp(param1:int) : void
      {
         this.experience = param1;
         bg.total.total_xp.numbers.title.text = main.locale.get("lose_xp_amount",[this.experience]);
      }
      
      override public function enter(param1:Function = null) : void
      {
         super.enter(Util.l(this.showStats,param1));
         Buttons.setButtons(bg,["replay","level_select"],true);
      }
      
      private function showStats(param1:Function = null) : void
      {
         var end:Function = param1;
         if(end != null)
         {
            end();
         }
         Tween.to(this,1000,{"xp":this.stats.getCombatExperience()},function():void
         {
            bg.total.total_xp.numbers.gotoAndPlay(1);
            giveXp();
         });
      }
      
      private function giveXp() : void
      {
         var _loc1_:Stats = main.game.getFinn().stats;
         var _loc2_:uint = _loc1_.getLevel();
         _loc1_.addXP(this.stats.getCombatExperience());
         if(_loc2_ < _loc1_.getLevel())
         {
            new LevelUp();
         }
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["replay"] = _loc2_.createButton(this.replay,"mouseOver","mouseOut");
         _loc1_["level_select"] = _loc2_.createButton(this.back,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function replay(param1:MouseEvent) : void
      {
         this.emitAndLeave(this.onReplay);
      }
      
      private function back(param1:MouseEvent) : void
      {
         this.emitAndLeave(this.onBackToMap);
      }
      
      private function emitAndLeave(param1:Signal) : void
      {
         var signal:Signal = param1;
         this.killTweens();
         Buttons.setButtons(bg,["replay","level_select"],false);
         signal.emit();
         leave(function():void
         {
            exit();
         });
      }
      
      private function killTweens() : void
      {
         if(Tween.isTweening(this))
         {
            Tween.killTweensOf(this);
            this.giveXp();
         }
      }
      
      private function exit() : void
      {
         this.onBackToMap.clear();
         this.onReplay.clear();
         this.stats = null;
         removeEvents();
         pop();
      }
   }
}

