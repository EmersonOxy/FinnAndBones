package main_game.items.modifiers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   import util.Util;
   
   public class NullModifier implements IModifier
   {
      
      public function NullModifier()
      {
         super();
      }
      
      public function modifyIcon(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
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
      
      public function modifyValue(param1:TextField, param2:int) : void
      {
         param1.text = "";
      }
      
      public function affect(param1:Stats) : void
      {
      }
      
      public function disaffect(param1:Stats) : void
      {
      }
      
      public function getValue() : Number
      {
         return 0;
      }
      
      public function getCategory() : int
      {
         return StatType.NULL;
      }
      
      public function isInstant() : Boolean
      {
         return true;
      }
      
      public function clear() : void
      {
      }
      
      public function toObject() : *
      {
         return {
            "Category":null,
            "Value":null
         };
      }
   }
}

