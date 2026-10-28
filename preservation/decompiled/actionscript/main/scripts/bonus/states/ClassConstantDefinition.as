package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.ClassDefinitionError;
   import bonus.events.ParseEvent;
   
   public class ClassConstantDefinition extends BaseState
   {
      
      public function ClassConstantDefinition(param1:String)
      {
         super(param1,"");
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return addToValue(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         this.endConstantDef();
         return new WaitingForAttribute();
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
            this.endConstantDef();
            return new WaitingForAttribute();
         }
         throw new ClassDefinitionError("Class names can\'t contain [" + param1 + "] character",stream.getLineNumber());
      }
      
      private function endConstantDef() : void
      {
         var _loc1_:ParseEvent = new ParseEvent(LexicalParser.END_ATTRIBUTE);
         _loc1_.name = name;
         _loc1_.value = value;
         if(value == "true" || value == "false")
         {
            _loc1_.value = value == "true";
         }
         else
         {
            _loc1_.valueType = LexicalParser.CLASS;
         }
         dispatchEvent(_loc1_);
      }
   }
}

