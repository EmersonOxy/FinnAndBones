package tutorial.view
{
   import cb.data.ButtonGroup;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import util.Buttons;
   
   public class TutorialViewWithOk extends TutorialView
   {
      
      public function TutorialViewWithOk(param1:Class)
      {
         super(param1);
      }
      
      override protected function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["ok"] = ButtonGroup.get("gui").createButton(this.endStep,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function endStep(param1:MouseEvent) : void
      {
         this.leave();
      }
      
      override public function enter(param1:Function = null) : void
      {
         Buttons.setButtons(this.bg,["ok"],true);
         super.enter(param1);
      }
      
      override public function leave(param1:Function = null) : void
      {
         Buttons.setButtons(this.bg,["ok"],false);
         super.leave(param1);
      }
   }
}

