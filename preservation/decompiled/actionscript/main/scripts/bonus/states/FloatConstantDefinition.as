package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.ConstantDefinitionError;
   
   public class FloatConstantDefinition extends BaseState
   {
      
      public function FloatConstantDefinition(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         return addToValue(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         constantDefinition(LexicalParser.FLOAT,Number(value));
         return new WaitingForAttribute();
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.FLOAT,Number(value));
            return new WaitingForAttribute();
         }
         throw new ConstantDefinitionError("Expected a digit. got [" + param1 + "]",stream.getLineNumber());
      }
   }
}

