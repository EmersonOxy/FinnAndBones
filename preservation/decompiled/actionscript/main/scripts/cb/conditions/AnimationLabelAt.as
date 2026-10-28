package cb.conditions
{
   import flash.display.MovieClip;
   
   public class AnimationLabelAt implements Condition
   {
      
      private var condLabel:String;
      
      public function AnimationLabelAt(param1:String)
      {
         super();
         this.condLabel = param1;
      }
      
      public function complete(param1:MovieClip) : Boolean
      {
         return param1.currentLabel == this.condLabel;
      }
   }
}

