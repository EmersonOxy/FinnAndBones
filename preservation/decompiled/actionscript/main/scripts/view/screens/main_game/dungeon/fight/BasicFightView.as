package view.screens.main_game.dungeon.fight
{
   import cb.actions.Functor;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import main_game.character.Enemy;
   import main_game.character.Fighter;
   import main_game.dungeon.Damage;
   import main_game.dungeon.IFight;
   import util.Util;
   import view.figthers.FighterView;
   import view.screens.main_game.dungeon.BackgroundView;
   import view.screens.main_game.dungeon.InnerDungeonView;
   
   public class BasicFightView implements InnerDungeonView
   {
      
      protected var bg:BackgroundView;
      
      protected var fight:IFight;
      
      protected var enemy:Enemy;
      
      protected var views:Dictionary;
      
      protected var timer:Timer;
      
      public function BasicFightView(param1:IFight, param2:BackgroundView, ... rest)
      {
         super();
         this.fight = param1;
         this.bg = param2;
         this.views = new Dictionary();
         this.initializeViews(rest);
         this.initialize();
      }
      
      protected function getFightConfig() : Object
      {
         return main.config.get("FightConfig");
      }
      
      protected function initializeViews(param1:Array) : void
      {
         throw new Error("Must implement");
      }
      
      protected function initialize() : void
      {
         this.fight.onHit.add(this.onHit);
         this.fight.onEnter.add(this.enter);
         this.fight.onExit.add(this.leave);
         this.fight.onWin.add(this.won);
         this.fight.onLose.add(this.lose);
      }
      
      protected function won() : void
      {
         throw new Error("Must implement");
      }
      
      protected function lose() : void
      {
         throw new Error("Must implement");
      }
      
      protected function countdown(param1:Function) : void
      {
         var next:Function = param1;
         this.bg.enemyHud.changeFighter(this.enemy);
         this.timer = new Timer(100,this.getFightConfig().countdown * 10);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:TimerEvent):void
         {
            removeTimer();
            next();
         });
         this.timer.start();
      }
      
      protected function enter(param1:Function) : void
      {
         this.countdown(param1);
      }
      
      protected function leave(param1:Function) : void
      {
         this.bg.enemyHud.changeFighter(null);
         param1();
      }
      
      protected function onHit(param1:Fighter, param2:Fighter, param3:Damage, param4:Function) : void
      {
         var hitter:Fighter = param1;
         var reciver:Fighter = param2;
         var damage:Damage = param3;
         var atEnd:Function = param4;
         this.timer = new Timer(100,this.getFightConfig().cooldown * 10);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:TimerEvent):void
         {
            removeTimer();
            views[hitter].onHit(views[reciver],damage,atEnd,Util.l(showFeedback,hitter,reciver,damage));
         });
         this.timer.start();
      }
      
      private function showFeedback(param1:Fighter, param2:Fighter, param3:Damage) : void
      {
         var hitterView:FighterView;
         var finnFeedbacks:Array = null;
         var enemyFeedbacks:Array = null;
         var number:MovieClip = null;
         var smart_mc:SmartMC = null;
         var fFeedback:MovieClip = null;
         var eFeedback:MovieClip = null;
         var hitter:Fighter = param1;
         var reciver:Fighter = param2;
         var damage:Damage = param3;
         number = main.swfLoader.getObject("assets.numberHealth2") as MovieClip;
         number.container.title.title.text = damage.stringValue();
         hitterView = this.views[reciver] as FighterView;
         number.x = hitterView.x;
         number.y = hitterView.y;
         if(hitter.isFinn())
         {
            number.scaleX = -1;
            number.container.title.scaleX = -1;
            finnFeedbacks = damage.getHitterFeedback();
            enemyFeedbacks = damage.getDefenderFeedback();
         }
         else
         {
            number.x -= 50;
            enemyFeedbacks = damage.getHitterFeedback();
            finnFeedbacks = damage.getDefenderFeedback();
         }
         number.gotoAndPlay(1);
         this.bg.arena.addChild(number);
         smart_mc = new SmartMC(number);
         smart_mc.trigger(new EndAnimation(),Functor.wrap(function():void
         {
            smart_mc.clear();
            number.stop();
            number.parent.removeChild(number);
         }));
         for each(fFeedback in finnFeedbacks)
         {
            this.bg.addFinnFeddback(fFeedback);
         }
         for each(eFeedback in enemyFeedbacks)
         {
            this.bg.addEnemyFeddback(eFeedback);
         }
      }
      
      protected function removeTimer() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
         }
         this.timer = null;
      }
      
      public function pause() : void
      {
         var _loc1_:FighterView = null;
         if(this.timer != null)
         {
            this.timer.stop();
         }
         this.bg.pauseScroll();
         for each(_loc1_ in this.views)
         {
            _loc1_.pause();
         }
      }
      
      public function resume() : void
      {
         var _loc1_:FighterView = null;
         if(this.timer != null)
         {
            this.timer.start();
         }
         this.bg.resumeScroll();
         for each(_loc1_ in this.views)
         {
            _loc1_.resume();
         }
      }
      
      public function clear() : void
      {
         this.removeTimer();
         this.bg = null;
         this.views = null;
         this.enemy = null;
      }
   }
}

