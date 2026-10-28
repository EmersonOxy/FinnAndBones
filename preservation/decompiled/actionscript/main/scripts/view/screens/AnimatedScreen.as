package view.screens
{
   import cb.actions.Functor;
   import cb.display.Screen;
   import cb.display.SmartMC;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class AnimatedScreen extends Screen
   {
      
      private var enterLabel:String;
      
      private var leaveLabel:String;
      
      public function AnimatedScreen(param1:Class, param2:Dictionary, param3:String = "in", param4:String = "out")
      {
         super(param1,param2);
         this.enterLabel = param3;
         this.leaveLabel = param4;
      }
      
      public function enter(param1:Function = null) : void
      {
         bg.gotoAndPlay(this.enterLabel);
         this.callOnEnd(bg,param1);
      }
      
      public function leave(param1:Function = null) : void
      {
         bg.gotoAndPlay(this.leaveLabel);
         this.callOnEnd(bg,param1);
      }
      
      private function callOnEnd(param1:MovieClip, param2:Function = null) : void
      {
         var smc:SmartMC = null;
         var mc:MovieClip = param1;
         var fc:Function = param2;
         if(fc != null)
         {
            smc = new SmartMC(mc);
            smc.trigger(new EndCurrentLabel(mc),Functor.wrap(function():void
            {
               bg.stop();
               fc();
               smc.clear();
            }));
         }
      }
   }
}

