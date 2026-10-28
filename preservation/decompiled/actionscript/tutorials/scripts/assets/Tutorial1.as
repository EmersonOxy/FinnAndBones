package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol87")]
   public dynamic class Tutorial1 extends MovieClip
   {
      
      public var title:MovieClip;
      
      public var text:MovieClip;
      
      public var tips:MovieClip;
      
      public function Tutorial1()
      {
         super();
         addFrameScript(17,this.frame18,23,this.frame24,40,this.frame41);
      }
      
      internal function frame18() : *
      {
         stop();
      }
      
      internal function frame24() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame41() : *
      {
         stop();
      }
   }
}

