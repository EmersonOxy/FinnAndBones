package view.screens.main_game.bubblegum
{
   import cb.actions.Functor;
   import cb.display.SmartMC;
   import cb.utils.Random;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import main_game.bubblegum.BubbleGumTip;
   import main_game.bubblegum.BubblegumFeeling;
   import main_game.bubblegum.BubblegumInteraction;
   import main_game.bubblegum.InteractiveBubblegum;
   import util.Locker;
   import util.Util;
   
   public class BubblegumView implements InteractiveBubblegum
   {
      
      private var bg:MovieClip;
      
      private var popUp:BubblegumPopUp;
      
      private var timer:Timer;
      
      private var tips:Array;
      
      public function BubblegumView()
      {
         super();
         main.game.getBubblegum().onInteraction.add(this.interact);
         main.game.getBubblegum().getLocker().onLock.add(this.changeInLock);
         this.popUp = new BubblegumPopUp();
         this.popUp.onCancel.add(this.hideTip);
         this.tips = new Array();
         this.timer = new Timer(2000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.hideTip);
      }
      
      public function initialize(param1:MovieClip) : void
      {
         this.bg = param1;
         this.popUp.addIn(main.tutorialHolder);
         param1.gotoAndPlay("idleFront");
         Util.addMouseEvents(this.hitbox,this.click);
         this.changeInLock(main.game.getBubblegum().getLocker());
      }
      
      private function get hitbox() : Sprite
      {
         return this.bg.hitbox;
      }
      
      private function changeInLock(param1:Locker) : void
      {
         if(param1.isLocked)
         {
            if(this.tips.length != 0)
            {
               this.hideTip();
            }
            this.hitbox.buttonMode = false;
         }
         else
         {
            this.hitbox.buttonMode = true;
         }
      }
      
      private function click(param1:MouseEvent) : void
      {
         if(this.tips.length != 0)
         {
            this.hideTip();
         }
         if(this.tips.length == 0)
         {
            main.game.getBubblegum().giveSomeTip();
         }
      }
      
      private function interact(param1:BubblegumInteraction) : void
      {
         param1.make(this);
      }
      
      public function expressFeeling(param1:BubblegumFeeling, param2:Function = null) : void
      {
         this.bg.gotoAndPlay(param1.feeling);
         if(param2 != null)
         {
            new SmartMC(this.bg).trigger(new EndCurrentLabel(this.bg),Functor.wrap(param2));
         }
      }
      
      public function sayTip(param1:BubbleGumTip) : void
      {
         if(this.tips.length == 0)
         {
            this.tips.push(param1);
            this.showTipNow();
         }
      }
      
      private function showTipNow() : void
      {
         if(this.tips.length == 0)
         {
            return;
         }
         var _loc1_:BubbleGumTip = this.tips[0];
         this.popUp.refreshTip(_loc1_);
         this.popUp.show();
         this.bg.gotoAndPlay("talk_" + Random.nextRange(1,2));
         this.timer.delay = _loc1_.getTime();
         this.timer.start();
      }
      
      private function hideTip(... rest) : void
      {
         this.timer.reset();
         this.tips.shift();
         this.popUp.hide(this.showTipNow);
      }
      
      public function clear() : void
      {
         main.game.getBubblegum().onInteraction.remove(this.interact);
         main.game.getBubblegum().getLocker().onLock.remove(this.changeInLock);
         Util.removeMouseEvents(this.bg,this.click);
         this.bg.stop();
         this.bg = null;
         this.popUp.clear();
         this.popUp = null;
         this.timer.stop();
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.hideTip);
         this.timer = null;
      }
   }
}

