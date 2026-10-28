package cb.data
{
   import flash.events.MouseEvent;
   
   public class ButtonInfo
   {
      
      private var _click:Function;
      
      private var _over:Function;
      
      private var _out:Function;
      
      private var hitBox:String;
      
      public function ButtonInfo(param1:Function, param2:* = null, param3:* = null, param4:Boolean = true, param5:String = null)
      {
         super();
         this._click = param1;
         if(param2 is String)
         {
            this._over = defaultGoto(param2,param4,param5);
         }
         else
         {
            this._over = param2;
         }
         if(param3 is String)
         {
            this._out = defaultGoto(param3,param4,param5);
         }
         else
         {
            this._out = param3;
         }
         this.hitBox = param5;
      }
      
      public static function defaultGoto(param1:String, param2:Boolean = false, param3:String = null) : Function
      {
         var label:String = param1;
         var playAsDefault:Boolean = param2;
         var hitBox:String = param3;
         return function(param1:MouseEvent):void
         {
            param1.stopPropagation();
            var _loc2_:* = param1.currentTarget;
            if(hitBox)
            {
               _loc2_ = param1.currentTarget.parent;
            }
            if(playAsDefault)
            {
               _loc2_.gotoAndPlay(label);
            }
            else
            {
               _loc2_.gotoAndStop(label);
            }
         };
      }
      
      public function getHitBox() : String
      {
         return this.hitBox;
      }
      
      public function get click() : Function
      {
         return this._click;
      }
      
      public function get over() : Function
      {
         return this._over;
      }
      
      public function get out() : Function
      {
         return this._out;
      }
   }
}

