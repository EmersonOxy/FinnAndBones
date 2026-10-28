package bonus.states
{
   public class ArrayStringDefinition extends BaseState
   {
      
      private var startSymbol:String;
      
      public function ArrayStringDefinition(param1:String, param2:String, param3:BaseState = null)
      {
         super(param2,"",param3);
         this.startSymbol = param1;
      }
      
      override protected function onMisc(param1:String) : BaseState
      {
         if(param1 == this.startSymbol)
         {
            return new WaitingForEndArrayStringDefinition(name,value,parent);
         }
         value += param1;
         return this;
      }
      
      override protected function onLetter(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
      
      override protected function onDigit(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
      
      override protected function onSpace(param1:String) : BaseState
      {
         value += param1;
         return this;
      }
   }
}

