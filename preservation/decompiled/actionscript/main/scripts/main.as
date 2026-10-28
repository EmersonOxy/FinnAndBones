package
{
   import aplication.BasicState;
   import aplication.FSM;
   import bonus.ClassLoader;
   import bonus.DailyBonus;
   import bonus.IDailyBonus;
   import cb.data.Locale;
   import cb.display.SwfBulkLoader;
   import cb.logger.Appender;
   import cb.logger.JSConsoleAppender;
   import cb.logger.Log;
   import cb.media.SoundLoader;
   import drag_and_drop.DragDispatcher;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import loader.DynamicLoader;
   import loader.PostLoader;
   import loader.Preloader;
   import loader.SoundResourceLoader;
   import main_game.Game;
   import main_game.character.CharacterFactory;
   import main_game.dungeon.DungeonFactory;
   import main_game.items.ItemFactory;
   import persistence.SaveSystem;
   import sound.GameSounds;
   import sound.SoundManager;
   import tutorial.Tutorial;
   import util.Util;
   import view.screens.Intro;
   import view.screens.MainMenu;
   import view.screens.Outro;
   import view.screens.main_game.GameView;
   import view.screens.main_game.TransitionWindow;
   import view.screens.main_game.TransitionWindowJakeLess;
   
   [SWF(width="700", height="500", backgroundColor="#0a0a0a", frameRate="30")]
   public class main extends Sprite
   {
      
      public static var locale:Locale;
      
      public static var swfLoader:SwfBulkLoader;
      
      public static var soundManager:SoundManager;
      
      public static var config:ClassLoader;
      
      public static var levels:ClassLoader;
      
      public static var game:Game;
      
      public static var drag:DragDispatcher;
      
      public static var saveSystem:SaveSystem;
      
      public static var activeBonus:IDailyBonus;
      
      public static var theTutorial:Tutorial;
      
      public static var achievementDispatcher:AchievementDispatcher;
      
      public static var gameHolder:MovieClip;
      
      public static var popUpHolder:MovieClip;
      
      public static var tutorialHolder:MovieClip;
      
      public static var transitionHolder:MovieClip;
      
      private static var postLoader:PostLoader;
      
      private var fsmAplication:FSM;
      
      public function main()
      {
         super();
         Log.getLogger("debug").addAppender(new JSConsoleAppender());
         Log.getLogger("debug").addAppender(new Appender());
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      public static function get theLoader() : DynamicLoader
      {
         return postLoader;
      }
      
      public static function setDailyBonus(param1:ClassLoader) : void
      {
         DailyBonus.config = param1;
         activeBonus = DailyBonus.getBonusOfDate(new Date());
      }
      
      public static function waitForResourcesJakeLess(param1:Array, param2:Function, param3:Function = null) : void
      {
         var _loc4_:TransitionWindow = new TransitionWindowJakeLess(param1,param2,param3);
         _loc4_.start(transitionHolder);
      }
      
      public static function waitForResources(param1:Array, param2:Function, param3:Function = null) : void
      {
         var _loc4_:TransitionWindow = new TransitionWindow(param1,param2,param3);
         _loc4_.start(transitionHolder);
      }
      
      private function init(param1:Event = null) : void
      {
         var preloader:Preloader;
         var e:Event = param1;
         popUpHolder = new MovieClip();
         tutorialHolder = new MovieClip();
         gameHolder = new MovieClip();
         transitionHolder = new MovieClip();
         this.addChild(gameHolder);
         this.addChild(tutorialHolder);
         this.addChild(popUpHolder);
         popUpHolder.mouseChildren = false;
         popUpHolder.mouseEnabled = false;
         this.addChild(transitionHolder);
         this.disableKeyboard();
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         drag = new DragDispatcher(stage);
         soundManager = new SoundManager();
         saveSystem = new SaveSystem(stage);
         preloader = new Preloader(gameHolder);
         preloader.onLocaleLoaded.add(function(param1:Locale):void
         {
            locale = param1;
         });
         preloader.onConfigLoaded.add(function(param1:ClassLoader):void
         {
            config = param1;
         });
         preloader.onCharactersLoaded.add(function(param1:Dictionary):void
         {
            CharacterFactory.setConfig(param1);
         });
         preloader.onItemsLoaded.add(function(param1:Dictionary):void
         {
            ItemFactory.setConfig(param1);
         });
         preloader.onDungeonsLoaded.add(function(param1:Dictionary):void
         {
            DungeonFactory.setConfig(param1);
         });
         preloader.onLevelsLoaded.add(function(param1:ClassLoader):void
         {
            levels = param1;
         });
         preloader.onSwfLoaded.add(function(param1:SwfBulkLoader):void
         {
            swfLoader = param1;
         });
         preloader.onSoundLoaded.add(function(param1:SoundLoader):void
         {
            soundManager.start(param1);
         });
         preloader.onFinishLoading.add(this.preloadingComplete);
         achievementDispatcher = new AchievementDispatcher();
         this.fsmAplication = new FSM(new BasicState("preloading",preloader.start,achievementDispatcher.gameLoaded));
         this.fsmAplication.addState(new BasicState("mainMenu",this.showMainMenu,this.removeMainMenu));
         this.fsmAplication.addState(new BasicState("intro",this.showIntro,this.removeIntro));
         this.fsmAplication.addState(new BasicState("game",this.loadGame,this.leaveGame));
         this.fsmAplication.addState(new BasicState("outro",this.showOutro,this.removeOutro));
         this.fsmAplication.addTransition("preloading","mainMenu","loaded");
         this.fsmAplication.addTransition("mainMenu","intro","newGame");
         this.fsmAplication.addTransition("mainMenu","game","continueGame");
         this.fsmAplication.addTransition("intro","game","next");
         this.fsmAplication.addTransition("intro","mainMenu","back");
         this.fsmAplication.addTransition("game","mainMenu","toMainMenu");
         this.fsmAplication.addTransition("game","outro","endGame");
         this.fsmAplication.addTransition("outro","game","next");
         this.fsmAplication.start();
      }
      
      private function disableKeyboard() : void
      {
         gameHolder.tabEnabled = false;
         gameHolder.tabChildren = false;
         tutorialHolder.tabEnabled = false;
         tutorialHolder.tabChildren = false;
      }
      
      private function preloadingComplete(param1:Preloader) : void
      {
         assert(swfLoader != null,"swfLoader is missing!");
         assert(locale != null,"Locale is missing!");
         assert(soundManager.ready(),"soundMixer is missing!");
         assert(config != null,"config is missing!");
         assert(DailyBonus.config != null,"dailybonus is missing!");
         postLoader = new PostLoader(GameSounds.soundsToLoad,new SoundResourceLoader(soundManager));
         postLoader.start();
         param1.pop();
         this.fsmAplication.takeTransition("loaded");
      }
      
      private function showMainMenu() : void
      {
         var mm:MainMenu = new MainMenu();
         (this.fsmAplication.getActualState() as BasicState).persistency = mm;
         gameHolder.addChild(mm);
         mm.onNewGame.add(Util.l(waitForResourcesJakeLess,[],function():void
         {
            fsmAplication.takeTransition("newGame");
         }));
         mm.onContinueGame.add(Util.l(waitForResources,GameSounds.mapSounds,function():void
         {
            fsmAplication.takeTransition("continueGame");
         }));
         mm.enter();
      }
      
      private function removeMainMenu() : void
      {
         var _loc1_:MainMenu = (this.fsmAplication.getActualState() as BasicState).persistency as MainMenu;
         _loc1_.exit();
      }
      
      private function showIntro() : void
      {
         var intro:Intro;
         saveSystem.reset();
         intro = new Intro();
         (this.fsmAplication.getActualState() as BasicState).persistency = intro;
         gameHolder.addChild(intro);
         intro.onNext.add(Util.l(waitForResources,GameSounds.mapSounds,function():void
         {
            saveSystem.onFirstPlay();
            fsmAplication.takeTransition("next");
         }));
         intro.onBack.add(Util.l(waitForResourcesJakeLess,[],function():void
         {
            fsmAplication.takeTransition("back");
         }));
         intro.enter();
      }
      
      private function removeIntro() : void
      {
         var _loc1_:Intro = (this.fsmAplication.getActualState() as BasicState).persistency as Intro;
         _loc1_.exit();
      }
      
      private function showOutro() : void
      {
         var outro:Outro;
         achievementDispatcher.gameWon();
         outro = new Outro();
         (this.fsmAplication.getActualState() as BasicState).persistency = outro;
         gameHolder.addChild(outro);
         outro.onNext.add(Util.l(waitForResourcesJakeLess,[],function():void
         {
            saveSystem.onFirstPlay();
            fsmAplication.takeTransition("next");
         }));
         outro.onBack.add(Util.l(waitForResources,[],function():void
         {
            fsmAplication.takeTransition("next");
         }));
         outro.enter();
      }
      
      private function removeOutro() : void
      {
         var _loc1_:Outro = (this.fsmAplication.getActualState() as BasicState).persistency as Outro;
         _loc1_.exit();
      }
      
      private function loadGame() : void
      {
         var gameView:GameView;
         theTutorial = new Tutorial();
         game = new Game();
         game.enter();
         if(activeBonus != null)
         {
            activeBonus.activate();
         }
         gameView = new GameView();
         gameHolder["gameView"] = gameView;
         gameHolder.addChild(gameView);
         gameView.onExit.add(Util.l(waitForResources,[],function():void
         {
            fsmAplication.takeTransition("toMainMenu");
         }));
         gameView.onEnd.add(Util.l(waitForResources,[],function():void
         {
            fsmAplication.takeTransition("endGame");
         }));
         gameView.start();
         theTutorial.next();
         achievementDispatcher.gamePlayed();
      }
      
      private function leaveGame() : void
      {
         var _loc1_:GameView = gameHolder["gameView"];
         _loc1_.exit();
         drag.clear();
         game.exit();
      }
   }
}

