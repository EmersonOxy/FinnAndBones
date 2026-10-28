package main_game.character.stats
{
   import main_game.character.CharacterConfigData;
   import main_game.character.Fighter;
   
   public class EnemyStats extends Stats
   {
      
      protected var level:uint = 1;
      
      public function EnemyStats(param1:CharacterConfigData, param2:Fighter)
      {
         super(param1,param2,LevelingEnemies.getNewInstance(param1));
         stats[StatType.HEALTH] = new HealthStat(StatType.HEALTH,new Stat(StatType.MAX_HP,param1.baseHP),param1.baseHP);
         stats[StatType.BASE_XP] = new Stat(StatType.EXPERIENCE,param1.baseXP);
         stats[StatType.EXPERIENCE] = new Stat(StatType.EXPERIENCE,param1.baseXP);
      }
      
      override public function getLevel() : uint
      {
         return this.level;
      }
      
      override public function leveling(param1:uint) : void
      {
         this.level = levelingStrat.level(param1,this);
      }
      
      override public function loadData() : void
      {
         (stats[StatType.HEALTH] as HealthStat).fill();
      }
   }
}

