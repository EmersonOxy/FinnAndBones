package util
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import loader.DynamicLoader;
   
   public class Util
   {
      
      public function Util()
      {
         super();
      }
      
      public static function l(param1:Function, ... rest) : Function
      {
         var func:Function = param1;
         var params:Array = rest;
         return function(... rest):*
         {
            return func.apply(null,rest.concat(params));
         };
      }
      
      public static function concatenate(param1:Function, param2:Function) : Function
      {
         var func1:Function = param1;
         var func2:Function = param2;
         return function(... rest):*
         {
            func1.apply(null,rest);
            func2();
         };
      }
      
      public static function removeParams(param1:Function) : Function
      {
         var func:Function = param1;
         return function(... rest):*
         {
            return func();
         };
      }
      
      public static function bringToFront(param1:Sprite) : void
      {
         if(param1.parent != null)
         {
            param1.parent.setChildIndex(param1,param1.parent.numChildren - 1);
         }
      }
      
      public static function parseArray(param1:String, param2:String = null) : Array
      {
         param2 ||= ";";
         return param1.split(param2);
      }
      
      public static function pass() : Function
      {
         return function(... rest):void
         {
         };
      }
      
      public static function areLoaded(param1:Array, param2:DynamicLoader) : Boolean
      {
         var _loc3_:String = null;
         for each(_loc3_ in param1)
         {
            if(!param2.isLoaded(_loc3_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function toStringDay(param1:uint) : String
      {
         switch(param1)
         {
            case 1:
               return "Monday";
            case 2:
               return "Tuesday";
            case 3:
               return "Wednesday";
            case 4:
               return "Thursday";
            case 5:
               return "Friday";
            case 6:
               return "Saturday";
            case 0:
               return "Sunday";
            default:
               throw new Error("The week has only 7 days!");
         }
      }
      
      public static function recursiveStop(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         recursiveApply(mc,function(param1:MovieClip):void
         {
            param1.stop();
         });
      }
      
      public static function recursivePlay(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         recursiveApply(mc,function(param1:MovieClip):void
         {
            param1.play();
         });
      }
      
      private static function recursiveApply(param1:MovieClip, param2:Function) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:* = int(param1.numChildren - 1);
         while(_loc3_ >= 0)
         {
            _loc4_ = param1.getChildAt(_loc3_) as MovieClip;
            if(_loc4_)
            {
               recursiveApply(_loc4_,param2);
            }
            _loc3_--;
         }
         param2(param1);
      }
      
      public static function sameDate(param1:Date, param2:Date) : Boolean
      {
         return param1.getUTCFullYear() == param2.getUTCFullYear() && param1.getUTCMonth() == param2.getUTCMonth() && param1.getUTCDate() == param2.getUTCDate() && (param1.getUTCHours() < param2.getUTCHours() || param1.getUTCHours() == param2.getUTCHours() && param1.getUTCMinutes() <= param2.getUTCMinutes());
      }
      
      public static function getSprite(param1:Sprite, param2:String) : Sprite
      {
         var _loc5_:String = null;
         var _loc3_:Array = param2.split(".");
         var _loc4_:Sprite = param1;
         for each(_loc5_ in _loc3_)
         {
            _loc4_ = _loc4_[_loc5_];
         }
         return _loc4_;
      }
      
      public static function addMouseEvents(param1:Sprite, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         if(param2 != null)
         {
            param1.addEventListener(MouseEvent.CLICK,param2);
         }
         if(param3 != null)
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,param3);
         }
         if(param4 != null)
         {
            param1.addEventListener(MouseEvent.MOUSE_OUT,param4);
         }
      }
      
      public static function removeMouseEvents(param1:Sprite, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         if(param2 != null)
         {
            param1.removeEventListener(MouseEvent.CLICK,param2);
         }
         if(param3 != null)
         {
            param1.removeEventListener(MouseEvent.MOUSE_OVER,param3);
         }
         if(param4 != null)
         {
            param1.removeEventListener(MouseEvent.MOUSE_OUT,param4);
         }
      }
   }
}

