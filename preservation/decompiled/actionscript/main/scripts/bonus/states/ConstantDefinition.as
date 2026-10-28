package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.ConstantDefinitionError;
   
   public class ConstantDefinition extends BaseState
   {
      
      public function ConstantDefinition(param1:String)
      {
         super(param1,"");
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         return addToValue(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         constantDefinition(LexicalParser.INTEGER,int(value));
         return new WaitingForAttribute();
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.INTEGER,int(value));
            return new WaitingForAttribute();
         }
         if(param1 == ".")
         {
            value += param1;
            return new FloatConstantDefinition(name,value);
         }
         if(param1 == "-" && value == "")
         {
            value += param1;
            return this;
         }
         throw new ConstantDefinitionError("Expected a digit. got [" + param1 + "]",stream.getLineNumber());
      }
   }
}

