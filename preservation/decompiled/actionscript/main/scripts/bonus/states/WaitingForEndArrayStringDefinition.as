package bonus.states
{
   import bonus.LexicalParser;
   
   public class WaitingForEndArrayStringDefinition extends BaseState
   {
      
      public function WaitingForEndArrayStringDefinition(param1:String, param2:String, param3:BaseState = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == ",")
         {
            constantDefinition(LexicalParser.ARRAY,value);
            return new ArrayDefinition(name,parent);
         }
         if(param1 == "}")
         {
            stream.ungetc();
            constantDefinition(LexicalParser.ARRAY,value);
            return new ArrayDefinition(name,parent);
         }
         return this;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
   }
}

