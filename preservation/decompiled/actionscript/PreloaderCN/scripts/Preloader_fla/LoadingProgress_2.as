package Preloader_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol17")]
   public dynamic class LoadingProgress_2 extends MovieClip
   {
      
      public var fill_mc:MovieClip;
      
      public function LoadingProgress_2()
      {
         super();
         addFrameScript(0,frame1,99,frame100);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame100() : *
      {
         stop();
      }
   }
}

