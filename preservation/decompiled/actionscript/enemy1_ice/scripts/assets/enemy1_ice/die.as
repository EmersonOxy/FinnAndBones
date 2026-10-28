package assets.enemy1_ice
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol100")]
   public dynamic class die extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function die()
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

