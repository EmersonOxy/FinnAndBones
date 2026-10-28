package view.screens.main_game
{
   import aplication.BasicState;
   import aplication.FSM;
   import cb.data.ButtonGroup;
   import cb.display.Screen;
   import cb.signals.Signal;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import main_game.boss_dungeon.BossDungeon;
   import main_game.map.Level;
   import sound.GameSounds;
   import util.Buttons;
   import util.Sepializer;
   import util.Util;
   import view.screens.main_game.boss_dungeon.BossDungeonState;
   import view.screens.main_game.bubblegum.BubblegumView;
   import view.screens.main_game.cookBook.CookBook;
   import view.screens.main_game.inventory.InventoryView;
   import view.screens.main_game.inventory.MixerView;
   import view.screens.main_game.inventory.StatsView;
   import view.screens.main_game.states.BasicPausableState;
   import view.screens.main_game.states.DungeonState;
   import view.screens.main_game.states.IPausable;
   import view.screens.main_game.states.MapState;
   
   public class GameView extends Screen
   {
      
      public var inventory:InventoryView = new InventoryView();
      
      public var mixing:MixerView = new MixerView();
      
      public var stats:StatsView = new StatsView();
      
      private var princess:BubblegumView = new BubblegumView();
      
      private var cookBook:CookBook;
      
      private var cookBookEnalbed:Boolean = true;
      
      private var fsm:FSM;
      
      public var up_holder:MovieClip;
      
      public var onExit:Signal;
      
      public var onEnd:Signal;
      
      public function GameView()
      {
         super(main.swfLoader.getClass("assets.Inventory"),this.getButtonInfo());
         this.up_holder = new MovieClip();
         this.addChildAt(this.up_holder,0);
         this.up_holder.game = new MovieClip();
         this.up_holder.pause = new MovieClip();
         this.up_holder.addChild(this.up_holder.game);
         this.up_holder.addChild(this.up_holder.pause);
         this.initialize();
         this.initializeFSM();
      }
      
      public function get pauseHolder() : DisplayObjectContainer
      {
         return this.up_holder.pause;
      }
      
      public function get gameHolder() : DisplayObjectContainer
      {
         return this.up_holder.game;
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["mix.mix_button"] = ButtonGroup.get("gui_mix").createButton(this.mixing.mix,"mouseOver",this.mixing.mixButtonOut);
         _loc1_["inventory.recipes"] = ButtonGroup.get("gui").createButton(this.clickOnRecipes,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function initialize() : void
      {
         this.onExit = new Signal();
         this.onEnd = new Signal();
         this.inventory.initialize(bg.inventory);
         this.mixing.initialize(bg.mix);
         this.stats.initialize(bg.stats);
         this.princess.initialize(bg.mix.pb);
         Buttons.setButtons(bg.inventory,["recipes"],true);
         main.game.onPause.add(this.updatePauseState);
      }
      
      private function updatePauseState(param1:Boolean) : void
      {
         if(param1)
         {
            bg.mouseChildren = false;
            bg.mouseEnabled = false;
            Sepializer.getInstance().sepialize(bg);
         }
         else
         {
            bg.mouseChildren = true;
            bg.mouseEnabled = true;
            Sepializer.getInstance().unsepialize(bg);
         }
      }
      
      private function initializeFSM() : void
      {
         var _loc1_:BasicState = new BasicPausableState("init");
         var _loc2_:BasicState = new BasicPausableState("exit",pop);
         var _loc3_:MapState = new MapState("map",this);
         var _loc4_:DungeonState = new DungeonState("dungeon",this);
         _loc4_.onToDungeon.add(this.toLevel);
         _loc4_.onToMap.add(this.showMap);
         var _loc5_:BossDungeonState = new BossDungeonState("boss",this);
         _loc5_.setNextDungeon(main.game.getMap().getLevel(BossDungeon.idBossLevel));
         _loc5_.onToDungeon.add(this.toLevel);
         _loc5_.onToMap.add(this.showMap);
         _loc5_.onToOutro.add(this.toOutro);
         this.fsm = new FSM(_loc1_);
         this.fsm.addState(_loc3_);
         this.fsm.addState(_loc4_);
         this.fsm.addState(_loc5_);
         this.fsm.addState(_loc2_);
         this.fsm.addTransition("init","map","enterMap");
         this.fsm.addTransition("map","map","enterMap");
         this.fsm.addTransition("dungeon","map","enterMap");
         this.fsm.addTransition("boss","map","enterMap");
         this.fsm.addTransition("map","dungeon","enterDungeon");
         this.fsm.addTransition("dungeon","dungeon","enterDungeon");
         this.fsm.addTransition("boss","dungeon","enterDungeon");
         this.fsm.addTransition("dungeon","boss","enterBoss");
         this.fsm.addTransition("boss","boss","enterBoss");
         this.fsm.addTransition("map","boss","enterBoss");
         this.fsm.addTransition("map","exit","leave");
         this.fsm.addTransition("boss","exit","leave");
      }
      
      private function get recipesButton() : MovieClip
      {
         return this.bg.inventory.recipes.book;
      }
      
      private function clickOnRecipes(param1:MouseEvent = null) : void
      {
         if(!this.cookBookEnalbed)
         {
            return;
         }
         this.disableCookButton();
         if(this.cookBook == null)
         {
            (this.fsm.getActualState() as IPausable).pause();
            this.recipesButton.gotoAndPlay("clicked");
            this.cookBook = new CookBook(this.clickOnRecipes);
            this.up_holder.addChild(this.cookBook);
            this.cookBook.enter(this.enableCookButton);
         }
         else
         {
            (this.fsm.getActualState() as IPausable).resume();
            this.recipesButton.gotoAndPlay("unclicked");
            this.cookBook.leave(this.removeCookBook);
         }
      }
      
      private function enableCookButton() : void
      {
         this.cookBookEnalbed = true;
         Buttons.setButtons(bg.inventory,["recipes"],true);
      }
      
      private function disableCookButton() : void
      {
         this.cookBookEnalbed = false;
         Buttons.setButtons(bg.inventory,["recipes"],false);
      }
      
      private function removeCookBook() : void
      {
         this.up_holder.removeChild(this.cookBook);
         this.cookBook.clear();
         this.cookBook = null;
         this.enableCookButton();
      }
      
      public function start() : void
      {
         this.fsm.takeTransition("enterMap");
      }
      
      public function showMap() : void
      {
         this.fsm.takeTransition("enterMap");
      }
      
      public function toLevel(param1:Level) : void
      {
         if(!Util.areLoaded(this.resourcesForLevel(param1),main.theLoader))
         {
            this.toLevelWaiting(param1);
         }
         else
         {
            this.toLevelWithoutWait(param1);
         }
      }
      
      private function resourcesForLevel(param1:Level) : Array
      {
         if(param1.getDungeonId() == BossDungeon.idBossLevel)
         {
            return GameSounds.bossSounds;
         }
         if(param1.getArea() <= 1 && !param1.isLegendary() && !param1.isSpecial())
         {
            return GameSounds.combatSoundsBasic;
         }
         return GameSounds.combatSounds;
      }
      
      public function toLevelWaiting(param1:Level) : void
      {
         main.waitForResources(this.resourcesForLevel(param1),Util.l(this.toLevelWithoutWait,param1));
      }
      
      private function toLevelWithoutWait(param1:Level) : void
      {
         if(param1.getDungeonId() == BossDungeon.idBossLevel)
         {
            this.fsm.takeTransition("enterBoss");
         }
         else
         {
            (this.fsm.getState("dungeon") as DungeonState).setNextDungeon(param1);
            this.fsm.takeTransition("enterDungeon");
         }
      }
      
      public function toMainMenu() : void
      {
         this.onExit.emit();
      }
      
      public function toOutro() : void
      {
         this.onEnd.emit();
      }
      
      public function exit() : void
      {
         this.fsm.takeTransition("leave");
      }
      
      override public function clear() : void
      {
         this.inventory.clear();
         this.mixing.clear();
         this.stats.clear();
         this.princess.clear();
         this.fsm.clear();
         super.clear();
      }
   }
}

