package tutorial
{
   import aplication.BasicState;
   import aplication.FSM;
   import aplication.State;
   import tutorial.steps.ConsumePotionStep;
   import tutorial.steps.FirstTutorialStep;
   import tutorial.steps.MixInformationStep;
   import tutorial.steps.MixTutorialStep;
   import tutorial.steps.StatTutorialStep;
   import tutorial.steps.TakeAllStep;
   import view.screens.main_game.inventory.MixerView;
   
   public class Tutorial
   {
      
      private static const NEXT:String = "next";
      
      private var fsm:FSM;
      
      private var mixKnown:Boolean;
      
      public function Tutorial()
      {
         super();
         this.initializeFSM();
         this.fsm.addTransition("init",(main.saveSystem.tutorialStepCompleted() + 1).toString(),NEXT);
         this.fsm.start();
      }
      
      private function initializeFSM() : void
      {
         var _loc1_:State = new BasicState("init",null,this.startTutorial);
         this.fsm = new FSM(_loc1_);
         _loc1_ = new FirstTutorialStep(1,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new StatTutorialStep(2,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new ConsumePotionStep(3,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new TakeAllStep(4,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new MixInformationStep(5,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new MixTutorialStep(6,this);
         this.fsm.addState(_loc1_);
         _loc1_ = new BasicState("7",this.endTutorial);
         this.fsm.addState(_loc1_);
         this.fsm.addTransition("1","2",NEXT);
         this.fsm.addTransition("2","3",NEXT);
         this.fsm.addTransition("3","4",NEXT);
         this.fsm.addTransition("4","5",NEXT);
         this.fsm.addTransition("5","6",NEXT);
         this.fsm.addTransition("6","7",NEXT);
      }
      
      private function startTutorial() : void
      {
         this.mixKnown = false;
         var _loc1_:int = int(main.saveSystem.tutorialStepCompleted());
         if(_loc1_ < 3)
         {
            this.lockPotions();
         }
         if(_loc1_ < 5)
         {
            this.disableMix();
         }
         if(_loc1_ < 6)
         {
            this.lockTrash();
         }
      }
      
      public function isMixKnown() : Boolean
      {
         return this.mixKnown;
      }
      
      private function lockTrash() : void
      {
         main.game.getInventory().getTrash().lock();
      }
      
      public function unlockTrash() : void
      {
         main.game.getInventory().getTrash().unlock();
      }
      
      private function get mixerView() : MixerView
      {
         return main.gameHolder.gameView.mixing;
      }
      
      public function enableMix() : void
      {
         this.mixKnown = true;
         this.mixerView.enable();
      }
      
      private function disableMix() : void
      {
         this.mixerView.disable();
      }
      
      private function lockPotions() : void
      {
         main.game.getFinn().liver.onLock.add(this.lockLiver);
         this.lockLiver();
      }
      
      private function lockLiver(param1:Boolean = false) : void
      {
         if(!param1)
         {
            main.game.getFinn().liver.lock();
         }
      }
      
      public function unlockPotions() : void
      {
         main.game.getFinn().liver.onLock.remove(this.lockLiver);
         main.game.getFinn().liver.unlock();
      }
      
      public function next() : void
      {
         this.fsm.takeTransition(NEXT);
      }
      
      private function endTutorial() : void
      {
         this.unlockTrash();
         this.enableMix();
         main.game.getBubblegum().getLocker().unlock();
      }
      
      public function clear() : void
      {
         this.fsm.clear();
      }
   }
}

