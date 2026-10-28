package
{
   public function assert(param1:Boolean, param2:String) : void
   {
      if(!param1)
      {
         throw new Error(param2);
      }
   }
}

