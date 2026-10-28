package tutorial.steps
{
   import aplication.BasicState;
   import flash.display.MovieClip;
   import tutorial.Tutorial;
   import tutorial.view.TutorialView;
   
   public class TutorialStep extends BasicState
   {
      
      private var step:uint;
      
      protected var tut:Tutorial;
      
      protected var theView:TutorialView;
      
      public function TutorialStep(param1:String, param2:Tutorial, param3:uint, param4:String)
      {
         this.step = param3;
         this.tut = param2;
         this.theView = this.createView(param4);
         this.theView.onEnd.add(this.endStep);
         super(param1);
      }
      
      override public function enter() : void
      {
         this.showView();
         super.enter();
      }
      
      protected function createView(param1:String) : TutorialView
      {
         return new TutorialView(main.swfLoader.getClass(param1));
      }
      
      protected function showView() : void
      {
         main.game.getBubblegum().getLocker().lock();
         main.tutorialHolder.addChild(this.theView);
         this.theView.enter();
         this.setText(this.theView.getBg());
      }
      
      protected function setText(param1:MovieClip) : void
      {
      }
      
      protected function endStep() : void
      {
         this.tut.next();
      }
      
      override public function leave() : void
      {
         main.game.getBubblegum().getLocker().unlock();
         main.saveSystem.onTutorialComplete(this.step);
      }
      
      override public function clear() : void
      {
         super.clear();
         this.theView.clear();
         this.tut = null;
         this.theView = null;
      }
   }
}

