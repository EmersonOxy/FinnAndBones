package assets.enemy1_fire
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol133")]
   public dynamic class attack extends MovieClip
   {
      
      public function attack()
      {
         super();
         addFrameScript(28,this.frame29);
      }
      
      internal function frame29() : *
      {
         stop();
      }
   }
}

