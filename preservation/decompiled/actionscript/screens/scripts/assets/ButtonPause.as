package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol755")]
   public dynamic class ButtonPause extends MovieClip
   {
      
      public function ButtonPause()
      {
         super();
         addFrameScript(3,this.frame4,8,this.frame9,13,this.frame14);
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame9() : *
      {
         stop();
      }
      
      internal function frame14() : *
      {
         stop();
      }
   }
}

