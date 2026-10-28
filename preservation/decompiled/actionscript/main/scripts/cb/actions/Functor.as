package cb.actions
{
   import flash.display.MovieClip;
   
   public class Functor implements Action
   {
      
      private var f:Function;
      
      private var params:Array;
      
      public function Functor(param1:Function, ... rest)
      {
         super();
         this.f = param1;
         this.params = rest;
      }
      
      public static function wrap(param1:Function) : Functor
      {
         var funcToWrap:Function = param1;
         return new Functor(function(param1:MovieClip):void
         {
            funcToWrap();
         });
      }
      
      public function execute(param1:MovieClip) : void
      {
         if(this.params.length == 0)
         {
            this.f(param1);
         }
         else
         {
            this.f(param1,this.params);
         }
      }
   }
}

