package view.items.modifiers
{
   import flash.display.MovieClip;
   import main_game.character.stats.StatType;
   import util.Util;
   
   public class SimpleAnimationModifier implements IAnimationModifier
   {
      
      private var mcName:String;
      
      private var typeModifier:String;
      
      public function SimpleAnimationModifier(param1:String, param2:String)
      {
         super();
         this.mcName = param1;
         this.typeModifier = param2;
      }
      
      public function modify(param1:MovieClip) : void
      {
         this.setFrame(param1,this.mcName);
         this.setModifier(param1,this.typeModifier);
      }
      
      protected function setFrame(param1:MovieClip, param2:String) : void
      {
         param1.gotoAndStop(this.mcName);
      }
      
      protected function setModifier(param1:MovieClip, param2:String) : void
      {
         this.setIcon(param1.icon,param2);
      }
      
      protected function setIcon(param1:MovieClip, param2:String) : void
      {
         var mc:MovieClip = param1;
         var type:String = param2;
         if(type == null)
         {
            try
            {
               mc.gotoAndStop("none");
            }
            catch(a:ArgumentError)
            {
               mc.visible = false;
               Util.recursiveStop(mc);
            }
         }
         else
         {
            StatType.setMcIcon(mc,StatType.parse(type));
         }
      }
   }
}

