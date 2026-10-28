package enemy2_normal_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol90")]
   public dynamic class fx_evade_normal_48 extends MovieClip
   {
      
      public function fx_evade_normal_48()
      {
         super();
         addFrameScript(31,this.frame32);
      }
      
      internal function frame32() : *
      {
         stop();
      }
   }
}

