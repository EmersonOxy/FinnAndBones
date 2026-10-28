package bonus.errors
{
   import bonus.LexicalParser;
   
   public class WaitingForAttributeError extends GenericError
   {
      
      public function WaitingForAttributeError(param1:String, param2:int)
      {
         super(LexicalParser.fileName,"Expected Attribute at " + param1,param2);
      }
   }
}

