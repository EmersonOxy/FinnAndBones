package bonus.states
{
   public class MultipleLineComment extends OneLineComment
   {
      
      public function MultipleLineComment(param1:BaseState)
      {
         super(param1);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "*")
         {
            return new PossibleCommentEnd(parent);
         }
         return this;
      }
   }
}

