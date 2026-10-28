package view.screens.main_game.states
{
   import aplication.BasicState;
   
   public class BasicPausableState extends BasicState implements IPausable
   {
      
      public function BasicPausableState(param1:String, param2:Function = null, param3:Function = null)
      {
         super(param1,param2,param3);
      }
      
      public function pause() : void
      {
      }
      
      public function resume() : void
      {
      }
   }
}

