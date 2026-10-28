package assets.enemy2_normal
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol49")]
   public dynamic class idle extends MovieClip
   {
      
      public function idle()
      {
         super();
         addFrameScript(34,this.frame35);
      }
      
      internal function frame35() : *
      {
         stop();
      }
   }
}

