package view.items.modifiers
{
   import flash.display.MovieClip;
   
   public class NullShieldModifier implements IAnimationModifier
   {
      
      public function NullShieldModifier()
      {
         super();
      }
      
      public function modify(param1:MovieClip) : void
      {
         param1.stop();
         param1.visible = false;
      }
   }
}

