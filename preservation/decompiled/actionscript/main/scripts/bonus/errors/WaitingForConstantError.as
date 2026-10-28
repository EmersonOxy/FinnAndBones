package bonus.errors
{
   public class WaitingForConstantError extends Error
   {
      
      public function WaitingForConstantError(param1:String, param2:String, param3:int)
      {
         super(param1 + ":" + param3 + ": Expected Constant. " + param2 + ".",1);
      }
   }
}

