package view.figthers.animations
{
   import flash.display.MovieClip;
   import view.figthers.FighterView;
   
   public class RunAnimation extends FighterAnimation
   {
      
      private var fighter:FighterView;
      
      private var steps:uint;
      
      private var withStart:Boolean;
      
      private var withFinish:Boolean;
      
      public function RunAnimation(param1:uint, param2:Boolean = true, param3:Boolean = true)
      {
         var _loc4_:String = null;
         this.steps = param1;
         this.withFinish = param3;
         this.withStart = param2;
         if(param2)
         {
            _loc4_ = "idle2run";
         }
         else
         {
            _loc4_ = "run";
         }
         super(_loc4_);
      }
      
      override public function make(param1:FighterView) : void
      {
         this.fighter = param1;
         super.make(param1);
      }
      
      override protected function finish(param1:MovieClip) : void
      {
         switch(name)
         {
            case "idle2run":
               this.name = "run";
               this.make(this.fighter);
               break;
            case "run":
               --this.steps;
               if(this.steps == 0)
               {
                  if(!this.withFinish)
                  {
                     this.realFinish();
                     return;
                  }
                  this.name = "run2idle";
               }
               this.make(this.fighter);
               break;
            case "run2idle":
               this.realFinish();
         }
      }
      
      override public function forceKill() : Boolean
      {
         return true;
      }
      
      private function realFinish() : void
      {
         super.finish(null);
      }
   }
}

