package bonus.states
{
   import bonus.LexicalParser;
   
   public class ArrayFloatConstantDefinition extends BaseState
   {
      
      public function ArrayFloatConstantDefinition(param1:String, param2:String, param3:BaseState = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.ARRAY,Number(value));
            return new ArrayDefinition(name,parent);
         }
         if(param1 == ",")
         {
            constantDefinition(LexicalParser.ARRAY,Number(value));
            return new ArrayDefinition(name,parent);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         return null;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
   }
}

