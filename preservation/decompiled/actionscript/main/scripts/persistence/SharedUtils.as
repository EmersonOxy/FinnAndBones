package persistence
{
   import cb.logger.Appender;
   import cb.logger.JSConsoleAppender;
   import cb.logger.Log;
   import flash.net.SharedObject;
   import flash.utils.getQualifiedClassName;
   
   public class SharedUtils
   {
      
      private static const logger:Log = Log.getLogger(getQualifiedClassName(SharedUtils));
      
      logger.addAppender(new Appender());
      logger.addAppender(new JSConsoleAppender());
      
      public function SharedUtils()
      {
         super();
      }
      
      public static function load(param1:String, param2:String) : *
      {
         var so:SharedObject = null;
         var cookie:String = param1;
         var property:String = param2;
         try
         {
            so = SharedObject.getLocal(cookie);
            return so.data[property];
         }
         catch(e:Error)
         {
            logger.log(e.toString());
         }
         return null;
      }
      
      public static function saveBulk(param1:String, param2:Object) : Boolean
      {
         var so:SharedObject = null;
         var save:Boolean = false;
         var property:String = null;
         var value:* = undefined;
         var cookie:String = param1;
         var toSave:Object = param2;
         try
         {
            so = SharedObject.getLocal(cookie);
            save = false;
            for(property in toSave)
            {
               save = true;
               value = toSave[property];
               so.data[property] = value;
            }
            if(save)
            {
               so.flush();
            }
            return true;
         }
         catch(e:Error)
         {
            logger.log(e.toString());
         }
         return false;
      }
      
      public static function save(param1:String, param2:String, param3:*) : Boolean
      {
         var so:SharedObject = null;
         var cookie:String = param1;
         var property:String = param2;
         var value:* = param3;
         try
         {
            so = SharedObject.getLocal(cookie);
            so.data[property] = value;
            so.flush();
            return true;
         }
         catch(e:Error)
         {
            logger.log(e.toString());
         }
         return false;
      }
      
      public static function clear(param1:String) : Boolean
      {
         var so:SharedObject = null;
         var cookie:String = param1;
         try
         {
            so = SharedObject.getLocal(cookie);
            so.clear();
            return true;
         }
         catch(e:Error)
         {
            logger.log(e.toString());
         }
         return false;
      }
   }
}

