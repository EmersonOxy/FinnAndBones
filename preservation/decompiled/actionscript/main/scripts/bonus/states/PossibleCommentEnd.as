package bonus.states
{
   public class PossibleCommentEnd extends BaseState
   {
      
      public function PossibleCommentEnd(param1:BaseState)
      {
         super("",null,param1);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "/")
         {
            return parent;
         }
         return new MultipleLineComment(parent);
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         return new MultipleLineComment(parent);
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return new MultipleLineComment(parent);
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return new MultipleLineComment(parent);
      }
   }
}

