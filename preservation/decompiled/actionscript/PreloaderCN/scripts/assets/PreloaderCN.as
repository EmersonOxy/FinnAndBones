package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol53")]
   public dynamic class PreloaderCN extends MovieClip
   {
      
      public var done_mc:MovieClip;
      
      public function PreloaderCN()
      {
         super();
         addFrameScript(42,frame43);
      }
      
      internal function frame43() : *
      {
         stop();
      }
   }
}

