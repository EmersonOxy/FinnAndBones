package tutorial.steps
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.character.stats.StatType;
   import tutorial.Tutorial;
   import view.screens.main_game.GameView;
   import view.screens.main_game.dungeon.DungeonView;
   
   public class ConsumePotionStep extends TutorialStep
   {
      
      private var initialHealth:Number;
      
      private var timer:Timer;
      
      private var started:Boolean;
      
      public function ConsumePotionStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
         this.started = false;
      }
      
      override public function enter() : void
      {
         main.game.getFinn().stats.onChange.add(this.statsChange);
         this.initialHealth = main.game.getFinn().stats.getStat(StatType.HEALTH).getValue();
      }
      
      private function statsChange() : void
      {
         var _loc1_:Number = main.game.getFinn().stats.getStat(StatType.HEALTH).getValue();
         if(this.initialHealth > _loc1_ && _loc1_ > 0 && this.timer == null)
         {
            this.started = true;
            this.timer = new Timer(500,1);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.triggerTutorial);
            this.timer.start();
         }
         else if(this.started && this.initialHealth < _loc1_)
         {
            this.removeTimer();
            theView.leave();
         }
      }
      
      private function triggerTutorial(param1:TimerEvent) : void
      {
         this.tut.unlockPotions();
         this.removeTimer();
         this.initialHealth = main.game.getFinn().stats.getStat(StatType.HEALTH).getValue();
         this.stopFight();
         super.enter();
      }
      
      private function removeTimer() : void
      {
         if(this.timer == null)
         {
            return;
         }
         this.timer.stop();
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.triggerTutorial);
         this.timer = null;
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.title.title.text = main.locale.get("tutorialConsumablesTitle");
         param1.text.text.text = main.locale.get("tutorialConsumables");
      }
      
      private function get arena() : MovieClip
      {
         return ((main.gameHolder.gameView as GameView).up_holder.game.dungeonView as DungeonView).background.arena;
      }
      
      private function stopFight() : void
      {
         this.arena.finn.stop();
         this.arena.enemy.enemy.stop();
      }
      
      private function resumeFight() : void
      {
         this.arena.finn.play();
         this.arena.enemy.enemy.play();
      }
      
      override public function leave() : void
      {
         main.game.getFinn().stats.onChange.remove(this.statsChange);
         this.resumeFight();
         this.removeTimer();
         super.leave();
      }
      
      override public function clear() : void
      {
         super.clear();
         this.removeTimer();
         main.game.getFinn().stats.onChange.remove(this.statsChange);
      }
   }
}

