package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol39")]
   public dynamic class Smoke extends MovieClip
   {
      
      public function Smoke()
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

