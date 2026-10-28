package assets.enemy2_fire
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol108")]
   public dynamic class hurt extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function hurt()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      internal function frame20() : *
      {
         stop();
      }
   }
}

