package main_game.character.stats
{
   import main_game.character.CharacterConfigData;
   import main_game.character.Fighter;
   
   public class FinnStats extends Stats
   {
      
      public function FinnStats(param1:CharacterConfigData, param2:Fighter)
      {
         var _loc3_:Object = main.config.get("Leveling_Finn");
         super(param1,param2,new LevelingStragegy(_loc3_));
         stats[StatType.HEALTH] = new HealthStat(StatType.HEALTH,new Stat(StatType.MAX_HP,param1.baseHP),0);
         stats[StatType.EXPERIENCE] = new PersistentExperience(this);
      }
      
      override public function getLevel() : uint
      {
         return (stats[StatType.EXPERIENCE] as Experience).getLevel();
      }
      
      override public function loadData() : void
      {
         (stats[StatType.EXPERIENCE] as PersistentExperience).startPersistence();
      }
   }
}

