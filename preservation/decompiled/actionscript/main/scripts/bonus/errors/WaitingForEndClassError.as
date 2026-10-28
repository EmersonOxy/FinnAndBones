package bonus.errors
{
   import bonus.LexicalParser;
   
   public class WaitingForEndClassError extends GenericError
   {
      
      public function WaitingForEndClassError(param1:String, param2:int)
      {
         super(LexicalParser.fileName,"Expected { but Found " + param1,param2);
      }
   }
}

