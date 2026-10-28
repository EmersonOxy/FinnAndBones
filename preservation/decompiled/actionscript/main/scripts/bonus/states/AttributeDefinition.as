package bonus.states
{
   import bonus.errors.ClassDefinitionError;
   
   public class AttributeDefinition extends BaseState
   {
      
      public function AttributeDefinition()
      {
         super("");
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return addToName(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "=")
         {
            return new WaitingForConstant(name);
         }
         if(param1 == "_")
         {
            return addToName(param1);
         }
         throw new ClassDefinitionError("Variable names can\'t contain [" + param1 + "] character",stream.getLineNumber());
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         if(name == "")
         {
            throw new ClassDefinitionError("Variable names start with letters",stream.getLineNumber());
         }
         return addToName(param1);
      }
   }
}

