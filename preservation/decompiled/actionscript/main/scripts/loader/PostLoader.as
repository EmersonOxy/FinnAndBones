package loader
{
   import aplication.BasicState;
   import aplication.FSM;
   import aplication.State;
   import cb.logger.Appender;
   import cb.logger.JSConsoleAppender;
   import cb.logger.Log;
   import cb.signals.Signal;
   import util.Util;
   
   public class PostLoader implements DynamicLoader
   {
      
      protected static const NEXT:String = "next";
      
      protected var fsm:FSM;
      
      protected var states:Array;
      
      private var theOnLoad:Signal;
      
      private var theLoader:ResourceLoader;
      
      public function PostLoader(param1:Array, param2:ResourceLoader)
      {
         super();
         this.theLoader = param2;
         this.states = param1;
         this.theOnLoad = new Signal();
         log.addAppender(new Appender());
         log.addAppender(new JSConsoleAppender());
         this.initFSM();
      }
      
      protected static function get log() : Log
      {
         return Log.getLogger("PostLoader");
      }
      
      public function get onLoad() : Signal
      {
         return this.theOnLoad;
      }
      
      public function isLoaded(param1:String) : Boolean
      {
         var _loc2_:String = this.fsm.getActualState().getName();
         if(_loc2_ == "end")
         {
            return true;
         }
         return this.states.indexOf(param1) < this.states.indexOf(_loc2_);
      }
      
      private function initFSM() : void
      {
         var _loc2_:String = null;
         var _loc3_:State = null;
         var _loc4_:State = null;
         var _loc1_:State = new BasicState("init");
         this.fsm = new FSM(_loc1_);
         for each(_loc2_ in this.states)
         {
            _loc4_ = _loc1_;
            _loc1_ = new BasicState(_loc2_,this.enterToState,this.resourceLoaded);
            this.fsm.addState(_loc1_);
            this.fsm.addTransition(_loc4_.getName(),_loc1_.getName(),NEXT);
         }
         _loc3_ = new BasicState("end",this.endLoad);
         this.fsm.addState(_loc3_);
         this.fsm.addTransition(_loc1_.getName(),_loc3_.getName(),NEXT);
      }
      
      public function start() : void
      {
         if(this.fsm.getActualState().getName() == "init")
         {
            this.fsm.takeTransition(NEXT);
         }
      }
      
      private function enterToState() : void
      {
         this.onLoad.emit();
         this.theLoader.load(this.fsm.getActualState().getName(),Util.l(this.fsm.takeTransition,NEXT));
      }
      
      protected function resourceLoaded() : void
      {
         log.log("Loaded: " + this.fsm.getActualState().getName());
      }
      
      protected function endLoad() : void
      {
         this.onLoad.emit();
      }
   }
}

