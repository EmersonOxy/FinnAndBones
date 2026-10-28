package bonus.errors
{
   import bonus.LexicalParser;
   
   public class ClassDefinitionError extends GenericError
   {
      
      public function ClassDefinitionError(param1:String, param2:int)
      {
         super(LexicalParser.fileName,param1,param2);
      }
   }
}

