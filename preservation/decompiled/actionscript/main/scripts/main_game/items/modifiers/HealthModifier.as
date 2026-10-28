package main_game.items.modifiers
{
   import flash.display.MovieClip;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   
   public class HealthModifier extends Modifier
   {
      
      public function HealthModifier(param1:Object)
      {
         super(param1);
         assert(this.characteristic == StatType.HEALTH,"Health must be health");
      }
      
      override public function modifyIcon(param1:MovieClip) : void
      {
         param1.visible = true;
         param1.gotoAndStop("health");
      }
      
      override public function affect(param1:Stats) : void
      {
         super.affect(param1);
      }
      
      override public function disaffect(param1:Stats) : void
      {
      }
      
      override public function isInstant() : Boolean
      {
         return false;
      }
   }
}

