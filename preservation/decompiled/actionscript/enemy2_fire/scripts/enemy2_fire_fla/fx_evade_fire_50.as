package enemy2_fire_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol64")]
   public dynamic class fx_evade_fire_50 extends MovieClip
   {
      
      public function fx_evade_fire_50()
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

