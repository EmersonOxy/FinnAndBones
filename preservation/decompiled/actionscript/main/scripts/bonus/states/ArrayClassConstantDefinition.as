package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.ClassDefinitionError;
   import bonus.events.ParseEvent;
   
   public class ArrayClassConstantDefinition extends BaseState
   {
      
      public function ArrayClassConstantDefinition(param1:String, param2:BaseState = null)
      {
         super(param1,"",param2);
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return addToValue(param1);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         if(value == "")
         {
            throw new ClassDefinitionError("Class names start with letters",stream.getLineNumber());
         }
         return addToValue(param1);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "}")
         {
            stream.ungetc();
            this.endClassDef();
            return new ArrayDefinition(name,parent);
         }
         if(param1 == ",")
         {
            this.endClassDef();
            return new ArrayDefinition(name,parent);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         if(param1 == "=")
         {
            throw new ClassDefinitionError("Class names can only be formed with letters and digits",stream.getLineNumber());
         }
         return null;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      private function endClassDef() : void
      {
         var _loc1_:ParseEvent = new ParseEvent(LexicalParser.END_ATTRIBUTE);
         _loc1_.name = name;
         _loc1_.value = value;
         if(value == "true" || value == "false")
         {
            _loc1_.valueType = LexicalParser.ARRAY;
            _loc1_.value = value == "true";
         }
         else
         {
            _loc1_.valueType = LexicalParser.CLASSARRAY;
         }
         dispatchEvent(_loc1_);
      }
   }
}

