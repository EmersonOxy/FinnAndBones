package aplication
{
   public interface State
   {
      
      function enter() : void;
      
      function leave() : void;
      
      function addTransition(param1:State, param2:String) : void;
      
      function getName() : String;
      
      function getTargetForTransition(param1:String) : State;
      
      function clear() : void;
   }
}

