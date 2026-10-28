package bonus.states
{
   public class WaitingForClass extends BaseState
   {
      
      public function WaitingForClass()
      {
         super();
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         stream.ungetc();
         return new ClassDefinition();
      }
   }
}

