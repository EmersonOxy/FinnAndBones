package assets.enemy1_fire
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol113")]
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

