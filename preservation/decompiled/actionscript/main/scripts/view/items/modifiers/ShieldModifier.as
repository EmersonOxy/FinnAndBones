package view.items.modifiers
{
   import flash.display.MovieClip;
   
   public class ShieldModifier extends SimpleAnimationModifier
   {
      
      public function ShieldModifier(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function setModifier(param1:MovieClip, param2:String) : void
      {
         setIcon(param1.shield.shield.gem,param2);
      }
   }
}

