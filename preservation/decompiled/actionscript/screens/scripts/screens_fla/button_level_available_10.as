package screens_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol740")]
   public dynamic class button_level_available_10 extends MovieClip
   {
      
      public var icon:MovieClip;
      
      public var lastLevel:MovieClip;
      
      public function button_level_available_10()
      {
         super();
         addFrameScript(0,this.frame1,17,this.frame18,18,this.frame19);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame18() : *
      {
         gotoAndPlay("mouseOver");
      }
      
      internal function frame19() : *
      {
         stop();
      }
   }
}

