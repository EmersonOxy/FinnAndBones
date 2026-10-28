package assets.enemy1_fire
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol92")]
   public dynamic class evade extends MovieClip
   {
      
      public var fx:MovieClip;
      
      public function evade()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      internal function frame25() : *
      {
         stop();
      }
   }
}

