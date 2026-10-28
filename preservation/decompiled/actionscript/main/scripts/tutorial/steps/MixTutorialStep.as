package tutorial.steps
{
   import flash.display.MovieClip;
   import tutorial.Tutorial;
   import tutorial.view.TutorialView;
   import tutorial.view.TutorialViewWithOk;
   
   public class MixTutorialStep extends TutorialStep
   {
      
      public function MixTutorialStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
      }
      
      override protected function createView(param1:String) : TutorialView
      {
         return new TutorialViewWithOk(main.swfLoader.getClass(param1));
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.title.title.text = main.locale.get("tutorialMixTitle");
         param1.text.text.text = main.locale.get("tutorialMix");
      }
      
      override public function enter() : void
      {
         super.enter();
         theView.getBg().removeChild(theView.getBg().glow);
         main.game.getMixer().onMixStart.add(theView.leave);
      }
      
      override public function leave() : void
      {
         main.game.getMixer().onMixStart.remove(theView.leave);
         super.leave();
      }
      
      override public function clear() : void
      {
         main.game.getMixer().onMixStart.remove(theView.leave);
      }
   }
}

