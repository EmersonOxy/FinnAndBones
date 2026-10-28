package aplication
{
   public class FSM
   {
      
      private var states:Array;
      
      private var actual_state:State;
      
      public function FSM(param1:State)
      {
         super();
         this.states = new Array();
         this.actual_state = param1;
         this.addState(this.actual_state);
      }
      
      public function start() : void
      {
         this.getActualState().enter();
      }
      
      public function addState(param1:State) : void
      {
         this.states.push(param1);
      }
      
      public function addTransition(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:State = this.getState(param1);
         var _loc5_:State = this.getState(param2);
         this.checkState(_loc4_);
         this.checkState(_loc5_);
         _loc4_.addTransition(_loc5_,param3);
      }
      
      public function getState(param1:String) : State
      {
         var _loc2_:State = null;
         for each(_loc2_ in this.states)
         {
            if(param1 == _loc2_.getName())
            {
               return _loc2_;
            }
         }
         throw new Error("No existe estado con nombre " + param1);
      }
      
      public function takeTransition(param1:String) : void
      {
         this.getActualState().leave();
         this.actual_state = this.getActualState().getTargetForTransition(param1);
         this.getActualState().enter();
      }
      
      public function getActualState() : State
      {
         return this.actual_state;
      }
      
      private function checkState(param1:State) : void
      {
         if(this.states.indexOf(param1) < 0)
         {
            throw new Error("Estado " + param1.getName() + " no se encuentra en la FSM");
         }
      }
      
      public function clear() : void
      {
         var _loc1_:State = null;
         for each(_loc1_ in this.states)
         {
            _loc1_.clear();
         }
         this.states = null;
         this.actual_state = null;
      }
   }
}

