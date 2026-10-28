package bonus.errors
{
   import bonus.LexicalParser;
   
   public class ConstantDefinitionError extends GenericError
   {
      
      public function ConstantDefinitionError(param1:String, param2:int)
      {
         super(LexicalParser.fileName,param1,param2);
      }
   }
}

