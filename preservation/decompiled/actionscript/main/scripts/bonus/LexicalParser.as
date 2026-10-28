package bonus
{
   import bonus.errors.WaitingForAttributeError;
   import bonus.states.BaseState;
   import bonus.states.WaitingForAttribute;
   import bonus.states.WaitingForClass;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LexicalParser extends EventDispatcher
   {
      
      public static var fileName:String;
      
      public static const START_PARSING_CLASS:String = "StartParsingClass";
      
      public static const END_CLASS:String = "EndClass";
      
      public static const END_ATTRIBUTE:String = "EndAttribute";
      
      public static const START_ARRAY:String = "StartArray";
      
      public static const END_ARRAY:String = "EndArray";
      
      public static const INTEGER:int = 0;
      
      public static const FLOAT:int = 1;
      
      public static const STRING:int = 2;
      
      public static const BOOLEAN:int = 3;
      
      public static const CLASS:int = 4;
      
      public static const ARRAY:int = 5;
      
      public static const CLASSARRAY:int = 6;
      
      private var stream:FileStream;
      
      private var state:BaseState;
      
      public function LexicalParser(param1:String)
      {
         super();
         this.state = new WaitingForClass();
         this.registerListeners(this.state);
         fileName = param1;
      }
      
      private function registerListeners(param1:BaseState) : void
      {
         param1.addEventListener(START_PARSING_CLASS,this.eventDispatch,false,0,true);
         param1.addEventListener(END_CLASS,this.eventDispatch,false,0,true);
         param1.addEventListener(END_ATTRIBUTE,this.eventDispatch,false,0,true);
         param1.addEventListener(START_ARRAY,this.eventDispatch,false,0,true);
         param1.addEventListener(END_ARRAY,this.eventDispatch,false,0,true);
      }
      
      private function eventDispatch(param1:Event) : void
      {
         dispatchEvent(Event(param1));
      }
      
      public function parse(param1:String) : void
      {
         var _loc2_:String = null;
         this.stream = new FileStream(param1);
         while(this.stream.hasData())
         {
            this.state = this.state.process(this.stream);
            this.registerListeners(this.state);
         }
         if(this.state is WaitingForAttribute)
         {
            throw new WaitingForAttributeError("End of input",this.stream.getLineNumber());
         }
      }
   }
}

