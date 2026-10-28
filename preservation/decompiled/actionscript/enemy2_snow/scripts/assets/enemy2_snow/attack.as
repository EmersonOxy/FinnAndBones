package assets.enemy2_snow
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol113")]
   public dynamic class attack extends MovieClip
   {
      
      public function attack()
      {
         super();
         addFrameScript(92,this.frame93);
      }
      
      internal function frame93() : *
      {
         stop();
      }
   }
}

