package bonus.states
{
   import bonus.errors.ClassDefinitionError;
   
   public class ClassDefinition extends BaseState
   {
      
      public function ClassDefinition()
      {
         super("");
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return addToName(param1);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         if(name == "")
         {
            throw new ClassDefinitionError("Class names start with letters",stream.getLineNumber());
         }
         return addToName(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         classNameDefinition(name);
         return new WaitingForEndClass();
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "{")
         {
            classNameDefinition(name);
            return new WaitingForAttribute();
         }
         if(param1 == "_")
         {
            return this.onLetter(param1);
         }
         throw new ClassDefinitionError("Class names can\'t contain [" + param1 + "] character",stream.getLineNumber());
      }
   }
}

