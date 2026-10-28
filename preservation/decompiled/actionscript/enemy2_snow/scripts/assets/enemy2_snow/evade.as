package assets.enemy2_snow
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol96")]
   public dynamic class evade extends MovieClip
   {
      
      public var enemy2_parts_head3:MovieClip;
      
      public var fx:MovieClip;
      
      public var enemy2_parts_head1:MovieClip;
      
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

