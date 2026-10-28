package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol59")]
   public dynamic class Tutorial3 extends MovieClip
   {
      
      public var title:MovieClip;
      
      public var text:MovieClip;
      
      public var tips:MovieClip;
      
      public function Tutorial3()
      {
         super();
         addFrameScript(21,this.frame22,40,this.frame41);
      }
      
      internal function frame22() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame41() : *
      {
         stop();
      }
   }
}

