package bonus.errors
{
   import bonus.LexicalParser;
   
   public class CommentError extends GenericError
   {
      
      public function CommentError(param1:String, param2:int)
      {
         super(LexicalParser.fileName,"Expected \'/\' or \'*\' to start comment, but got" + param1 + ".",param2);
      }
   }
}

