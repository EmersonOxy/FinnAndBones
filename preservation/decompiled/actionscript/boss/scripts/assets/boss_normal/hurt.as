package assets.boss_normal
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol221")]
   public dynamic class hurt extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function hurt()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      internal function frame30() : *
      {
         stop();
      }
   }
}

