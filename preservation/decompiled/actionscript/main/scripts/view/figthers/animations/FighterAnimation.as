package view.figthers.animations
{
   import cb.actions.Functor;
   import cb.conditions.AnimationLabelAt;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import cb.signals.Signal;
   import conditions.Or;
   import flash.display.MovieClip;
   import main_game.element.Element;
   import view.figthers.FighterView;
   
   public class FighterAnimation implements IFighterAnimation
   {
      
      private var atFinish:Signal;
      
      protected var name:String;
      
      protected var current_mc:MovieClip;
      
      protected var current_smc:SmartMC;
      
      public function FighterAnimation(param1:String)
      {
         super();
         this.name = param1;
         this.atFinish = new Signal();
      }
      
      public function getAtFinish() : Signal
      {
         return this.atFinish;
      }
      
      public function forceKill() : Boolean
      {
         return false;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function make(param1:FighterView) : void
      {
         param1.playAnimation(this);
         this.current_mc = param1.getMC();
         this.current_smc = new SmartMC(this.current_mc);
         this.current_smc.trigger(new Or(new AnimationLabelAt("end_animation"),new EndAnimation()),new Functor(this.finish));
      }
      
      protected function finish(param1:MovieClip) : void
      {
         this.clearMc();
         this.atFinish.emit(this);
         this.atFinish.clear();
      }
      
      protected function setEffect(param1:MovieClip, param2:Element = null) : void
      {
         var _loc3_:String = null;
         if(param1.fx)
         {
            _loc3_ = "normal";
            if(Boolean(param2) && param2.isOfFire)
            {
               _loc3_ = "fire";
            }
            else if(Boolean(param2) && param2.isOfIce)
            {
               _loc3_ = "ice";
            }
            if(param1.fx)
            {
               param1.fx.gotoAndStop(_loc3_);
            }
         }
      }
      
      public function pause() : void
      {
         this.current_mc.stop();
      }
      
      public function resume() : void
      {
         this.current_mc.play();
      }
      
      private function clearMc() : void
      {
         if(this.current_smc != null)
         {
            this.current_smc.clear();
         }
         this.current_smc = null;
         if(this.current_mc != null)
         {
            this.current_mc.stop();
         }
         this.current_mc = null;
      }
      
      public function kill() : void
      {
         this.clearMc();
         this.atFinish.clear();
      }
      
      public function mustGoToIdle() : Boolean
      {
         return true;
      }
   }
}

