package tutorial.view
{
   import cb.signals.Signal;
   import flash.utils.Dictionary;
   import view.screens.AnimatedScreen;
   
   public class TutorialView extends AnimatedScreen
   {
      
      public var onEnd:Signal;
      
      public function TutorialView(param1:Class)
      {
         super(param1,this.getButtonInfo(),"start","end");
         this.onEnd = new Signal();
      }
      
      protected function getButtonInfo() : Dictionary
      {
         return new Dictionary();
      }
      
      override public function leave(param1:Function = null) : void
      {
         var end:Function = param1;
         super.leave(function():void
         {
            if(end != null)
            {
               end();
            }
            onEnd.emit();
            pop();
         });
      }
   }
}

