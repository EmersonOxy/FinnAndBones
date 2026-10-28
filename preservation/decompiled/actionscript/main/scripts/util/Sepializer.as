package util
{
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   
   public class Sepializer
   {
      
      private static var instance:Sepializer;
      
      private var filter:ColorMatrixFilter;
      
      private var filter2:ColorMatrixFilter;
      
      public function Sepializer(param1:SingletonLock)
      {
         super();
         this.filter = new ColorMatrixFilter([0.39,0.76,0.189,0.01,0,0.35,0.686,0.168,0.01,0,0.27,0.534,0.131,0.01,-10,0,0,0,1,0]);
         this.filter2 = new ColorMatrixFilter([0.39,0.76,0.189,0.01,-80,0.35,0.686,0.168,0.01,-80,0.27,0.534,0.131,0.01,-70,0,0,0,1,0]);
      }
      
      public static function getInstance() : Sepializer
      {
         if(!instance)
         {
            instance = new Sepializer(new SingletonLock());
         }
         return instance;
      }
      
      public function sepialize(param1:Sprite) : void
      {
         param1.filters = [this.filter];
      }
      
      public function sepializeDark(param1:Sprite) : void
      {
         param1.filters = [this.filter2];
      }
      
      public function unsepialize(param1:Sprite) : void
      {
         param1.filters = [];
      }
   }
}

class SingletonLock
{
   
   public function SingletonLock()
   {
      super();
   }
}
