package loader
{
   import bonus.ClassLoader;
   import bonus.FileLoader;
   import cb.actions.Functor;
   import cb.conditions.AnimationFrameAt;
   import cb.data.CsvLoader;
   import cb.display.SmartMC;
   import cb.display.SwfBulkLoader;
   import cb.logger.Log;
   import cb.media.SoundLoader;
   import cb.signals.Signal;
   import cb.utils.LoadingObject;
   import cb.utils.Rule;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import main_game.character.stats.Experience;
   import main_game.dungeon.DungeonFactory;
   import main_game.mixer.MixStrategy;
   
   public class Preloader
   {
      
      private static var log:Log = Log.getLogger("Preloader");
      
      private static var TO_LOAD:int = 14680858;
      
      public var onLocaleLoaded:Signal;
      
      public var onSwfLoaded:Signal;
      
      public var onSoundLoaded:Signal;
      
      public var onConfigLoaded:Signal;
      
      public var onCharactersLoaded:Signal;
      
      public var onDungeonsLoaded:Signal;
      
      public var onItemsLoaded:Signal;
      
      public var onLevelsLoaded:Signal;
      
      public var onFinishLoading:Signal;
      
      private var loadedSoFar:int;
      
      private var rule:Rule;
      
      private var preloadingObject:LoadingObject;
      
      private var preloader:MovieClip;
      
      private var bg:DisplayObjectContainer;
      
      public function Preloader(param1:DisplayObjectContainer)
      {
         super();
         this.bg = param1;
         this.initSignals();
      }
      
      public function start() : void
      {
         this.preloadingObject = new LoadingObject({
            "swfs":["PreloaderCN.swf"],
            "locale":"locale.txt"
         });
         this.preloadingObject.loaded.add(this.preloadComplete);
         this.preloadingObject.load();
         log.log("load");
      }
      
      private function initSignals() : void
      {
         this.onLocaleLoaded = new Signal();
         this.onSwfLoaded = new Signal();
         this.onSoundLoaded = new Signal();
         this.onConfigLoaded = new Signal();
         this.onCharactersLoaded = new Signal();
         this.onDungeonsLoaded = new Signal();
         this.onItemsLoaded = new Signal();
         this.onLevelsLoaded = new Signal();
         this.onFinishLoading = new Signal();
      }
      
      private function preloadComplete(param1:LoadingObject) : void
      {
         log.log("preloadingComplete");
         var _loc2_:SwfBulkLoader = param1.getSwfLoader();
         this.preloader = _loc2_.getObject("assets.PreloaderCN") as MovieClip;
         this.preloader.width = 700;
         this.preloader.height = 500;
         this.preloader.stop();
         this.bg.addChild(this.preloader);
         this.onLocaleLoaded.emit(param1.getLocale());
         this.onLocaleLoaded.clear();
         this.preloadingObject.loaded.clear();
         this.preloadingObject = null;
         this.loadedSoFar = 0;
         this.rule = new Rule("swf","characters","items","config","dungeons","mix","finn_level","sounds","bonus","firstLoot");
         this.rule.completed.add(this.endPreloader);
         var _loc3_:SwfBulkLoader = new SwfBulkLoader("swfs.txt");
         _loc3_.progress.add(this.loadingProgress);
         _loc3_.loaded.add(this.loadComplete);
         _loc3_.load();
         var _loc4_:CsvLoader = new CsvLoader("characters.csv");
         _loc4_.loaded.add(this.charactersComplete);
         _loc4_.load();
         var _loc5_:CsvLoader = new CsvLoader("finnXP.csv");
         _loc5_.loaded.add(this.levelingComplete);
         _loc5_.load();
         var _loc6_:CsvLoader = new CsvLoader("mix.csv");
         _loc6_.loaded.add(this.mixComplete);
         _loc6_.load();
         var _loc7_:CsvLoader = new CsvLoader("items.csv");
         _loc7_.loaded.add(this.itemsComplete);
         _loc7_.load();
         var _loc8_:FileLoader = new FileLoader("config.di");
         _loc8_.addEventListener(Event.COMPLETE,this.configComplete);
         _loc8_.load();
         var _loc9_:FileLoader = new FileLoader("dailyBonus.di");
         _loc9_.addEventListener(Event.COMPLETE,this.bonusComplete);
         _loc9_.load();
         var _loc10_:CsvLoader = new CsvLoader("dungeons.csv");
         _loc10_.loaded.add(this.dungeonsComplete);
         _loc10_.load();
         var _loc11_:CsvLoader = new CsvLoader("firstLoot.csv");
         _loc11_.loaded.add(this.lootComplete);
         _loc11_.load();
         var _loc12_:SoundLoader = new SoundLoader("sounds.snd");
         _loc12_.progress.add(this.loadingProgress);
         _loc12_.loaded.add(this.soundLoadingCompleted);
         _loc12_.load();
      }
      
      private function soundLoadingCompleted(param1:SoundLoader) : void
      {
         log.log("Sounds Loaded");
         param1.loaded.clear();
         this.onSoundLoaded.emit(param1);
         this.onSoundLoaded.clear();
         this.rule.check("sounds");
      }
      
      private function levelsComplete(param1:Event) : void
      {
         log.log("Levels Loaded");
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.levelsComplete);
         this.onLevelsLoaded.emit(new ClassLoader(param1.target as FileLoader));
         this.onLevelsLoaded.clear();
         this.rule.check("levels");
      }
      
      private function configComplete(param1:Event) : void
      {
         log.log("config Loaded");
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.configComplete);
         this.onConfigLoaded.emit(new ClassLoader(param1.target as FileLoader));
         this.onConfigLoaded.clear();
         this.rule.check("config");
      }
      
      private function bonusComplete(param1:Event) : void
      {
         log.log("bonus Loaded");
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.bonusComplete);
         main.setDailyBonus(new ClassLoader(param1.target as FileLoader));
         this.rule.check("bonus");
      }
      
      private function dungeonsComplete(param1:CsvLoader) : void
      {
         log.log("dungeons Loaded");
         this.onDungeonsLoaded.emit(param1.convertToObjects());
         this.onDungeonsLoaded.clear();
         this.rule.check("dungeons");
      }
      
      private function lootComplete(param1:CsvLoader) : void
      {
         log.log("First loot Complete");
         DungeonFactory.firstLoot = param1.convertToObjects();
         this.rule.check("firstLoot");
      }
      
      private function charactersComplete(param1:CsvLoader) : void
      {
         log.log("characters Loaded");
         this.onCharactersLoaded.emit(param1.convertToObjects());
         this.onCharactersLoaded.clear();
         this.rule.check("characters");
      }
      
      private function levelingComplete(param1:CsvLoader) : void
      {
         log.log("leveling Loaded");
         Experience.configuration = param1.convertToObjects();
         this.rule.check("finn_level");
      }
      
      private function mixComplete(param1:CsvLoader) : void
      {
         log.log("mix Loaded");
         MixStrategy.config = param1.convertToObjects();
         this.rule.check("mix");
      }
      
      private function itemsComplete(param1:CsvLoader) : void
      {
         log.log("items Loaded");
         this.onItemsLoaded.emit(param1.convertToObjects());
         this.onItemsLoaded.clear();
         this.rule.check("items");
      }
      
      private function loadComplete(param1:SwfBulkLoader) : void
      {
         log.log("Swf Loaded");
         param1.loaded.clear();
         this.onSwfLoaded.emit(param1);
         this.onSwfLoaded.clear();
         this.rule.check("swf");
      }
      
      private function loadingProgress(param1:int) : void
      {
         this.loadedSoFar += param1;
         log.log("loadingProgress ",this.loadedSoFar);
         var _loc2_:int = this.loadedSoFar * 100 / TO_LOAD;
         if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         this.preloader.done_mc.gotoAndStop(_loc2_);
      }
      
      public function pop() : void
      {
         this.bg.removeChild(this.preloader);
         this.clear();
      }
      
      private function clear() : void
      {
         this.bg = null;
         this.preloader = null;
         this.preloadingObject = null;
         this.onCharactersLoaded.clear();
         this.onConfigLoaded.clear();
         this.onDungeonsLoaded.clear();
         this.onFinishLoading.clear();
         this.onItemsLoaded.clear();
         this.onLevelsLoaded.clear();
         this.onLocaleLoaded.clear();
         this.onSoundLoaded.clear();
         this.onSwfLoaded.clear();
      }
      
      private function endPreloader() : void
      {
         this.preloader.done_mc.gotoAndStop(100);
         this.preloader.gotoAndPlay(3);
         var _loc1_:SmartMC = new SmartMC(this.preloader);
         _loc1_.trigger(new AnimationFrameAt(43),Functor.wrap(this.emitFinish));
      }
      
      private function emitFinish() : void
      {
         this.onFinishLoading.emit(this);
      }
   }
}

