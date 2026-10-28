package assets.boss_normal
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol247")]
   public dynamic class die extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function die()
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

