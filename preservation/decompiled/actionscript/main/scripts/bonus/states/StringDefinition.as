package bonus.states
{
   import bonus.LexicalParser;
   
   public class StringDefinition extends BaseState
   {
      
      private var startSymbol:String;
      
      public function StringDefinition(param1:String, param2:String)
      {
         super(param2,"");
         this.startSymbol = param1;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == this.startSymbol)
         {
            constantDefinition(LexicalParser.STRING,value);
            return new WaitingForAttribute();
         }
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.STRING,value);
            return new WaitingForAttribute();
         }
         value += param1;
         return this;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
   }
}

