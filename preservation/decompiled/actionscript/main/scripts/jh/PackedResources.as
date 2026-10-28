package jh
{
   public class PackedResources
   {
      
      public function PackedResources()
      {
         super();
      }
      
      public function get(param1:String) : *
      {
         do
         {
            param1 = param1.replace("/","_");
         }
         while(param1.indexOf("/") >= 0);
         do
         {
            param1 = param1.replace(".","_");
         }
         while(param1.indexOf(".") >= 0);
         return this[param1];
      }
   }
}

