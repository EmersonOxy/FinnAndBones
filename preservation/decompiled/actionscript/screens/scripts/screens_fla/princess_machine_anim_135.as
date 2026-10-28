package screens_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol485")]
   public dynamic class princess_machine_anim_135 extends MovieClip
   {
      
      public var hitbox:MovieClip;
      
      public function princess_machine_anim_135()
      {
         super();
         addFrameScript(38,this.frame39,75,this.frame76,126,this.frame127,192,this.frame193,218,this.frame219,278,this.frame279,292,this.frame293,332,this.frame333,401,this.frame402,478,this.frame479);
      }
      
      internal function frame39() : *
      {
         switch(int(Math.ceil(Math.random() * 5)))
         {
            case 1:
               gotoAndPlay("leftIdleBlink");
               break;
            case 2:
               gotoAndPlay("leftIdleSmile");
               break;
            case 3:
               gotoAndPlay("lookfront");
               break;
            default:
               gotoAndPlay("leftIdle");
         }
      }
      
      internal function frame76() : *
      {
         gotoAndPlay("leftIdle");
      }
      
      internal function frame127() : *
      {
         gotoAndPlay("leftIdle");
      }
      
      internal function frame193() : *
      {
         switch(int(Math.ceil(Math.random() * 5)))
         {
            case 1:
               gotoAndPlay("idleFrontBlink");
               break;
            case 2:
               gotoAndPlay("idleFrontSmile");
               break;
            case 3:
               gotoAndPlay("lookLeftIdle");
               break;
            default:
               gotoAndPlay("idleFront");
         }
      }
      
      internal function frame219() : *
      {
         gotoAndPlay("idleFront");
      }
      
      internal function frame279() : *
      {
         gotoAndPlay("idleFront");
      }
      
      internal function frame293() : *
      {
         gotoAndPlay("leftIdle");
      }
      
      internal function frame333() : *
      {
         gotoAndPlay("leftIdle");
      }
      
      internal function frame402() : *
      {
         gotoAndPlay("leftIdle");
      }
      
      internal function frame479() : *
      {
         gotoAndPlay("leftIdle");
      }
   }
}

