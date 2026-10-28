package bonus.errors
{
   public class GenericError extends Error
   {
      
      public function GenericError(param1:String, param2:String, param3:int)
      {
         super(param1 + ":" + param3 + ": " + param2 + ".",1);
      }
   }
}

