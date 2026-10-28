package main_game.items.modifiers
{
   import flash.display.MovieClip;
   import main_game.character.stats.HealthStat;
   import main_game.character.stats.Stat;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   
   public class MaxHealthModifier extends Modifier
   {
      
      private var primary_char:int;
      
      public function MaxHealthModifier(param1:Object)
      {
         super(param1);
         if(this.characteristic == StatType.MAX_HP)
         {
            this.primary_char = StatType.HEALTH;
         }
         else if(this.characteristic == StatType.MAX_XP)
         {
            this.primary_char = StatType.EXPERIENCE;
         }
      }
      
      override public function modifyIcon(param1:MovieClip) : void
      {
         super.modifyIcon(param1);
         if(param1.max_health)
         {
            if(value >= 0)
            {
               param1.max_health.gotoAndStop("up");
            }
            else
            {
               param1.max_health.gotoAndStop("down");
            }
         }
      }
      
      override public function affect(param1:Stats) : void
      {
         var _loc2_:HealthStat = param1.getStat(this.primary_char) as HealthStat;
         _loc2_.modifyUpperBound(this.value);
      }
      
      override public function disaffect(param1:Stats) : void
      {
         var _loc2_:HealthStat = param1.getStat(this.primary_char) as HealthStat;
         _loc2_.modifyUpperBound(-this.value);
      }
      
      override protected function getStat(param1:Stats) : Stat
      {
         return (param1.getStat(this.primary_char) as HealthStat).getUpperBound();
      }
   }
}

