package conditions
{
   import cb.conditions.Condition;
   import flash.display.MovieClip;
   
   public class Or implements Condition
   {
      
      private var c1:Condition;
      
      private var c2:Condition;
      
      public function Or(param1:Condition, param2:Condition)
      {
         super();
         this.c1 = param1;
         this.c2 = param2;
      }
      
      public function complete(param1:MovieClip) : Boolean
      {
         return this.c1.complete(param1) || this.c2.complete(param1);
      }
   }
}

