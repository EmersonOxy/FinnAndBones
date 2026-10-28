package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol303")]
   public dynamic class LevelLose extends MovieClip
   {
      
      public var level_select:MovieClip;
      
      public var container:MovieClip;
      
      public var total:MovieClip;
      
      public var replay:MovieClip;
      
      public function LevelLose()
      {
         super();
         addFrameScript(22,this.frame23);
      }
      
      internal function frame23() : *
      {
         stop();
      }
   }
}

