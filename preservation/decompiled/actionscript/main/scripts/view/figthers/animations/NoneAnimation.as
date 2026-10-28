package view.figthers.animations
{
   import cb.signals.Signal;
   import view.figthers.FighterView;
   
   public class NoneAnimation implements IFighterAnimation
   {
      
      private var atFinish:Signal;
      
      public function NoneAnimation()
      {
         super();
         this.atFinish = new Signal();
      }
      
      public function forceKill() : Boolean
      {
         return false;
      }
      
      public function getName() : String
      {
         return "";
      }
      
      public function make(param1:FighterView) : void
      {
      }
      
      public function pause() : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function kill() : void
      {
         this.atFinish.clear();
         this.atFinish = null;
      }
      
      public function getAtFinish() : Signal
      {
         return this.atFinish;
      }
      
      public function mustGoToIdle() : Boolean
      {
         return false;
      }
   }
}

