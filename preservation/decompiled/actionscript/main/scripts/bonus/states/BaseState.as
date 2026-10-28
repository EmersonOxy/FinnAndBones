package bonus.states
{
   import bonus.FileStream;
   import bonus.LexicalParser;
   import bonus.errors.GenericError;
   import bonus.events.ParseEvent;
   import flash.events.EventDispatcher;
   
   public class BaseState extends EventDispatcher
   {
      
      protected var stream:FileStream;
      
      protected var name:String;
      
      protected var value:String;
      
      protected var parent:BaseState;
      
      public function BaseState(param1:String = null, param2:String = null, param3:BaseState = null)
      {
         super();
         this.name = param1;
         this.value = param2;
         this.parent = param3;
      }
      
      protected function onLetter(param1:String) : BaseState
      {
         this.error(param1);
         return null;
      }
      
      protected function onSpace(param1:String) : BaseState
      {
         this.error(param1);
         return null;
      }
      
      protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         this.error(param1);
         return null;
      }
      
      protected function onDigit(param1:String) : BaseState
      {
         this.error(param1);
         return null;
      }
      
      public function process(param1:FileStream) : BaseState
      {
         this.stream = param1;
         var _loc2_:String = param1.getc();
         var _loc3_:int = _loc2_.charCodeAt(0);
         if(_loc3_ >= 65 && _loc3_ <= 90 || _loc3_ >= 97 && _loc3_ <= 122)
         {
            return this.onLetter(_loc2_);
         }
         if(_loc3_ >= 48 && _loc3_ <= 57)
         {
            return this.onDigit(_loc2_);
         }
         if(_loc3_ == 10 || _loc3_ == 9 || _loc3_ == 13 || _loc3_ == 32)
         {
            return this.onSpace(_loc2_);
         }
         return this.onMisc(_loc2_);
      }
      
      protected function constantDefinition(param1:int, param2:Object) : void
      {
         var _loc3_:ParseEvent = new ParseEvent(LexicalParser.END_ATTRIBUTE);
         _loc3_.name = this.name;
         _loc3_.value = param2;
         _loc3_.valueType = param1;
         dispatchEvent(_loc3_);
      }
      
      protected function classNameDefinition(param1:String) : void
      {
         var _loc2_:ParseEvent = new ParseEvent(LexicalParser.START_PARSING_CLASS);
         _loc2_.name = param1;
         dispatchEvent(_loc2_);
      }
      
      protected function addToValue(param1:String) : BaseState
      {
         this.value += param1;
         return this;
      }
      
      protected function addToName(param1:String) : BaseState
      {
         this.name += param1;
         return this;
      }
      
      protected function error(param1:String) : void
      {
         throw new GenericError(LexicalParser.fileName,"Generic error. unexpected char \'" + param1 + "\'",this.stream.getLineNumber());
      }
   }
}

