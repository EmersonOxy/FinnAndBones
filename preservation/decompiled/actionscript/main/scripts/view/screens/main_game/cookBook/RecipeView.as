package view.screens.main_game.cookBook
{
   import flash.display.MovieClip;
   import main_game.item_containers.ISlot;
   import main_game.item_containers.NullSlot;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import main_game.mixer.Recipe;
   import view.screens.main_game.slot.SlotView;
   
   public class RecipeView
   {
      
      private var primarySlot:ISlot;
      
      private var secondarySlot:ISlot;
      
      private var resultSlot:ISlot;
      
      private var primaryView:SlotView;
      
      private var secondaryView:SlotView;
      
      private var resultView:SlotView;
      
      private var bg:MovieClip;
      
      public function RecipeView(param1:MovieClip, param2:Recipe = null)
      {
         super();
         this.bg = param1;
         this.initializeSlots(param2);
         this.initializeViews();
      }
      
      private function initializeSlots(param1:Recipe) : void
      {
         var _loc2_:ItemFactory = null;
         this.primarySlot = new NullSlot();
         this.secondarySlot = new NullSlot();
         this.resultSlot = new NullSlot();
         if(param1 != null)
         {
            _loc2_ = ItemFactory.getInstance();
            this.primarySlot.add(_loc2_.getItem(param1.primary));
            this.secondarySlot.add(_loc2_.getItem(param1.secondary));
            this.resultSlot.add(_loc2_.getItem(param1.result));
         }
      }
      
      private function initializeViews() : void
      {
         this.primaryView = new SlotView(this.primarySlot);
         this.secondaryView = new SlotView(this.secondarySlot);
         this.resultView = new SlotView(this.resultSlot);
         this.primaryView.initialize(this.bg.slot_1);
         this.secondaryView.initialize(this.bg.slot_2);
         this.resultView.initialize(this.bg.slot_3);
         this.bg.slot_1.mouseEnabled = false;
         this.bg.slot_1.mouseChildren = false;
         this.bg.slot_2.mouseEnabled = false;
         this.bg.slot_2.mouseChildren = false;
         this.bg.slot_3.mouseEnabled = false;
         this.bg.slot_3.mouseChildren = false;
      }
      
      public function clear() : void
      {
         this.clearViews();
         this.clearSlots();
      }
      
      private function clearViews() : void
      {
         this.primaryView.clear();
         this.secondaryView.clear();
         this.resultView.clear();
      }
      
      private function clearSlots() : void
      {
         this.clearSlot(this.primarySlot);
         this.clearSlot(this.secondarySlot);
         this.clearSlot(this.resultSlot);
         this.primarySlot = null;
         this.secondarySlot = null;
         this.resultSlot = null;
      }
      
      private function clearSlot(param1:ISlot) : void
      {
         var _loc2_:Item = param1.getContent();
         if(_loc2_ != null)
         {
            _loc2_.clear();
         }
         param1.clear();
      }
   }
}

