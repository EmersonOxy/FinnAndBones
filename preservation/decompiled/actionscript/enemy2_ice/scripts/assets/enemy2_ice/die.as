package assets.enemy2_ice
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol96")]
   public dynamic class die extends MovieClip
   {
      
      public var enemy2_parts_shoulder:MovieClip;
      
      public var fx:MovieClip;
      
      public function die()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      internal function frame20() : *
      {
         stop();
      }
   }
}

