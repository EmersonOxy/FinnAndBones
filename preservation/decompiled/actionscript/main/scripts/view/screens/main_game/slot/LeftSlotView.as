package view.screens.main_game.slot
{
   import main_game.item_containers.ISlot;
   import view.popUp.ItemPopUp;
   
   public class LeftSlotView extends AutoSelectSlotView
   {
      
      private var selectionBloked:Boolean;
      
      public function LeftSlotView(param1:ISlot)
      {
         super(param1);
         this.selectionBloked = false;
      }
      
      override protected function createPopUp() : void
      {
         this.popUp = new ItemPopUp(ItemPopUp.RIGHT);
      }
      
      public function blockSelection() : void
      {
         deselect();
         this.selectionBloked = true;
      }
      
      public function unblockSelection() : void
      {
         this.selectionBloked = false;
      }
      
      override protected function select() : void
      {
         if(!this.selectionBloked)
         {
            super.select();
         }
      }
   }
}

