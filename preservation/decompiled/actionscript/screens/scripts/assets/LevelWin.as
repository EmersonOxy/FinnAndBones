package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol293")]
   public dynamic class LevelWin extends MovieClip
   {
      
      public var loot:MovieClip;
      
      public var level_select:MovieClip;
      
      public var container:MovieClip;
      
      public var next:MovieClip;
      
      public var slot_1:MovieClip;
      
      public var slot_2:MovieClip;
      
      public var replay:MovieClip;
      
      public var slot_3:MovieClip;
      
      public var info:MovieClip;
      
      public function LevelWin()
      {
         super();
         addFrameScript(33,this.frame34);
      }
      
      internal function frame34() : *
      {
         stop();
      }
   }
}

