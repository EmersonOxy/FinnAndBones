package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol653")]
   public dynamic class EndGame extends MovieClip
   {
      
      public var container:MovieClip;
      
      public function EndGame()
      {
         super();
         addFrameScript(1,this.frame2,15,this.frame16);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         stop();
      }
   }
}

