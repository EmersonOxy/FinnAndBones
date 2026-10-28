package assets.boss_normal
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol255")]
   public dynamic class attack extends MovieClip
   {
      
      public var boss_parts_claw4_33:MovieClip;
      
      public var boss_parts_claw4_3:MovieClip;
      
      public function attack()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      internal function frame40() : *
      {
         stop();
      }
   }
}

