package drag_and_drop
{
   import cb.signals.Signal;
   import cb.utils.Tween;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import sound.GameSounds;
   
   public class DragDispatcher
   {
      
      private static var ROLLBACK_VELOCITY:Number = 0.6;
      
      public var beginDrag:Signal;
      
      public var stopDrag:Signal;
      
      private var stage:Stage;
      
      private var content:Item;
      
      private var firstContainer:IDragContainer;
      
      private var dragging:Boolean;
      
      private var tmp_view:Sprite;
      
      private var initial_x:int;
      
      private var initial_y:int;
      
      private var snapped:Boolean = false;
      
      public function DragDispatcher(param1:Stage)
      {
         super();
         this.stage = param1;
         this.dragging = false;
         this.beginDrag = new Signal();
         this.stopDrag = new Signal();
         this.beginDrag.add(this.start);
         this.stopDrag.add(this.end);
      }
      
      private function start(param1:IDragContainer, param2:Item) : void
      {
         if(this.tmp_view != null)
         {
            this.killTween();
         }
         assert(!this.dragging,"No se termino el ultimo drag");
         this.content = param2;
         this.firstContainer = param1;
         this.dragging = true;
         var _loc3_:* = ItemFactory.getInstance().getView(this.content);
         this.tmp_view = _loc3_.getMC();
         this.initial_x = this.stage.mouseX;
         this.initial_y = this.stage.mouseY;
         this.stage.addChild(this.tmp_view);
         this.tmp_view.x = this.initial_x;
         this.tmp_view.y = this.initial_y;
         this.tmp_view.mouseEnabled = false;
         this.tmp_view.mouseChildren = false;
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpStage,false,0,true);
         Mouse.hide();
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.move,false,0,false);
         main.soundManager.playFx(GameSounds.ITEM_CLICK);
      }
      
      private function move(param1:MouseEvent) : void
      {
         assert(this.dragging,"No se está dragueando");
         if(!this.snapped)
         {
            this.tmp_view.x = this.stage.mouseX;
            this.tmp_view.y = this.stage.mouseY;
         }
      }
      
      private function mouseUpStage(param1:MouseEvent) : void
      {
         if(this.dragging)
         {
            this.stopDrag.emit(null);
         }
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpStage);
      }
      
      private function end(param1:IDragContainer) : void
      {
         var _loc2_:Number = NaN;
         assert(this.dragging,"No se está dragueando");
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.move);
         if(param1 != null && param1.canMoveFrom(this.content,this.firstContainer))
         {
            this.removeTempView();
            param1.moveFrom(this.content,this.firstContainer);
            main.soundManager.playFx(GameSounds.ITEM_DROP_OK);
         }
         else
         {
            _loc2_ = ROLLBACK_VELOCITY * (Math.abs(this.stage.mouseX - this.initial_x) + Math.abs(this.stage.mouseY - this.initial_y));
            Tween.to(this.tmp_view,_loc2_,{
               "x":this.initial_x,
               "y":this.initial_y
            },this.removeTempView);
            main.soundManager.playFx(GameSounds.ITEM_DROP_FAIL);
         }
         Mouse.cursor = MouseCursor.AUTO;
         Mouse.show();
         this.dragging = false;
         this.content = null;
         this.firstContainer = null;
      }
      
      public function clear() : void
      {
         this.beginDrag.clear();
         this.stopDrag.clear();
         this.beginDrag.add(this.start);
         this.stopDrag.add(this.end);
         if(this.dragging)
         {
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.move);
            this.dragging = false;
         }
         if(this.tmp_view != null)
         {
            this.killTween();
         }
         this.content = null;
         this.firstContainer = null;
      }
      
      private function killTween() : void
      {
         Tween.killTweensOf(this.tmp_view);
         this.removeTempView();
      }
      
      private function removeTempView() : void
      {
         if(this.tmp_view != null)
         {
            this.stage.removeChild(this.tmp_view);
         }
         this.tmp_view = null;
      }
      
      public function onMouseOver(param1:IDragContainer, param2:MovieClip) : void
      {
         if(this.tmp_view != null && param1.canMoveFrom(this.content,this.firstContainer))
         {
            this.snapTo(param2);
         }
      }
      
      public function onMouseOut(param1:IDragContainer, param2:MovieClip) : void
      {
         this.unSnapFrom(param2);
      }
      
      private function snapTo(param1:MovieClip) : void
      {
         this.snapped = true;
         var _loc2_:Point = param1.localToGlobal(new Point(0,0));
         _loc2_ = this.tmp_view.parent.globalToLocal(_loc2_);
         this.tmp_view.x = _loc2_.x;
         this.tmp_view.y = _loc2_.y;
      }
      
      private function unSnapFrom(param1:MovieClip) : void
      {
         this.snapped = false;
      }
   }
}

