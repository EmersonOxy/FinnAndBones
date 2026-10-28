package view.screens
{
   import cb.data.ButtonGroup;
   import flash.utils.Dictionary;
   import sound.GameSounds;
   
   public class Outro extends ComicWindow
   {
      
      public function Outro()
      {
         super(main.swfLoader.getClass("assets.Outro"),5);
      }
      
      override protected function initializeText() : void
      {
         bg.box_1.text.text = main.locale.get("outro_01");
         bg.box_2.text.text = main.locale.get("outro_02");
         bg.box_3.text.text = main.locale.get("outro_03");
         bg.box_4.text.text = main.locale.get("outro_04");
         bg.box_5.text.text = main.locale.get("outro_05");
         bg.box_6.text.text = main.locale.get("outro_06");
      }
      
      override protected function getButtonInfo() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["ok"] = ButtonGroup.get("gui").createButton(next,"mouseOver","mouseOut");
         _loc1_["sound"] = ButtonGroup.get("sound_gui").createButton(null,"mouseOver","mouseOut");
         return _loc1_;
      }
      
      override protected function get music() : String
      {
         return GameSounds.WIN_MUSIC;
      }
   }
}

