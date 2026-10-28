package bonus.states
{
   import bonus.errors.CommentError;
   
   public class PossibleComment extends BaseState
   {
      
      public function PossibleComment(param1:BaseState)
      {
         super(null,null,param1);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "*")
         {
            return new MultipleLineComment(parent);
         }
         if(param1 == "/")
         {
            return new OneLineComment(parent);
         }
         throw new CommentError(param1,stream.getLineNumber());
      }
   }
}

