package bonus.states
{
   import bonus.LexicalParser;
   import bonus.events.ParseEvent;
   
   public class ArrayDefinition extends BaseState
   {
      
      public function ArrayDefinition(param1:String, param2:BaseState = null)
      {
         super(param1,"",param2);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         var _loc2_:ParseEvent = null;
         if(param1 == "}")
         {
            _loc2_ = new ParseEvent(LexicalParser.END_ARRAY);
            _loc2_.name = name;
            _loc2_.value = value;
            _loc2_.valueType = LexicalParser.ARRAY;
            dispatchEvent(_loc2_);
            return new WaitingForAttribute(parent);
         }
         if(param1 == "{")
         {
            dispatchEvent(new ParseEvent(LexicalParser.START_ARRAY));
            return new ArrayDefinition(name,this);
         }
         if(param1 == "\"" || param1 == "\'")
         {
            return new ArrayStringDefinition(param1,name,parent);
         }
         if(param1 == "-" && value == "")
         {
            return this.onDigit(param1);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         return null;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         stream.ungetc();
         return new ArrayClassConstantDefinition(name,parent);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         stream.ungetc();
         return new ArrayConstantDefinition(name,parent);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
   }
}

