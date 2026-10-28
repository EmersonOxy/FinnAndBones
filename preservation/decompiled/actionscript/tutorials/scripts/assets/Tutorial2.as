package assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol81")]
   public dynamic class Tutorial2 extends MovieClip
   {
      
      public var text1:MovieClip;
      
      public var text2:MovieClip;
      
      public var text3:MovieClip;
      
      public var text4:MovieClip;
      
      public var ok:MovieClip;
      
      public var title:MovieClip;
      
      public var tips:MovieClip;
      
      public function Tutorial2()
      {
         super();
         addFrameScript(22,this.frame23,47,this.frame48);
      }
      
      internal function frame23() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame48() : *
      {
         stop();
      }
   }
}

