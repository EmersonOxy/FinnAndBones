package view.popUp
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class PopUpPositioner
   {
      
      private var src:DisplayObjectContainer;
      
      private var dst:DisplayObjectContainer;
      
      public function PopUpPositioner(param1:DisplayObjectContainer, param2:DisplayObjectContainer = null)
      {
         super();
         this.src = param1;
         if(param2 == null)
         {
            param2 = main.popUpHolder;
         }
         this.dst = param2;
      }
      
      public function addMc(param1:Sprite) : void
      {
         this.dst.addChild(param1);
      }
      
      public function refreshPos(param1:Sprite) : void
      {
         var _loc2_:Point = this.src.localToGlobal(new Point(0,0));
         _loc2_ = this.dst.globalToLocal(_loc2_);
         param1.x = _loc2_.x;
         param1.y = _loc2_.y;
      }
   }
}

