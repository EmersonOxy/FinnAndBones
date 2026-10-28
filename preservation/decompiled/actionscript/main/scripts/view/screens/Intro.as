package view.screens
{
   import sound.GameSounds;
   
   public class Intro extends ComicWindow
   {
      
      public function Intro()
      {
         super(main.swfLoader.getClass("assets.Intro"),4);
      }
      
      override protected function initializeText() : void
      {
         bg.box_1.title.title.text = main.locale.get("intro_01");
         bg.box_2.title.title.text = main.locale.get("intro_02");
         bg.box_3.title.title.text = main.locale.get("intro_03");
         bg.box_4.title.title.text = main.locale.get("intro_04");
         bg.box_6.title.title.text = main.locale.get("intro_06");
         bg.box_7.title.title.text = main.locale.get("intro_07");
      }
      
      override protected function get music() : String
      {
         return GameSounds.INTRO_MUSIC;
      }
   }
}

