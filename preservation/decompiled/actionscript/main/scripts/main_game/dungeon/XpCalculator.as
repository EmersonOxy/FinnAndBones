package main_game.dungeon
{
   import main_game.character.Enemy;
   import main_game.character.stats.Experience;
   import main_game.character.stats.StatType;
   
   public class XpCalculator implements IXpCalculator
   {
      
      public function XpCalculator()
      {
         super();
      }
      
      private function get config() : Object
      {
         return main.config.get("ExperienceBonus");
      }
      
      public function getXp(param1:Array) : int
      {
         var _loc3_:Enemy = null;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += _loc3_.stats.getStat(StatType.EXPERIENCE).getValue();
         }
         return _loc2_;
      }
      
      private function get requiredExperience() : Number
      {
         var _loc1_:Experience = main.game.getFinn().stats.getStat(StatType.EXPERIENCE) as Experience;
         return _loc1_.getUpperBound();
      }
      
      public function getMixXp(param1:int) : Number
      {
         return Math.round(Number(param1 * this.requiredExperience * this.config.mix) / 100);
      }
      
      public function getCriticalXp(param1:int) : Number
      {
         return Math.round(Number(param1 * this.requiredExperience * this.config.critical) / 100);
      }
   }
}

