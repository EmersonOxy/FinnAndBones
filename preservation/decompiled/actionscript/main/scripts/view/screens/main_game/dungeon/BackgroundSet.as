package view.screens.main_game.dungeon
{
   import flash.display.MovieClip;
   import util.ProbabilisticSet;
   
   public class BackgroundSet
   {
      
      public var types:ProbabilisticSet;
      
      public function BackgroundSet(param1:Array)
      {
         var _loc2_:String = null;
         super();
         this.types = new ProbabilisticSet();
         for each(_loc2_ in param1)
         {
            this.types.add(_loc2_,1);
         }
      }
      
      public function getBackground() : MovieClip
      {
         var _loc1_:String = this.types.getElement() as String;
         var _loc2_:Class = main.swfLoader.getClass("assets." + _loc1_);
         return new _loc2_();
      }
   }
}

