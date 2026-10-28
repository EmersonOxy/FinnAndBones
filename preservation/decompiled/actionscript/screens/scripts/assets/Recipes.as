package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol100")]
   public dynamic class Recipes extends MovieClip
   {
      
      public var container:MovieClip;
      
      public function Recipes()
      {
         super();
         addFrameScript(13,this.frame14);
      }
      
      internal function frame14() : *
      {
         stop();
      }
   }
}

