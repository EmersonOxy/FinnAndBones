package screens_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol381")]
   public dynamic class _3d_cube_132 extends MovieClip
   {
      
      public function _3d_cube_132()
      {
         super();
         addFrameScript(98,this.frame99,179,this.frame180,209,this.frame210);
      }
      
      internal function frame99() : *
      {
         switch(int(Math.ceil(Math.random() * 4)))
         {
            case 1:
               gotoAndPlay("appearCube");
               break;
            default:
               gotoAndPlay("idle");
         }
      }
      
      internal function frame180() : *
      {
         switch(int(Math.ceil(Math.random() * 4)))
         {
            case 1:
               gotoAndPlay("disappearPlasma");
               break;
            default:
               gotoAndPlay("idlePlasma");
         }
      }
      
      internal function frame210() : *
      {
         gotoAndPlay("idle");
      }
   }
}

