package view.screens.main_game
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import sound.GameSounds;
   import util.Util;
   import view.screens.AnimatedScreen;
   
   public class TransitionWindow extends AnimatedScreen
   {
      
      private var resources:Array;
      
      private var onFinish:Function;
      
      private var onStart:Function;
      
      public function TransitionWindow(param1:Array, param2:Function, param3:Function = null)
      {
         super(this.assetClass,new Dictionary(),"start","end");
         this.resources = param1;
         if(param3 == null)
         {
            param3 = Util.pass();
         }
         this.onFinish = param3;
         this.onStart = param2;
      }
      
      protected function get assetClass() : Class
      {
         return main.swfLoader.getClass("assets.loading");
      }
      
      public function start(param1:Sprite) : void
      {
         param1.addChild(this);
         enter(this.startWaiting);
         main.soundManager.playFx(GameSounds.TRANSITION_IN);
      }
      
      private function startWaiting() : void
      {
         this.onStart();
         bg.gotoAndPlay("idle");
         main.theLoader.onLoad.add(this.waitingForResources);
         this.waitingForResources();
      }
      
      private function waitingForResources() : void
      {
         if(!Util.areLoaded(this.resources,main.theLoader))
         {
            return;
         }
         main.theLoader.onLoad.remove(this.waitingForResources);
         this.onFinish();
         this.leave();
      }
      
      override public function leave(param1:Function = null) : void
      {
         var end:Function = param1;
         main.soundManager.playFx(GameSounds.TRANSITION_OUT);
         super.leave(function():void
         {
            if(end != null)
            {
               end();
            }
            pop();
         });
      }
      
      override public function clear() : void
      {
         this.onStart = null;
         this.onFinish = null;
         this.resources = null;
      }
   }
}

