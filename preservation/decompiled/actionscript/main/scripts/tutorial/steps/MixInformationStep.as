package tutorial.steps
{
   import flash.display.MovieClip;
   import main_game.inventory.Inventory;
   import main_game.item_containers.SlotChange;
   import tutorial.Tutorial;
   import tutorial.view.TutorialView;
   import tutorial.view.TutorialViewWithOk;
   
   public class MixInformationStep extends TutorialStep
   {
      
      public function MixInformationStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
      }
      
      override protected function createView(param1:String) : TutorialView
      {
         return new TutorialViewWithOk(main.swfLoader.getClass(param1));
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.title.title.text = main.locale.get("tutorialMixTitle");
         param1.text.text.text = main.locale.get("tutorialMix2");
      }
      
      private function get inventory() : Inventory
      {
         return main.game.getInventory();
      }
      
      override public function enter() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < Inventory.SLOTS)
         {
            this.inventory.getSlot(_loc1_).onChange.add(this.checkForEnoughItems);
            _loc1_++;
         }
         this.checkForEnoughItems();
      }
      
      private function checkForEnoughItems(param1:SlotChange = null) : Boolean
      {
         var _loc2_:uint = 0;
         if(this.inventory.fullSlots >= 2)
         {
            _loc2_ = 0;
            while(_loc2_ < Inventory.SLOTS)
            {
               this.inventory.getSlot(_loc2_).onChange.remove(this.checkForEnoughItems);
               _loc2_++;
            }
            tut.enableMix();
            super.enter();
         }
         return false;
      }
   }
}

