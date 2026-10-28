package view.items.modifiers
{
   import flash.display.MovieClip;
   
   public class SwordModifier extends SimpleAnimationModifier
   {
      
      public function SwordModifier(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function setModifier(param1:MovieClip, param2:String) : void
      {
         setIcon(param1.sword.gem,param2);
      }
   }
}

