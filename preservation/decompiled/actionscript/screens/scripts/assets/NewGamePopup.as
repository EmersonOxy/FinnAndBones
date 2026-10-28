package assets
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol220")]
   public dynamic class NewGamePopup extends MovieClip
   {
      
      public var container:MovieClip;
      
      public var cancel:MovieClip;
      
      public var accept:MovieClip;
      
      public function NewGamePopup()
      {
         super();
         addFrameScript(10,this.frame11,36,this.frame37,62,this.frame63);
      }
      
      internal function frame11() : *
      {
         dispatchEvent(new Event("blackIn"));
      }
      
      internal function frame37() : *
      {
         stop();
      }
      
      internal function frame63() : *
      {
         dispatchEvent(new Event("blackOut"));
      }
   }
}

