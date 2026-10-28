package cb.actions
{
   import flash.display.MovieClip;
   
   public class RemoveFromParent implements Action
   {
      
      public function RemoveFromParent()
      {
         super();
      }
      
      public function execute(param1:MovieClip) : void
      {
         param1.parent.removeChild(param1);
      }
   }
}

