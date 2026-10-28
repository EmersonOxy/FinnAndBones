package cb.display
{
   import cb.data.ButtonInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Screen extends Sprite
   {
      
      protected var bg:MovieClip;
      
      protected var btnInfo:Dictionary;
      
      protected var container:String;
      
      protected var bgClass:Class;
      
      public function Screen(param1:Class, param2:Dictionary)
      {
         super();
         this.bgClass = param1;
         this.btnInfo = param2;
         this.bg = new param1();
         this.bg.addEventListener(Event.ADDED_TO_STAGE,this.added);
         addChild(this.bg);
      }
      
      private function added(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:ButtonInfo = null;
         this.bg.removeEventListener(Event.ADDED_TO_STAGE,this.added);
         for(_loc2_ in this.btnInfo)
         {
            _loc3_ = this.btnInfo[_loc2_];
            this.configureButton(this.getFather(),_loc2_,_loc3_);
         }
      }
      
      private function getFather() : *
      {
         if(this.container)
         {
            return this.bg[this.container];
         }
         return this.bg;
      }
      
      private function getHitBox(param1:*, param2:ButtonInfo) : *
      {
         if(param2.getHitBox())
         {
            return param1[param2.getHitBox()];
         }
         return param1;
      }
      
      protected function setNew(param1:Class, param2:Dictionary) : void
      {
         this.bgClass = param1;
         this.btnInfo = param2;
         this.bg = new param1();
         this.bg.addEventListener(Event.ADDED_TO_STAGE,this.added);
         addChild(this.bg);
      }
      
      private function configureButton(param1:*, param2:String, param3:ButtonInfo) : void
      {
         var _loc4_:* = this.getHitBox(this.getMc(param1,param2),param3);
         _loc4_.addEventListener(MouseEvent.CLICK,param3.click,false,0,true);
         if(param3.over != null)
         {
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,param3.over,false,0,true);
         }
         if(param3.out != null)
         {
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,param3.out,false,0,true);
         }
         _loc4_.mouseChildren = false;
      }
      
      private function getMc(param1:*, param2:String) : *
      {
         if(param2 == "")
         {
            return param1;
         }
         var _loc3_:Array = param2.split(".");
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            param1 = param1[_loc3_[_loc4_]];
            _loc4_++;
         }
         return param1;
      }
      
      protected function addButton(param1:String, param2:ButtonInfo) : void
      {
         this.btnInfo[param1] = param2;
         this.configureButton(this.getFather(),param1,param2);
      }
      
      protected function removeButton(param1:String) : void
      {
         if(this.btnInfo[param1])
         {
            this.removeEvent(this.getFather(),param1);
         }
      }
      
      private function removeEvent(param1:*, param2:String) : void
      {
         var _loc3_:ButtonInfo = this.btnInfo[param2];
         var _loc4_:* = this.getHitBox(this.getMc(param1,param2),_loc3_);
         _loc4_.removeEventListener(MouseEvent.CLICK,_loc3_.click);
         if(_loc3_.over != null)
         {
            _loc4_.removeEventListener(MouseEvent.MOUSE_OVER,_loc3_.over);
         }
         if(_loc3_.out != null)
         {
            _loc4_.removeEventListener(MouseEvent.MOUSE_OUT,_loc3_.out);
         }
      }
      
      public function clear() : void
      {
         this.removeEvents();
         removeChild(this.bg);
         this.bg = null;
      }
      
      public function restore(param1:DisplayObject = null) : void
      {
         this.bg = new this.bgClass();
         this.added(null);
         if(param1)
         {
            addChildAt(this.bg,getChildIndex(param1));
         }
         else
         {
            addChild(this.bg);
         }
      }
      
      public function removeEvents() : void
      {
         var _loc2_:String = null;
         var _loc1_:Object = this.bg;
         if(this.container)
         {
            _loc1_ = this.bg[this.container];
         }
         for(_loc2_ in this.btnInfo)
         {
            this.removeEvent(_loc1_,_loc2_);
         }
      }
      
      public function restoreEvents() : void
      {
         this.added(null);
      }
      
      protected function pop() : void
      {
         parent.removeChild(this);
         this.clear();
      }
      
      public function getBg() : MovieClip
      {
         return this.bg;
      }
   }
}

