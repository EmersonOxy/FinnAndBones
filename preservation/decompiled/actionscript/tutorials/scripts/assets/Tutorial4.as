package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol54")]
   public dynamic class Tutorial4 extends MovieClip
   {
      
      public var text:MovieClip;
      
      public var tips:MovieClip;
      
      public function Tutorial4()
      {
         super();
         addFrameScript(12,this.frame13,17,this.frame18,29,this.frame30);
      }
      
      internal function frame13() : *
      {
         stop();
      }
      
      internal function frame18() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame30() : *
      {
         stop();
      }
   }
}

