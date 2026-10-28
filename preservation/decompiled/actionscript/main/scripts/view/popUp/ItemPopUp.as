package view.popUp
{
   import flash.display.MovieClip;
   import main_game.items.Item;
   import main_game.mixer.MixStrategy;
   
   public class ItemPopUp extends PopUp
   {
      
      public static var LEFT:String = "Left";
      
      public static var RIGHT:String = "Right";
      
      private var item:Item;
      
      public function ItemPopUp(param1:String = "Left")
      {
         var _loc2_:MovieClip = main.swfLoader.getObject("assets.ItemInformation" + param1) as MovieClip;
         super(_loc2_);
         this.item = null;
      }
      
      public function refreshItem(param1:Item) : void
      {
         this.item = param1;
         if(param1)
         {
            this.refreshInfo(param1);
         }
      }
      
      private function refreshInfo(param1:Item) : void
      {
         mc.container.title.title.text = param1.getNameToShow();
         var _loc2_:int = param1.getMaxMod();
         param1.getPrimaryModifier().modifyIcon(mc.container.armor_icon_1);
         param1.getPrimaryModifier().modifyValue(mc.container.numbers_1.title,_loc2_);
         param1.getSecondaryModifier().modifyIcon(mc.container.armor_icon_2);
         _loc2_ = Math.round(_loc2_ * MixStrategy.mixConfig.secondModMaxPercent / 100);
         param1.getSecondaryModifier().modifyValue(mc.container.numbers_2.title,_loc2_);
      }
      
      override public function hide(param1:Function = null) : void
      {
         if(this.item)
         {
            super.hide();
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      override public function show(param1:Function = null) : void
      {
         if(this.item)
         {
            super.show();
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      override public function clear() : void
      {
         this.item = null;
         super.clear();
      }
   }
}

