package view.figthers.animations
{
   import cb.signals.Signal;
   import view.figthers.FighterView;
   
   public interface IFighterAnimation
   {
      
      function make(param1:FighterView) : void;
      
      function pause() : void;
      
      function resume() : void;
      
      function kill() : void;
      
      function getAtFinish() : Signal;
      
      function mustGoToIdle() : Boolean;
      
      function getName() : String;
      
      function forceKill() : Boolean;
   }
}

