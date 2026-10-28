package aplication
{
   import cb.logger.Log;
   import flash.utils.Dictionary;
   
   public class BasicState implements State
   {
      
      private static var log:Log = Log.getLogger("FSMLogger");
      
      private var name:String;
      
      private var transitions:Dictionary;
      
      private var onEnter:Function;
      
      private var onLeave:Function;
      
      public var persistency:Object = {};
      
      public function BasicState(param1:String, param2:Function = null, param3:Function = null)
      {
         super();
         this.name = param1;
         this.transitions = new Dictionary();
         this.onEnter = param2;
         this.onLeave = param3;
      }
      
      public function enter() : void
      {
         log.log("Enter to state: " + this.getName());
         if(this.onEnter != null)
         {
            this.onEnter();
         }
      }
      
      public function leave() : void
      {
         log.log("Leave from state: " + this.getName());
         if(this.onLeave != null)
         {
            this.onLeave();
         }
      }
      
      public function addTransition(param1:State, param2:String) : void
      {
         this.transitions[param2] = param1;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getTargetForTransition(param1:String) : State
      {
         var _loc2_:State = this.transitions[param1];
         if(_loc2_ == null)
         {
            throw new Error("Transicion " + param1 + " no definida para estado " + this.getName());
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         this.onEnter = null;
         this.onLeave = null;
         this.transitions = null;
         this.persistency = null;
      }
   }
}

