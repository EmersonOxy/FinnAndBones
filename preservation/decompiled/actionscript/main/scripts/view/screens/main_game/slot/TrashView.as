package view.screens.main_game.slot
{
   import drag_and_drop.DragListener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import main_game.items.Item;
   
   public class TrashView
   {
      
      private var trash:MovieClip;
      
      private var drag_listener:DragListener;
      
      private var selected:Boolean;
      
      public function TrashView()
      {
         super();
         main.game.getInventory().getTrash().onThrow.add(this.throwItem);
         this.selected = false;
      }
      
      public function initialize(param1:MovieClip) : void
      {
         this.trash = param1;
         this.drag_listener = new DragListener(param1.hit_box,main.game.getInventory().getTrash());
         this.stop();
         this.addEvents();
      }
      
      private function addEvents() : void
      {
         this.trash.hit_box.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this.trash.hit_box.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
      }
      
      private function removeEvents() : void
      {
         this.trash.hit_box.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this.trash.hit_box.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this.drag_listener.dragState == DragListener.ACTIVE_DRAG)
         {
            this.select();
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         this.deselect();
      }
      
      private function select() : void
      {
         if(!this.selected)
         {
            this.selected = true;
            this.trash.gotoAndPlay("mouseOver");
         }
      }
      
      private function deselect() : void
      {
         if(this.selected)
         {
            this.selected = false;
            this.trash.gotoAndPlay("mouseOut");
         }
      }
      
      private function stop() : void
      {
         this.trash.trash.gotoAndStop(1);
      }
      
      private function throwItem(param1:Item) : void
      {
         this.deselect();
         this.trash.trash.gotoAndPlay(1);
      }
      
      public function clear() : void
      {
         this.removeEvents();
         this.drag_listener.clear();
         this.drag_listener = null;
         this.trash = null;
      }
   }
}

