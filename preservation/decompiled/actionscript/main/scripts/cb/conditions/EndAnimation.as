package cb.conditions
{
   import flash.display.MovieClip;
   
   public class EndAnimation implements Condition
   {
      
      public function EndAnimation()
      {
         super();
      }
      
      public function complete(param1:MovieClip) : Boolean
      {
         return param1.totalFrames == param1.currentFrame;
      }
   }
}

