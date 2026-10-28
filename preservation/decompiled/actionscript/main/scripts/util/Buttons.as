package util
{
   import cb.logger.Log;
   import flash.display.Sprite;
   
   public class Buttons
   {
      
      public function Buttons()
      {
         super();
      }
      
      public static function setButtons(param1:Sprite, param2:Array, param3:Boolean) : void
      {
         var b:String = null;
         var doc:Sprite = null;
         var container:Sprite = param1;
         var buttons:Array = param2;
         var on:Boolean = param3;
         for each(b in buttons)
         {
            try
            {
               doc = Util.getSprite(container,b);
               doc.buttonMode = on;
               doc.mouseEnabled = on;
            }
            catch(e:Error)
            {
               Log.getLogger("debug").log(e.getStackTrace());
            }
         }
      }
   }
}

