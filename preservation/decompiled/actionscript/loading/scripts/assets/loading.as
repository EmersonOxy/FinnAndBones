package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol66")]
   public dynamic class loading extends MovieClip
   {
      
      public var textContainer:MovieClip;
      
      public function loading()
      {
         super();
         addFrameScript(97,this.frame98,111,this.frame112);
      }
      
      internal function frame98() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame112() : *
      {
         stop();
      }
   }
}

