package cb.utils
{
   public class Random
   {
      
      public function Random()
      {
         super();
      }
      
      public static function nextInt(param1:int) : int
      {
         return Math.floor(Math.random() * (param1 + 1));
      }
      
      public static function nextRange(param1:int, param2:int) : int
      {
         return nextInt(param2 - param1) + param1;
      }
   }
}

