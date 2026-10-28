package tutorial.steps
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tutorial.Tutorial;
   import view.screens.main_game.GameView;
   import view.screens.main_game.dungeon.WinWindow;
   
   public class TakeAllStep extends TutorialStep
   {
      
      private var listeningClick:Boolean;
      
      public function TakeAllStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
         this.listeningClick = false;
      }
      
      override public function enter() : void
      {
         WinWindow.onShow = this.wonDungeon;
      }
      
      private function get winWindow() : WinWindow
      {
         return (main.gameHolder.gameView as GameView).pauseHolder["window"];
      }
      
      private function wonDungeon() : void
      {
         this.winWindow.lootMcButton.addEventListener(MouseEvent.CLICK,this.loot);
         this.listeningClick = true;
         super.enter();
      }
      
      private function loot(param1:MouseEvent) : void
      {
         this.stopListening();
         theView.leave();
      }
      
      override public function leave() : void
      {
         WinWindow.onShow = null;
         this.stopListening();
         super.leave();
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.text.text.text = main.locale.get("tutorialTakeAll");
      }
      
      private function stopListening() : void
      {
         if(this.listeningClick)
         {
            this.winWindow.lootMcButton.removeEventListener(MouseEvent.CLICK,this.loot);
            this.listeningClick = false;
         }
      }
      
      override public function clear() : void
      {
         this.stopListening();
         WinWindow.onShow = null;
         super.clear();
      }
   }
}

