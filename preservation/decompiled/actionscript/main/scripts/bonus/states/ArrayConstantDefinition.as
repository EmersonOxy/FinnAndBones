package bonus.states
{
   import bonus.LexicalParser;
   
   public class ArrayConstantDefinition extends BaseState
   {
      
      public function ArrayConstantDefinition(param1:String, param2:BaseState = null)
      {
         super(param1,"",param2);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         return addToValue(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         stream.ungetc();
         return new ArrayClassConstantDefinition(name);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.ARRAY,int(value));
            return new ArrayDefinition(name,parent);
         }
         if(param1 == ".")
         {
            value += param1;
            return new ArrayFloatConstantDefinition(name,value,parent);
         }
         if(param1 == ",")
         {
            constantDefinition(LexicalParser.ARRAY,int(value));
            return new ArrayDefinition(name,parent);
         }
         if(param1 == "-")
         {
            return this.onDigit(param1);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         return null;
      }
   }
}

