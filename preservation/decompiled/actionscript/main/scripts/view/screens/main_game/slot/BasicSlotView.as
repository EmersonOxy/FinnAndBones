package view.screens.main_game.slot
{
   import drag_and_drop.DragListener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import main_game.item_containers.ISlot;
   import main_game.item_containers.SlotChange;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import view.items.ItemView;
   import view.popUp.ItemPopUp;
   
   public class BasicSlotView
   {
      
      protected var bg:MovieClip;
      
      protected var item_view:ItemView;
      
      protected var slot:ISlot;
      
      protected var popUp:ItemPopUp;
      
      protected var drag_listener:DragListener;
      
      private var selected:Boolean;
      
      private var enabled:Boolean = true;
      
      protected var hide:Boolean = false;
      
      public function BasicSlotView(param1:ISlot)
      {
         super();
         this.slot = param1;
         this.createPopUp();
         this.selected = false;
         this.slot.onChange.add(this.refresh);
      }
      
      public function hideItem() : void
      {
         this.hide = true;
         if(this.item_view != null)
         {
            this.item_view.getMC().visible = false;
            this.updateState(this.item_view);
         }
      }
      
      public function unHideItem() : void
      {
         this.hide = false;
         if(this.item_view != null)
         {
            this.item_view.getMC().visible = true;
            this.updateState(this.item_view);
         }
      }
      
      public function enable() : void
      {
         if(this.selected && !this.enabled)
         {
            this.enabled = true;
            this.selected = false;
            this.select();
         }
         this.enabled = true;
      }
      
      public function disable() : void
      {
         if(this.enabled && this.selected)
         {
            this.deselect();
         }
         this.enabled = false;
      }
      
      protected function createPopUp() : void
      {
         this.popUp = new ItemPopUp();
      }
      
      public function initialize(param1:MovieClip) : void
      {
         this.bg = param1;
         this.bg.gotoAndStop("mouseOver");
         this.drag_listener = new DragListener(this.bg,this.slot);
         this.drag_listener.onEnd.add(this.endDrag);
         this.drag_listener.onStart.add(this.startDrag);
         this.refresh();
      }
      
      public function refresh(param1:SlotChange = null) : void
      {
         var _loc3_:Point = null;
         this.removeEvents();
         if(this.item_view != null)
         {
            this.item_view.clear();
            this.item_view = null;
         }
         var _loc2_:Item = this.slot.getContent();
         this.popUp.refreshItem(_loc2_);
         if(_loc2_)
         {
            this.item_view = ItemFactory.getInstance().getView(_loc2_);
            this.item_view.putIn(this.bg);
            this.popUp.addIn(this.bg);
            _loc3_ = this.bg.localToGlobal(new Point(this.bg.mouseX,this.bg.mouseY));
            if(this.bg.hitTestPoint(_loc3_.x,_loc3_.y,true))
            {
               this.mouseOver(null);
            }
         }
         else
         {
            this.popUp.clear();
         }
         this.updateState(this.item_view);
         this.addEvents();
      }
      
      protected function updateState(param1:ItemView) : void
      {
      }
      
      private function addEvents() : void
      {
         this.bg.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this.bg.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
      }
      
      private function removeEvents() : void
      {
         this.bg.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this.bg.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
      }
      
      protected function startDrag(param1:DragListener) : void
      {
         this.popUp.hide();
         if(param1.isInState(DragListener.DRAGGER))
         {
            this.item_view.getMC().alpha = 0.3;
            this.select();
         }
      }
      
      protected function endDrag(param1:DragListener) : void
      {
         if(param1.isInState(DragListener.DRAGGER))
         {
            if(this.item_view)
            {
               this.item_view.getMC().alpha = 1;
            }
         }
         if(!param1.isInState(DragListener.RECEIVER))
         {
            this.deselect();
         }
      }
      
      protected function mouseOver(param1:MouseEvent) : void
      {
         if(this.hide)
         {
            return;
         }
         Mouse.cursor = MouseCursor.AUTO;
         switch(this.drag_listener.dragState)
         {
            case DragListener.ACTIVE_DRAG:
               this.select();
               break;
            case DragListener.NO_DRAG:
               if(!this.slot.isEmpty())
               {
                  this.select();
                  Mouse.cursor = MouseCursor.HAND;
               }
               this.popUp.show();
               break;
            case DragListener.RECEIVER:
               if(!this.slot.isEmpty())
               {
                  this.select();
                  Mouse.cursor = MouseCursor.HAND;
               }
               this.popUp.show();
         }
      }
      
      protected function mouseOut(param1:MouseEvent) : void
      {
         if(this.hide)
         {
            return;
         }
         Mouse.cursor = MouseCursor.AUTO;
         switch(this.drag_listener.dragState)
         {
            case DragListener.ACTIVE_DRAG:
               this.deselect();
               break;
            case DragListener.NO_DRAG:
               this.deselect();
               this.popUp.hide();
         }
      }
      
      protected function select() : void
      {
         if(!this.selected && this.enabled)
         {
            this.selected = true;
            this.bg.gotoAndPlay("mouseOver");
         }
      }
      
      protected function deselect() : void
      {
         if(this.selected)
         {
            this.selected = false;
            this.bg.gotoAndPlay("mouseOut");
         }
      }
      
      public function clear() : void
      {
         this.removeEvents();
         this.drag_listener.clear();
         this.bg = null;
         this.popUp.clear();
         this.popUp = null;
         if(this.item_view != null)
         {
            this.item_view.clear();
         }
         this.item_view = null;
      }
   }
}

