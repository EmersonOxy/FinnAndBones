package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol141")]
   public dynamic class Pause extends MovieClip
   {
      
      public var help:MovieClip;
      
      public var level_select:MovieClip;
      
      public var container:MovieClip;
      
      public var sound:MovieClip;
      
      public var replay:MovieClip;
      
      public var cancel:MovieClip;
      
      public var tips:MovieClip;
      
      public function Pause()
      {
         super();
         addFrameScript(27,this.frame28);
      }
      
      internal function frame28() : *
      {
         stop();
      }
   }
}

