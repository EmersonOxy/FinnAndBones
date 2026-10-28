package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.WaitingForConstantError;
   import bonus.events.ParseEvent;
   
   public class WaitingForConstant extends BaseState
   {
      
      public function WaitingForConstant(param1:String, param2:BaseState = null)
      {
         super(param1,null,param2);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         stream.ungetc();
         return new ConstantDefinition(name);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "\"" || param1 == "\'")
         {
            return new StringDefinition(param1,name);
         }
         if(param1 == "{")
         {
            dispatchEvent(new ParseEvent(LexicalParser.START_ARRAY));
            return new ArrayDefinition(name,parent);
         }
         if(param1 == "-")
         {
            stream.ungetc();
            return new ConstantDefinition(name);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         throw new WaitingForConstantError(LexicalParser.fileName,"got a \'" + param1 + "\'",stream.getLineNumber());
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         stream.ungetc();
         return new ClassConstantDefinition(name);
      }
   }
}

