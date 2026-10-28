package view.screens.main_game.inventory
{
   import actions.Lambda;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import main_game.inventory.Inventory;
   import view.screens.main_game.slot.SlotView;
   import view.screens.main_game.slot.TrashView;
   
   public class InventoryView
   {
      
      private static const NEXT_BUTTON:String = "arrow_next";
      
      private static const PREV_BUTTON:String = "arrow_prev";
      
      private var bg:MovieClip;
      
      private var slots:Array;
      
      private var trash:TrashView;
      
      private var actual_page:uint;
      
      public function InventoryView()
      {
         super();
         this.actual_page = 1;
         this.trash = new TrashView();
         this.slots = new Array(Inventory.SLOTS);
      }
      
      public function initialize(param1:MovieClip) : void
      {
         this.bg = param1;
         this.trash.initialize(param1.trash);
         var _loc2_:Inventory = main.game.getInventory();
         var _loc3_:uint = 1;
         while(_loc3_ <= Inventory.SLOTS)
         {
            this.slots[_loc3_ - 1] = new SlotView(_loc2_.getSlot(_loc3_ - 1));
            this.slots[_loc3_ - 1].initialize(param1.page_1["slot_" + _loc3_]);
            _loc3_++;
         }
      }
      
      private function updatePage(param1:*, param2:uint) : void
      {
         this.actual_page = param2;
      }
      
      public function nextPage(param1:MouseEvent) : void
      {
         this.goToPage(this.actual_page + 1);
      }
      
      public function previousPage(param1:MouseEvent) : void
      {
         this.goToPage(this.actual_page - 1);
      }
      
      private function goToPage(param1:uint) : void
      {
         if(this.actual_page == param1)
         {
            this.updatePage(null,param1);
            return;
         }
         var _loc2_:String = "page_" + this.actual_page + "_" + param1;
         this.bg.gotoAndPlay(_loc2_);
         var _loc3_:SmartMC = new SmartMC(this.bg.page_1);
         _loc3_.trigger(new EndAnimation(),new Lambda(this.updatePage,param1));
      }
      
      public function clear() : void
      {
         var _loc1_:SlotView = null;
         for each(_loc1_ in this.slots)
         {
            _loc1_.clear();
         }
         this.slots = null;
         this.trash.clear();
         this.trash = null;
      }
   }
}

