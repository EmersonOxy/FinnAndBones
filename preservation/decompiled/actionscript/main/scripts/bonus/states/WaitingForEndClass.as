package bonus.states
{
   import bonus.errors.WaitingForEndClassError;
   
   public class WaitingForEndClass extends BaseState
   {
      
      public function WaitingForEndClass()
      {
         super();
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         return this;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == "{")
         {
            return new WaitingForAttribute();
         }
         throw new WaitingForEndClassError(param1,stream.getLineNumber());
      }
   }
}

