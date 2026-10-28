package assets.enemy1_ice
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol92")]
   public dynamic class hurt extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function hurt()
      {
         super();
         addFrameScript(17,this.frame18);
      }
      
      internal function frame18() : *
      {
         stop();
      }
   }
}

