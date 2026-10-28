package tutorial.steps
{
   import flash.display.MovieClip;
   import main_game.item_containers.SlotChange;
   import tutorial.Tutorial;
   
   public class FirstTutorialStep extends TutorialStep
   {
      
      public function FirstTutorialStep(param1:uint, param2:Tutorial)
      {
         super(param1.toString(),param2,param1,"assets.Tutorial" + param1.toString());
      }
      
      override public function enter() : void
      {
         main.game.getFinn().gear.weapon.onChange.add(this.weaponChange);
         super.enter();
      }
      
      private function weaponChange(param1:SlotChange) : void
      {
         if(param1.getNewItem() != null)
         {
            theView.leave();
         }
      }
      
      override protected function setText(param1:MovieClip) : void
      {
         param1.title.title.text = main.locale.get("tutorialSwordTitle");
         param1.text.text.text = main.locale.get("tutorialSword");
      }
      
      override public function leave() : void
      {
         main.game.getFinn().gear.weapon.onChange.remove(this.weaponChange);
         super.leave();
      }
      
      override public function clear() : void
      {
         super.clear();
         main.game.getFinn().gear.weapon.onChange.remove(this.weaponChange);
      }
   }
}

