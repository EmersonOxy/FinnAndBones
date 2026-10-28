package bonus.states
{
   import bonus.LexicalParser;
   import bonus.errors.WaitingForAttributeError;
   import bonus.events.ParseEvent;
   
   public class WaitingForAttribute extends BaseState
   {
      
      public function WaitingForAttribute(param1:BaseState = null)
      {
         super(null,null,param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         var _loc2_:ParseEvent = null;
         if(param1 == "}")
         {
            if(parent)
            {
               stream.ungetc();
               return parent;
            }
            _loc2_ = new ParseEvent(LexicalParser.END_CLASS);
            dispatchEvent(_loc2_);
            return new WaitingForClass();
         }
         if(param1 == ",")
         {
            return new WaitingForConstant(null,parent);
         }
         if(param1 == "/")
         {
            return new PossibleComment(this);
         }
         throw new WaitingForAttributeError(param1,stream.getLineNumber());
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         stream.ungetc();
         return new AttributeDefinition();
      }
   }
}

