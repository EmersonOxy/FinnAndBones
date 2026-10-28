package view.screens.main_game.dungeon
{
   import cb.data.ButtonGroup;
   import cb.signals.Signal;
   import cb.utils.Tween;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import main_game.character.stats.Stats;
   import main_game.dungeon.DungeonStats;
   import main_game.dungeon.Loot;
   import sound.GameSounds;
   import util.Buttons;
   import util.Util;
   import view.popUp.LevelUp;
   import view.screens.AnimatedScreen;
   
   public class WinWindow extends AnimatedScreen implements EndDungeonWindow
   {
      
      public static var onShow:Function = null;
      
      private static const COMBAT:int = 0;
      
      private static const CRITICAL:int = 1;
      
      private static const MIX:int = 2;
      
      private static const TOTAL:int = 3;
      
      private static const COMBAT_BONUS:String = "combat_experience";
      
      private static const MIX_BONUS:String = "mix_bonus";
      
      private static const CRITICAL_BONUS:String = "hit_bonus";
      
      private static const TOTAL_BONUS:String = "total";
      
      private var onReplay:Signal;
      
      private var onBackToMap:Signal;
      
      private var onNext:Function;
      
      private var loot:LootView;
      
      private var values:Array;
      
      private var stats:DungeonStats;
      
      public function WinWindow(param1:Loot, param2:DungeonStats, param3:Function = null)
      {
         super(main.swfLoader.getClass("assets.LevelWin"),this.getButtonInfo());
         this.stats = param2;
         this.loot = new LootView(param1,bg);
         this.onReplay = new Signal();
         this.onBackToMap = new Signal();
         this.onNext = param3;
         this.values = new Array(0,0,0,0);
         this.initialize();
      }
      
      public function pause() : void
      {
         this.loot.pause();
      }
      
      public function resume() : void
      {
         this.loot.resume();
      }
      
      public function get lootMcButton() : MovieClip
      {
         return this.bg.loot;
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
         param1["window"] = this;
         param1.addChild(this);
      }
      
      public function get infoMc() : MovieClip
      {
         return bg.info;
      }
      
      public function initialize() : void
      {
         this.infoMc[COMBAT_BONUS + "_xp"].gotoAndStop(1);
         this.infoMc[MIX_BONUS + "_xp"].gotoAndStop(1);
         this.infoMc[CRITICAL_BONUS + "_xp"].gotoAndStop(1);
         this.infoMc[TOTAL_BONUS + "_xp"].gotoAndStop(1);
         this.combatXp = 0;
         this.criticalXp = 0;
         this.mixXp = 0;
         this.totalXp = 0;
         this.infoMc[COMBAT_BONUS].title.text = main.locale.get("win_combat");
         this.infoMc[CRITICAL_BONUS].title.text = main.locale.get("win_critical_bonus");
         this.infoMc[MIX_BONUS].title.text = main.locale.get("win_mix_bonus");
         this.infoMc[TOTAL_BONUS].title.text = main.locale.get("win_total",[this.stats.level.getName()]);
      }
      
      public function set combatXp(param1:int) : void
      {
         this.values[COMBAT] = param1;
         this.infoMc[COMBAT_BONUS + "_xp"].numbers.title.text = main.locale.get("win_xp_amount",[param1]);
      }
      
      public function get combatXp() : int
      {
         return this.values[COMBAT];
      }
      
      public function set criticalXp(param1:int) : void
      {
         this.values[CRITICAL] = param1;
         this.infoMc[CRITICAL_BONUS + "_xp"].numbers.title.text = main.locale.get("win_xp_amount",[param1]);
      }
      
      public function get criticalXp() : int
      {
         return this.values[CRITICAL];
      }
      
      public function set mixXp(param1:int) : void
      {
         this.values[MIX] = param1;
         this.infoMc[MIX_BONUS + "_xp"].numbers.title.text = main.locale.get("win_xp_amount",[param1]);
      }
      
      public function get mixXp() : int
      {
         return this.values[MIX];
      }
      
      public function set totalXp(param1:int) : void
      {
         this.values[TOTAL] = param1;
         this.infoMc[TOTAL_BONUS + "_xp"].numbers.title.text = main.locale.get("win_xp_amount",[this.values[TOTAL]]);
      }
      
      public function get totalXp() : int
      {
         return this.values[TOTAL];
      }
      
      override public function enter(param1:Function = null) : void
      {
         super.enter(Util.l(this.showStats,param1));
         Buttons.setButtons(bg,["replay","level_select","loot","next"],true);
         if(this.onNext == null)
         {
            bg.removeChild(bg["next"]);
         }
         main.soundManager.playMusic(GameSounds.WIN_MUSIC);
      }
      
      override public function leave(param1:Function = null) : void
      {
         this.loot.pause();
         main.soundManager.stopFx(GameSounds.DUNGEON_COMPLETED);
         main.soundManager.stopMusic(GameSounds.WIN_MUSIC);
         super.leave(Util.concatenate(this.loot.clear,param1));
      }
      
      private function showStats(param1:Function = null) : void
      {
         if(param1 != null)
         {
            param1();
         }
         this.loot.showLoot();
         this.updateProperty("combatXp",this.stats.getCombatExperience(),COMBAT_BONUS,Util.l(this.updateProperty,"criticalXp",this.stats.getCriticalExperience(),CRITICAL_BONUS,Util.l(this.updateProperty,"mixXp",this.stats.getMixExperience(),MIX_BONUS,Util.l(this.updateProperty,"totalXp",this.stats.getDungeonExperience(),TOTAL_BONUS,this.giveXp))));
         if(onShow != null)
         {
            onShow();
         }
      }
      
      private function giveXp() : void
      {
         var _loc1_:Stats = main.game.getFinn().stats;
         var _loc2_:uint = _loc1_.getLevel();
         _loc1_.addXP(this.stats.getDungeonExperience());
         if(_loc2_ < _loc1_.getLevel())
         {
            new LevelUp();
         }
      }
      
      private function updateProperty(param1:String, param2:int, param3:String, param4:Function) : void
      {
         var _loc5_:Object = null;
         if(param2 == this[param1])
         {
            param4();
         }
         else
         {
            _loc5_ = new Object();
            _loc5_[param1] = param2;
            Tween.to(this,700,_loc5_,Util.l(this.makeFinalCountAnimation,this.infoMc[param3 + "_xp"],param4));
         }
      }
      
      private function makeFinalCountAnimation(param1:MovieClip, param2:Function) : void
      {
         param1.gotoAndPlay(1);
         param2();
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["replay"] = _loc2_.createButton(this.replay,"mouseOver","mouseOut");
         _loc1_["level_select"] = _loc2_.createButton(this.toMap,"mouseOver","mouseOut");
         _loc1_["next"] = _loc2_.createButton(this.next,"mouseOver","mouseOut");
         _loc1_["loot"] = _loc2_.createButton(this.takeAllLoot,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function takeAllLoot(param1:MouseEvent) : void
      {
         this.loot.takeAll();
         Buttons.setButtons(bg,["loot"],!this.loot.isEmpty());
      }
      
      private function replay(param1:MouseEvent) : void
      {
         var me:MouseEvent = param1;
         this.stopTweens();
         Buttons.setButtons(bg,["replay","level_select","loot"],false);
         if(this.onNext != null)
         {
            Buttons.setButtons(bg,["next"],false);
         }
         this.onReplay.emit();
         this.leave(function():void
         {
            exit();
         });
      }
      
      private function toMap(param1:MouseEvent) : void
      {
         var me:MouseEvent = param1;
         this.stopTweens();
         Buttons.setButtons(bg,["replay","level_select","loot"],false);
         if(this.onNext != null)
         {
            Buttons.setButtons(bg,["next"],false);
         }
         this.onBackToMap.emit();
         this.leave(function():void
         {
            exit();
         });
      }
      
      private function next(param1:MouseEvent) : void
      {
         var me:MouseEvent = param1;
         this.stopTweens();
         Buttons.setButtons(bg,["replay","level_select","loot"],false);
         if(this.onNext != null)
         {
            Buttons.setButtons(bg,["next"],false);
            this.onNext();
         }
         this.leave(function():void
         {
            exit();
         });
      }
      
      private function stopTweens() : void
      {
         if(Tween.isTweening(this))
         {
            Tween.killTweensOf(this);
            this.giveXp();
         }
      }
      
      private function exit() : void
      {
         this.loot = null;
         this.stats = null;
         this.onBackToMap.clear();
         this.onReplay.clear();
         this.onNext = null;
         removeEvents();
         pop();
      }
   }
}

