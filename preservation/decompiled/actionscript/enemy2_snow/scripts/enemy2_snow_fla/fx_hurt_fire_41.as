package enemy2_snow_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol80")]
   public dynamic class fx_hurt_fire_41 extends MovieClip
   {
      
      public function fx_hurt_fire_41()
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

