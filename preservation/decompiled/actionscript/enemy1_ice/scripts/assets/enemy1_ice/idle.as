package assets.enemy1_ice
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol54")]
   public dynamic class idle extends MovieClip
   {
      
      public function idle()
      {
         super();
         addFrameScript(20,this.frame21);
      }
      
      internal function frame21() : *
      {
         stop();
      }
   }
}

