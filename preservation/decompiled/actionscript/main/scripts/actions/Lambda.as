package actions
{
   import cb.actions.Action;
   import flash.display.MovieClip;
   
   public class Lambda implements Action
   {
      
      private var f:Function;
      
      private var params:Array;
      
      public function Lambda(param1:Function, ... rest)
      {
         super();
         this.f = param1;
         this.params = rest;
      }
      
      public static function wrap(param1:Function, ... rest) : Lambda
      {
         var funcToWrap:Function = param1;
         var args:Array = rest;
         return new Lambda(function(param1:MovieClip):void
         {
            if(args.length == 0)
            {
               funcToWrap();
            }
            else
            {
               funcToWrap.apply(null,args);
            }
         });
      }
      
      public function execute(param1:MovieClip) : void
      {
         if(this.params.length == 0)
         {
            this.f.apply(null,[param1]);
         }
         else
         {
            this.params.splice(0,0,param1);
            this.f.apply(null,this.params);
         }
      }
   }
}

