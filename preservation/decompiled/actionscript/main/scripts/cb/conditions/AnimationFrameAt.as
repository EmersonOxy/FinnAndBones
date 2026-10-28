package cb.conditions
{
   import flash.display.MovieClip;
   
   public class AnimationFrameAt implements Condition
   {
      
      private var condFrame:int;
      
      public function AnimationFrameAt(param1:int)
      {
         super();
         this.condFrame = param1;
      }
      
      public function complete(param1:MovieClip) : Boolean
      {
         return param1.currentFrame == this.condFrame;
      }
   }
}

