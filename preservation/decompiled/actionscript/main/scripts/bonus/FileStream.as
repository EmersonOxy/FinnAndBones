package bonus
{
   public class FileStream
   {
      
      private var file:String;
      
      private var pos:int = 0;
      
      private var line:int = 1;
      
      public function FileStream(param1:String)
      {
         super();
         this.file = param1;
      }
      
      public function hasData() : Boolean
      {
         return this.file.charAt(this.pos) != "";
      }
      
      public function getLineNumber() : int
      {
         return this.line;
      }
      
      public function getc() : String
      {
         var _loc1_:String = this.file.charAt(this.pos);
         ++this.pos;
         if(_loc1_ == "\n")
         {
            ++this.line;
         }
         return _loc1_;
      }
      
      public function ungetc() : void
      {
         --this.pos;
         if(this.file.charAt(this.pos) == "\n")
         {
            --this.line;
         }
         if(this.pos < 0)
         {
            this.pos = 0;
         }
      }
   }
}

