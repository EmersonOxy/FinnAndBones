package view.items
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import main_game.items.Item;
   import view.screens.main_game.slot.SlotView;
   
   public class ItemView
   {
      
      protected var item:Item;
      
      protected var mc:MovieClip;
      
      public function ItemView(param1:Item)
      {
         super();
         this.item = param1;
      }
      
      public function getMC() : MovieClip
      {
         var _loc1_:Class = null;
         if(this.mc == null)
         {
            _loc1_ = main.swfLoader.getClass("assets." + this.item.getMcName());
            this.mc = new _loc1_();
         }
         return this.mc;
      }
      
      public function putIn(param1:DisplayObjectContainer) : void
      {
         var _loc2_:MovieClip = this.getMC();
         param1.addChild(_loc2_);
      }
      
      public function clear() : void
      {
         if(this.mc.parent != null)
         {
            this.mc.parent.removeChild(this.mc);
         }
         this.item = null;
         this.mc = null;
      }
      
      public function getStateForSlot(param1:SlotView) : String
      {
         return "";
      }
   }
}

