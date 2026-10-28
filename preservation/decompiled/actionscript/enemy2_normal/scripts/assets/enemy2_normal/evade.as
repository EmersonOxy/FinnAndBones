package assets.enemy2_normal
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol99")]
   public dynamic class evade extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function evade()
      {
         super();
         addFrameScript(26,this.frame27);
      }
      
      internal function frame27() : *
      {
         stop();
      }
   }
}

