package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol25")]
   public dynamic class DungeonIce extends MovieClip
   {
      
      public var ice:MovieClip;
      
      public function DungeonIce()
      {
         super();
         addFrameScript(3,this.frame4,9,this.frame10,14,this.frame15);
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         stop();
      }
   }
}

