package view.items
{
   import flash.display.MovieClip;
   import main_game.items.Item;
   import view.screens.main_game.slot.SlotView;
   
   public class ShieldView extends ItemView
   {
      
      public function ShieldView(param1:Item)
      {
         super(param1);
      }
      
      override public function getMC() : MovieClip
      {
         var _loc1_:MovieClip = super.getMC();
         item.getSecondaryModifier().modifyIcon(_loc1_.sword.gem);
         return _loc1_;
      }
      
      override public function getStateForSlot(param1:SlotView) : String
      {
         return SlotView.WEAPONS;
      }
   }
}

