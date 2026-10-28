package drag_and_drop
{
   import cb.signals.Signal;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import main_game.items.Item;
   
   public class DragListener
   {
      
      public static const NO_DRAG:int = 1;
      
      public static const PASIVE_DRAG:int = 2;
      
      public static const ON_DRAG:int = 3;
      
      public static const ACTIVE_DRAG:int = 4;
      
      public static const DRAGGER:int = 5;
      
      public static const RECEIVER:int = 6;
      
      public var onStart:Signal;
      
      public var onEnd:Signal;
      
      private var mc:MovieClip;
      
      private var container:IDragContainer;
      
      public var dragState:int;
      
      public function DragListener(param1:MovieClip, param2:IDragContainer)
      {
         super();
         this.mc = param1;
         this.container = param2;
         this.dragState = NO_DRAG;
         this.onEnd = new Signal();
         this.onStart = new Signal();
         this.addEvents();
      }
      
      public function isInState(param1:int) : Boolean
      {
         return this.dragState == param1;
      }
      
      private function addEvents() : void
      {
         main.drag.beginDrag.add(this.beginDrag);
         main.drag.stopDrag.add(this.stopDrag);
         this.mc.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
      }
      
      private function removeEvents() : void
      {
         main.drag.beginDrag.remove(this.beginDrag);
         main.drag.stopDrag.remove(this.stopDrag);
         this.mc.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
      }
      
      private function addDragEvents() : void
      {
         this.mc.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
      }
      
      private function removeDragEvents() : void
      {
         this.mc.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         main.drag.onMouseOver(this.container,this.mc);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         main.drag.onMouseOut(this.container,this.mc);
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Item = this.container.getContainToDrag();
         if(_loc2_ != null)
         {
            this.dragState = DRAGGER;
            main.drag.beginDrag.emit(this.container,_loc2_);
         }
      }
      
      private function mouseUp(param1:MouseEvent) : void
      {
         this.dragState = RECEIVER;
         main.drag.stopDrag.emit(this.container);
      }
      
      private function beginDrag(param1:IDragContainer, param2:Item) : void
      {
         if(!this.isInState(DRAGGER))
         {
            if(this.container.itsCompatible(param2,param1))
            {
               if(this.container.canMoveFrom(param2,param1))
               {
                  this.dragState = ACTIVE_DRAG;
               }
               else
               {
                  this.dragState = ON_DRAG;
               }
               this.addDragEvents();
            }
            else
            {
               this.dragState = PASIVE_DRAG;
            }
         }
         this.onStart.emit(this);
      }
      
      private function stopDrag(param1:IDragContainer) : void
      {
         this.removeDragEvents();
         this.onEnd.emit(this);
         this.dragState = NO_DRAG;
      }
      
      public function clear() : void
      {
         if(this.isInState(ACTIVE_DRAG) || this.isInState(ON_DRAG))
         {
            this.removeDragEvents();
         }
         this.removeEvents();
         this.onEnd.clear();
         this.onStart.clear();
         this.onEnd = null;
         this.onStart = null;
         this.mc = null;
         this.container = null;
      }
   }
}

