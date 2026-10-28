package conditions
{
   import cb.conditions.AnimationFrameAt;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   
   public class EndCurrentLabel extends AnimationFrameAt
   {
      
      public function EndCurrentLabel(param1:MovieClip)
      {
         var _loc5_:FrameLabel = null;
         var _loc6_:int = 0;
         var _loc2_:String = param1.currentLabel;
         var _loc3_:int = param1.currentFrame;
         var _loc4_:int = param1.totalFrames + 1;
         for each(_loc5_ in param1.currentLabels)
         {
            _loc6_ = _loc5_.frame;
            if(_loc6_ < _loc4_ && _loc6_ > param1.currentFrame)
            {
               _loc4_ = _loc6_;
            }
         }
         super(_loc4_ - 1);
      }
   }
}

