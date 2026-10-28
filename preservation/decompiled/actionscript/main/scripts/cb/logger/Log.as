package cb.logger
{
   import flash.utils.Dictionary;
   
   public class Log
   {
      
      private static var loggers:Dictionary = new Dictionary();
      
      private var appenders:Array;
      
      private var name:String;
      
      public function Log(param1:String)
      {
         super();
         this.appenders = [];
         this.name = param1;
      }
      
      public static function getLogger(param1:String) : Log
      {
         if(loggers[param1] == undefined)
         {
            loggers[param1] = new Log(param1);
         }
         return loggers[param1];
      }
      
      public function addAppender(param1:Appender) : void
      {
         this.appenders.push(param1);
      }
      
      public function log(... rest) : void
      {
         var _loc2_:Appender = null;
         for each(_loc2_ in this.appenders)
         {
            _loc2_.log("[" + this.name + "] " + rest.join(""));
         }
      }
   }
}

