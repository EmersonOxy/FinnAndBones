package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol109")]
   public dynamic class PrincessPopUp extends MovieClip
   {
      
      public var container:MovieClip;
      
      public function PrincessPopUp()
      {
         super();
         addFrameScript(8,this.frame9);
      }
      
      internal function frame9() : *
      {
         stop();
      }
   }
}

