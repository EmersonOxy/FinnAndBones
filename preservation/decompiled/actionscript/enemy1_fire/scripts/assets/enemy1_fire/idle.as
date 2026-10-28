package assets.enemy1_fire
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol65")]
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

