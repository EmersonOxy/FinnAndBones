package view.screens
{
   import cb.data.ButtonGroup;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import util.Buttons;
   import util.Sepializer;
   import util.Util;
   
   public class ConfirmationPopUp extends AnimatedScreen
   {
      
      private var background:MovieClip;
      
      private var onAccept:Function;
      
      private var onCancel:Function;
      
      public function ConfirmationPopUp(param1:MovieClip, param2:Function, param3:Function, param4:String)
      {
         super(main.swfLoader.getClass("assets.NewGamePopup"),this.getButtonInfo());
         this.onAccept = param2;
         this.onCancel = param3;
         this.background = param1;
         this.bg.addEventListener("blackIn",this.sepialize);
         this.bg.addEventListener("blackOut",this.unsepialize);
         Buttons.setButtons(bg,["accept","cancel"],true);
         this.bg.container.text.title.text = param4;
      }
      
      private function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:ButtonGroup = ButtonGroup.get("gui");
         _loc1_["accept"] = _loc2_.createButton(this.accept,"mouseOver","mouseOut");
         _loc1_["cancel"] = _loc2_.createButton(this.cancel,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      private function sepialize(param1:Event) : void
      {
         Sepializer.getInstance().sepialize(this.background);
      }
      
      private function unsepialize(param1:Event) : void
      {
         Sepializer.getInstance().unsepialize(this.background);
      }
      
      private function accept(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg,["accept","cancel"],false);
         this.onAccept();
         pop();
      }
      
      private function cancel(param1:MouseEvent) : void
      {
         Buttons.setButtons(bg,["accept","cancel"],false);
         leave(Util.concatenate(this.onCancel,pop));
      }
      
      override public function clear() : void
      {
         this.bg.removeEventListener("blackIn",this.sepialize);
         this.bg.removeEventListener("blackOut",this.unsepialize);
         this.onAccept = null;
         this.background = null;
      }
   }
}

