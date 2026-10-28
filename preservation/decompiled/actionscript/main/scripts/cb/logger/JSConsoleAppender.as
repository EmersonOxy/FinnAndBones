package cb.logger
{
   import flash.external.ExternalInterface;
   
   public class JSConsoleAppender extends Appender
   {
      
      public function JSConsoleAppender()
      {
         super();
      }
      
      override public function log(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("console.log",param1);
         }
      }
   }
}

