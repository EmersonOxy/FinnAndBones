package view.screens.main_game.slot
{
   import drag_and_drop.DragListener;
   import flash.events.MouseEvent;
   import main_game.item_containers.ISlot;
   
   public class AutoSelectSlotView extends SlotView
   {
      
      public function AutoSelectSlotView(param1:ISlot)
      {
         super(param1);
      }
      
      override protected function startDrag(param1:DragListener) : void
      {
         super.startDrag(param1);
         popUp.hide();
         if(param1.isInState(DragListener.ACTIVE_DRAG))
         {
            select();
         }
      }
      
      override protected function mouseOut(param1:MouseEvent) : void
      {
         if(drag_listener.isInState(DragListener.NO_DRAG))
         {
            super.mouseOut(param1);
         }
      }
   }
}

