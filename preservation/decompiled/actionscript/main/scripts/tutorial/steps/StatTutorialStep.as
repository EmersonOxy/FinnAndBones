package tutorial.steps
{
   import flash.display.MovieClip;
   import tutorial.Tutorial;
   import tutorial.view.TutorialView;
   import tutorial.view.TutorialViewWithOk;
   
   public class StatTutorialStep extends TutorialStep
   {
      
      public function StatTutorialStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
      }
      
      override public function enter() : void
      {
         super.enter();
      }
      
      override protected function createView(param1:String) : TutorialView
      {
         return new TutorialViewWithOk(main.swfLoader.getClass(param1));
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.title.title.text = main.locale.get("tutorialStats");
         param1.text1.text.text = main.locale.get("tutorialStatsHealth");
         param1.text2.text.text = main.locale.get("tutorialStatsAttack");
         param1.text3.text.text = main.locale.get("tutorialStatsDefense");
         param1.text4.text.text = main.locale.get("tutorialStatsLuck");
      }
      
      override public function leave() : void
      {
         super.leave();
         main.game.getBubblegum().selfAdvertise();
      }
   }
}

