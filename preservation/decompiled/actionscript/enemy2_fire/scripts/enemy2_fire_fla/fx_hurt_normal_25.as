package enemy2_fire_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol78")]
   public dynamic class fx_hurt_normal_25 extends MovieClip
   {
      
      public function fx_hurt_normal_25()
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

