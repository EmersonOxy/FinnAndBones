package cb.utils
{
   import cb.gameloop.GameLoop;
   import flash.display.*;
   
   public class Tween
   {
      
      private static var tweens:Vector.<Properties>;
      
      private static var loop:GameLoop;
      
      public function Tween()
      {
         super();
      }
      
      public static function killTweensOf(param1:Object) : Boolean
      {
         var target:Object = param1;
         var tweenKilled:Boolean = false;
         forEachTweenOf(target,function(param1:Properties):void
         {
            tweenKilled = true;
            tweens.splice(tweens.indexOf(param1),1);
         });
         return tweenKilled;
      }
      
      public static function isTweening(param1:Object) : Boolean
      {
         var tweenPlaying:Boolean = false;
         var target:Object = param1;
         tweenPlaying = false;
         forEachTweenOf(target,function(param1:Properties):void
         {
            tweenPlaying = tweenPlaying || param1.target == target;
         });
         return tweenPlaying;
      }
      
      public static function to(param1:Object, param2:Number, param3:Object, param4:Function = null, param5:Function = null) : void
      {
         var _loc6_:Properties = null;
         var _loc7_:String = null;
         if(!param1 || !param3)
         {
            return;
         }
         initialize();
         _loc6_ = new Properties(param1,param2,param4,param5);
         for(_loc7_ in param3)
         {
            _loc6_.propsMap[_loc7_] = new Value(param1[_loc7_],param3[_loc7_]);
         }
         tweens.push(_loc6_);
      }
      
      public static function destroy() : void
      {
         loop.stop();
         loop = null;
         tweens = null;
      }
      
      private static function initialize() : void
      {
         if(loop)
         {
            return;
         }
         tweens = new Vector.<Properties>();
         loop = new GameLoop(new Sprite());
         loop.updated.add(update);
         loop.start();
      }
      
      private static function update(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:Properties = null;
         var _loc7_:Properties = null;
         var _loc4_:Array = [];
         var _loc5_:Vector.<Properties> = tweens.concat();
         for each(_loc6_ in _loc5_)
         {
            if(!updateTween(_loc6_,param1))
            {
               _loc4_.push(_loc6_);
            }
         }
         for each(_loc7_ in _loc4_)
         {
            tweens.splice(tweens.indexOf(_loc7_),1);
         }
         if(!tweens.length)
         {
            destroy();
         }
      }
      
      private static function updateTween(param1:Properties, param2:uint) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Value = null;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         if(!param1 || !param1.target)
         {
            return false;
         }
         param1.elapsedTime += param2;
         _loc6_ = param1.elapsedTime > param1.time;
         for(_loc3_ in param1.propsMap)
         {
            _loc4_ = param1.propsMap[_loc3_] as Value;
            _loc5_ = param1.target;
            if(_loc6_)
            {
               _loc5_[_loc3_] = _loc4_.to;
            }
            else
            {
               _loc5_[_loc3_] = linear(param1.elapsedTime,_loc4_.from,_loc4_.change,param1.time);
            }
         }
         if(_loc6_)
         {
            param1.callback && param1.callback();
         }
         else
         {
            param1.update && param1.update();
         }
         return !_loc6_;
      }
      
      private static function forEachTweenOf(param1:Object, param2:Function) : void
      {
         var _loc3_:Properties = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<Properties> = null;
         if(!tweens)
         {
            return;
         }
         _loc6_ = new Vector.<Properties>().concat(tweens);
         _loc4_ = 0;
         _loc5_ = _loc6_.length;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = _loc6_[_loc4_];
            if(Boolean(_loc3_) && _loc3_.target == param1)
            {
               param2 && param2(_loc3_);
            }
            _loc4_++;
         }
      }
      
      private static function linear(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * param1 / param4 + param2;
      }
   }
}

import flash.utils.Dictionary;

class Properties
{
   
   public var target:Object;
   
   public var time:uint;
   
   public var callback:Function;
   
   public var update:Function;
   
   public var propsMap:Dictionary;
   
   public var elapsedTime:uint;
   
   public function Properties(param1:Object, param2:uint, param3:Function = null, param4:Function = null)
   {
      super();
      this.target = param1;
      this.time = param2;
      this.callback = param3;
      this.update = param4;
      this.propsMap = new Dictionary();
      this.elapsedTime = 0;
   }
}

class Value
{
   
   public var from:Number;
   
   public var to:Number;
   
   public var change:Number;
   
   public function Value(param1:Number, param2:Number)
   {
      super();
      this.from = param1;
      this.to = param2;
      this.change = param2 - param1;
   }
}
