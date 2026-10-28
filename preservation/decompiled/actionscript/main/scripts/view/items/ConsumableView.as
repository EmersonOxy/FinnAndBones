package view.items
{
   import flash.display.MovieClip;
   import main_game.items.Item;
   import view.screens.main_game.slot.SlotView;
   
   public class ConsumableView extends ItemView
   {
      
      public function ConsumableView(param1:Item)
      {
         super(param1);
      }
      
      override public function getMC() : MovieClip
      {
         var _loc1_:MovieClip = super.getMC();
         if(_loc1_.potion.hasOwnProperty("liquid1"))
         {
            item.getPrimaryModifier().modifyIcon(_loc1_.potion.liquid1);
         }
         if(_loc1_.potion.hasOwnProperty("liquid2"))
         {
            item.getSecondaryModifier().modifyIcon(_loc1_.potion.liquid2);
         }
         return _loc1_;
      }
      
      override public function getStateForSlot(param1:SlotView) : String
      {
         return SlotView.CONSUMABLE;
      }
   }
}

