package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol652")]
   public dynamic class EnemyBar extends MovieClip
   {
      
      public var luck:MovieClip;
      
      public var player_name:MovieClip;
      
      public var level:MovieClip;
      
      public var bar:MovieClip;
      
      public var attack:MovieClip;
      
      public var defence:MovieClip;
      
      public function EnemyBar()
      {
         super();
         addFrameScript(0,this.frame1,11,this.frame12,22,this.frame23);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
         stop();
      }
      
      internal function frame23() : *
      {
         stop();
      }
   }
}

