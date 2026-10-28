package bonus.states
{
   public class OneLineComment extends BaseState
   {
      
      public function OneLineComment(param1:BaseState)
      {
         super("",null,param1);
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         if(param1 == "\n")
         {
            return parent;
         }
         return this;
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         return this;
      }
   }
}

