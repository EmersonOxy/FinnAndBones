package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol100")]
   public dynamic class DragThis extends MovieClip
   {
      
      public function DragThis()
      {
         super();
         addFrameScript(10,this.frame11,18,this.frame19);
      }
      
      internal function frame11() : *
      {
         stop();
      }
      
      internal function frame19() : *
      {
         stop();
      }
   }
}

