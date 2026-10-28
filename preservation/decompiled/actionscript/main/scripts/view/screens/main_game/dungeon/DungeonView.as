package view.screens.main_game.dungeon
{
   import cb.data.ButtonGroup;
   import cb.display.Screen;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import main_game.character.CharacterFactory;
   import main_game.dungeon.DungeonFactory;
   import main_game.dungeon.DungeonStats;
   import main_game.dungeon.IFight;
   import main_game.dungeon.Loot;
   import main_game.items.Item;
   import main_game.map.Level;
   import sound.GameSounds;
   import util.Buttons;
   import util.Util;
   import view.figthers.FinnView;
   import view.figthers.animations.DieAnimation;
   import view.figthers.animations.IFighterAnimation;
   import view.figthers.animations.JoyAnimation;
   import view.screens.Pause;
   import view.screens.main_game.dungeon.fight.EnterDungeonView;
   import view.screens.main_game.dungeon.fight.FightView;
   import view.screens.main_game.states.IDungeonState;
   
   public class DungeonView extends Screen implements IDungeonView
   {
      
      public var dungeon:IDungeonState;
      
      protected var finnView:FinnView;
      
      protected var timeLine:TimeLine;
      
      protected var innerView:InnerDungeonView;
      
      private var windowShowing:EndDungeonWindow;
      
      public function DungeonView(param1:IDungeonState)
      {
         this.dungeon = param1;
         param1.getDungeon().onFight.add(this.onFight);
         this.innerView = new EmptyInnerView(this.soundTrack);
         super(BackgroundView,this.getButtonInfo());
         main.game.getFinn().onPotionConsumition.add(this.potionConsumition);
         this.background.finnHud.changeFighter(main.game.getFinn());
         this.initialize();
         this.timeLine = new TimeLine(this);
         addChild(this.timeLine);
      }
      
      public function get background() : BackgroundView
      {
         return this.bg as BackgroundView;
      }
      
      protected function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["information.pause"] = ButtonGroup.get("gui").createButton(this.pause,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      protected function initialize() : void
      {
         Buttons.setButtons(this.background.information,["pause"],true);
         this.background.init(DungeonFactory.getConfigFor(this.dungeon.getDungeon().getId()));
         this.playMusic();
         this.finnView = CharacterFactory.getInstance().getFinnView(main.game.getFinn());
         this.dungeon.getDungeon().onLose.add(this.dungeonLost);
         this.dungeon.getDungeon().onWin.add(this.dungeonWon);
         this.start();
      }
      
      protected function playMusic() : void
      {
         main.soundManager.playMusic(this.soundTrack);
      }
      
      protected function start() : void
      {
         this.innerView.clear();
         this.innerView = new EnterDungeonView(this.finnView,this.background,this.dungeon.getDungeon().startFight);
      }
      
      protected function potionConsumition(param1:Item) : void
      {
         if(main.game.getFinn().stats.isDead())
         {
            this.suddenDeath();
         }
      }
      
      protected function suddenDeath() : void
      {
         this.innerView.pause();
         var _loc1_:DieAnimation = new DieAnimation();
         this.finnView.animate(_loc1_);
         _loc1_.getAtFinish().add(Util.removeParams(this.dungeon.getDungeon().suddenDeath));
      }
      
      public function pauseFight() : void
      {
         if(this.windowShowing != null)
         {
            this.windowShowing.pause();
         }
         this.innerView.pause();
      }
      
      public function resumeFight() : void
      {
         if(this.windowShowing != null)
         {
            this.windowShowing.resume();
         }
         this.innerView.resume();
      }
      
      protected function pause(param1:MouseEvent) : void
      {
         if(main.game.getFinn().stats.isDead())
         {
            return;
         }
         this.innerView.pause();
         var _loc2_:Pause = new Pause(this.getDungeonLevel());
         _loc2_.onLevelSelect.add(this.onLevelSelect);
         _loc2_.onCancel.add(this.resume);
         _loc2_.onReplay.add(this.onReplay);
         this.dungeon.pauseHolder.addChild(_loc2_);
         _loc2_.enter();
      }
      
      protected function getDungeonLevel() : Level
      {
         return main.game.getMap().getLevel(this.dungeon.getDungeon().getId());
      }
      
      protected function resume() : void
      {
         this.playMusic();
         this.innerView.resume();
      }
      
      protected function onLevelSelect() : void
      {
         this.dungeon.onToMap.emit();
      }
      
      protected function onReplay() : void
      {
         this.gotoDungeonId(this.dungeon.getDungeon().getId());
      }
      
      private function gotoDungeonId(param1:String) : void
      {
         var _loc2_:Level = main.game.getMap().getLevel(param1);
         this.dungeon.onToDungeon.emit(_loc2_);
      }
      
      public function onFight(param1:IFight) : void
      {
         this.innerView.clear();
         this.innerView = new FightView(param1,this.finnView,this.background);
      }
      
      protected function getStats() : DungeonStats
      {
         return this.dungeon.getDungeon().getStats();
      }
      
      protected function getLoot() : Loot
      {
         return this.dungeon.getDungeon().getLoot();
      }
      
      protected function get soundTrack() : String
      {
         if(this.dungeon.getDungeon().getLevel().getArea() < 3)
         {
            return GameSounds.COMBAT_MUSIC;
         }
         return GameSounds.COMBAT_MUSIC2;
      }
      
      protected function stopMusic() : void
      {
         main.soundManager.stopMusic(this.soundTrack);
      }
      
      protected function dungeonLost() : void
      {
         this.stopMusic();
         Buttons.setButtons(this.background.information,["pause"],false);
         var _loc1_:LostWindow = new LostWindow(this.getStats());
         this.showFinishWindow(_loc1_);
      }
      
      protected function dungeonWon() : void
      {
         var joy:JoyAnimation;
         var winWindow:WinWindow = null;
         this.stopMusic();
         Buttons.setButtons(this.background.information,["pause"],false);
         joy = new JoyAnimation();
         this.finnView.animate(joy);
         winWindow = this.makeWinWindow();
         joy.getAtFinish().add(function(param1:IFighterAnimation):void
         {
            showFinishWindow(winWindow);
         });
      }
      
      protected function makeWinWindow() : WinWindow
      {
         var _loc2_:Function = null;
         var _loc1_:Level = main.game.getMap().getNextLevel(this.dungeon.getDungeon().getLevel());
         if(_loc1_ != null && _loc1_.getArea() == this.dungeon.getDungeon().getLevel().getArea())
         {
            _loc2_ = Util.l(this.dungeon.onToDungeon.emit,_loc1_);
         }
         return new WinWindow(this.getLoot(),this.getStats(),_loc2_);
      }
      
      private function showFinishWindow(param1:EndDungeonWindow) : void
      {
         this.windowShowing = param1;
         param1.getOnReplay().add(this.onReplay);
         param1.getOnBackToMap().add(this.onLevelSelect);
         param1.putIn(this.dungeon.pauseHolder);
         param1.enter(this.endEnterFinishWindow);
      }
      
      protected function endEnterFinishWindow() : void
      {
         if(this.finnView)
         {
            this.finnView.clear();
            this.finnView = null;
         }
         this.innerView.clear();
         this.innerView = new EmptyInnerView(this.soundTrack);
         this.background.pauseScroll();
      }
      
      public function close() : void
      {
         main.game.getFinn().onPotionConsumition.remove(this.potionConsumition);
         this.innerView.clear();
         this.background.clear();
         pop();
         if(this.finnView)
         {
            this.finnView.clear();
            this.finnView = null;
         }
         this.timeLine.clear();
         this.dungeon = null;
      }
   }
}

