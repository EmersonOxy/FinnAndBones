package view.screens.main_game.dungeon
{
   import cb.gameloop.GameLoop;
   import cb.signals.Signal;
   import flash.display.MovieClip;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.DungeonConfigData;
   import view.figthers.AnimatedHudView;
   import view.figthers.HudSetter;
   import view.figthers.HudSetterWithStats;
   import view.figthers.HudView;
   import view.screens.main_game.dungeon.fight.FightFeedback;
   
   public class BackgroundView extends MovieClip
   {
      
      public var layer1:MovieClip;
      
      public var layer2:MovieClip;
      
      public var layer3:MovieClip;
      
      public var information:MovieClip;
      
      public var arena:MovieClip;
      
      public var mist1:MovieClip;
      
      public var mist2:MovieClip;
      
      private var backgrounds1:BackgroundSet;
      
      private var backgrounds2:BackgroundSet;
      
      private var backgrounds3:BackgroundSet;
      
      private var paused:Boolean;
      
      private var scrolling:Boolean;
      
      private var gameLoop:GameLoop;
      
      public var onMove:Signal;
      
      private var enemyHudView:HudView;
      
      private var finnHudView:HudView;
      
      private var finnFeedback:FightFeedback;
      
      private var enemyFeedback:FightFeedback;
      
      public function BackgroundView()
      {
         super();
         this.onMove = new Signal();
         this.enemyHudView = new AnimatedHudView(main.swfLoader.getClass("assets.EnemyBar"),new HudSetterWithStats());
         this.finnHudView = new HudView(main.swfLoader.getClass("assets.FinnBar"),new HudSetter());
         this.setLayers();
         this.setPauseButton();
         this.paused = false;
         this.scrolling = false;
         this.gameLoop = new GameLoop(this);
         this.gameLoop.updated.add(this.scroll);
         this.enemyHudView.initialize(this.information);
         this.finnHudView.initialize(this.information);
         this.finnFeedback = new FightFeedback();
         this.enemyFeedback = new FightFeedback();
      }
      
      private static function get VELOCITY1() : int
      {
         return Dungeon.DungeonConfig["layer1_pps"];
      }
      
      public static function get ARENA_VELOCITY() : int
      {
         return Dungeon.DungeonConfig["layer2_pps"];
      }
      
      private static function get VELOCITY3() : int
      {
         return Dungeon.DungeonConfig["layer3_pps"];
      }
      
      private static function get MIST_VELOCITY() : int
      {
         return Dungeon.DungeonConfig["mist_pps"];
      }
      
      private static function get PIXEL_OVERLAP() : int
      {
         return 1;
      }
      
      private static function get MIST_OVERLAP() : int
      {
         return 130;
      }
      
      public function get enemyHud() : HudView
      {
         return this.enemyHudView;
      }
      
      public function get finnHud() : HudView
      {
         return this.finnHudView;
      }
      
      private function setLayers() : void
      {
         var _loc1_:MovieClip = new MovieClip();
         this.addChild(_loc1_);
         this.layer3 = _loc1_;
         var _loc2_:Class = main.swfLoader.getClass("assets.Mist");
         this.mist1 = new _loc2_();
         this.mist2 = new _loc2_();
         this.addChild(this.mist1);
         this.addChild(this.mist2);
         this.mist2.x = this.mist1.x + this.mist1.width - MIST_OVERLAP;
         _loc1_ = new MovieClip();
         addChild(_loc1_);
         this.layer2 = _loc1_;
         _loc1_ = new MovieClip();
         addChild(_loc1_);
         this.arena = _loc1_;
         _loc1_ = new MovieClip();
         addChild(_loc1_);
         this.layer1 = _loc1_;
         this.information = new MovieClip();
         addChild(this.information);
      }
      
      public function init(param1:DungeonConfigData) : void
      {
         this.backgrounds1 = new BackgroundSet(param1.backgroundsData[0]);
         this.backgrounds2 = new BackgroundSet(param1.backgroundsData[1]);
         this.backgrounds3 = new BackgroundSet(param1.backgroundsData[2]);
         this.setBackground(this.layer1,this.backgrounds1);
         this.setBackground(this.layer2,this.backgrounds2);
         this.setBackground(this.layer3,this.backgrounds3);
         this.finnFeedback.showIn(this.information);
         this.finnFeedback.x = 0;
         this.finnFeedback.y = 210;
         this.enemyFeedback.showIn(this.information);
         this.enemyFeedback.x = 700;
         this.enemyFeedback.y = 210;
         this.gameLoop.start();
      }
      
      private function setPauseButton() : void
      {
         var _loc1_:MovieClip = main.swfLoader.getObject("assets.ButtonPause") as MovieClip;
         this.information.addChild(_loc1_);
         this.information.pause = _loc1_;
         _loc1_.x = Dungeon.DungeonConfig["pause_btn_x"];
         _loc1_.y = Dungeon.DungeonConfig["pause_btn_y"];
      }
      
      public function addFinnFeddback(param1:MovieClip) : void
      {
         this.finnFeedback.addFeedback(param1);
      }
      
      public function addEnemyFeddback(param1:MovieClip) : void
      {
         this.enemyFeedback.addFeedback(param1);
         param1.scaleX = -1;
         param1.number_heathl_parts_blocked.title.scaleX = -1;
      }
      
      private function setBackground(param1:MovieClip, param2:BackgroundSet) : void
      {
         var _loc3_:MovieClip = null;
         _loc3_ = param2.getBackground();
         param1.addChild(_loc3_);
         param1["1"] = _loc3_;
         this.checkLayer(param1,param2);
      }
      
      private function checkLayer(param1:MovieClip, param2:BackgroundSet) : void
      {
         var _loc3_:MovieClip = null;
         if(param1["1"].x < -param1["1"].width)
         {
            param1.removeChild(param1["1"]);
            param1["1"] = param1["2"];
            param1["2"] = null;
         }
         if(param1["2"] == null && param1["1"].x + param1["1"].width <= 750)
         {
            _loc3_ = param2.getBackground();
            param1.addChild(_loc3_);
            param1["2"] = _loc3_;
            _loc3_.x = param1["1"].x + param1["1"].width - PIXEL_OVERLAP;
         }
      }
      
      public function clear() : void
      {
         this.finnFeedback.clear();
         this.finnFeedback = null;
         this.enemyFeedback.clear();
         this.enemyFeedback = null;
         this.finnHudView.clear();
         this.enemyHudView.clear();
         this.gameLoop.stop();
         this.onMove.clear();
         this.backgrounds1 = null;
         this.backgrounds2 = null;
         this.backgrounds3 = null;
      }
      
      public function beginScroll() : void
      {
         this.scrolling = true;
      }
      
      public function endScroll() : void
      {
         this.scrolling = false;
      }
      
      public function pauseScroll() : void
      {
         this.paused = true;
         this.finnFeedback.pause();
         this.enemyFeedback.pause();
         this.gameLoop.stop();
      }
      
      public function resumeScroll() : void
      {
         this.paused = false;
         this.finnFeedback.resume();
         this.enemyFeedback.resume();
         this.gameLoop.start();
      }
      
      private function scroll(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!this.paused)
         {
            _loc2_ = MIST_VELOCITY;
            this.scrollMist(_loc2_);
            if(this.scrolling)
            {
               _loc3_ = VELOCITY1;
               _loc4_ = ARENA_VELOCITY;
               _loc5_ = VELOCITY3;
               this.layer1["1"].x -= _loc3_;
               if(this.layer1["2"] != null)
               {
                  this.layer1["2"].x -= _loc3_;
               }
               this.layer2["1"].x -= _loc4_;
               if(this.layer2["2"] != null)
               {
                  this.layer2["2"].x -= _loc4_;
               }
               this.layer3["1"].x -= _loc5_;
               if(this.layer3["2"] != null)
               {
                  this.layer3["2"].x -= _loc5_;
               }
               this.checkLayer(this.layer1,this.backgrounds1);
               this.checkLayer(this.layer2,this.backgrounds2);
               this.checkLayer(this.layer3,this.backgrounds3);
               this.scrollMist(_loc4_);
               this.onMove.emit(_loc4_);
            }
         }
      }
      
      private function scrollMist(param1:Number) : void
      {
         this.mist1.x -= param1;
         this.mist2.x -= param1;
         if(this.mist1.x < -this.mist1.width)
         {
            this.mist1.x = this.mist2.x;
            this.mist2.x = this.mist1.x + this.mist1.width - PIXEL_OVERLAP;
         }
      }
   }
}

