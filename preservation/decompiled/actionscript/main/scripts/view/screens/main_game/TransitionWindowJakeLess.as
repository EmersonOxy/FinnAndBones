package view.screens.main_game
{
   public class TransitionWindowJakeLess extends TransitionWindow
   {
      
      public function TransitionWindowJakeLess(param1:Array, param2:Function, param3:Function = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get assetClass() : Class
      {
         return main.swfLoader.getClass("assets.loadingJakeless");
      }
   }
}

