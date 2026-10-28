package main_game.character.stats
{
   import cb.signals.Signal;
   import flash.utils.Dictionary;
   import main_game.character.CharacterConfigData;
   import main_game.character.Fighter;
   
   public class Stats
   {
      
      protected var levelingStrat:LevelingStragegy;
      
      protected var stats:Dictionary;
      
      protected var fighter:Fighter;
      
      protected var guardian:StatsEffectGuardian;
      
      public var onChange:Signal;
      
      public function Stats(param1:CharacterConfigData, param2:Fighter, param3:LevelingStragegy)
      {
         super();
         this.onChange = new Signal();
         this.levelingStrat = param3;
         this.fighter = param2;
         this.guardian = new StatsEffectGuardian(this);
         this.stats = new Dictionary();
         this.parseInitialStats(param1);
      }
      
      protected function parseInitialStats(param1:CharacterConfigData) : void
      {
         this.stats[StatType.ATTACK] = new Stat(StatType.ATTACK,param1.baseAttack);
         this.stats[StatType.DEFENSE] = new Stat(StatType.DEFENSE,param1.baseDefense);
         this.stats[StatType.LUCK] = new Stat(StatType.LUCK,param1.baseLuck);
         this.stats[StatType.BASE_ATTACK] = new Stat(StatType.BASE_ATTACK,param1.baseAttack);
         this.stats[StatType.BASE_DEFENSE] = new Stat(StatType.BASE_DEFENSE,param1.baseDefense);
         this.stats[StatType.BASE_LUCK] = new Stat(StatType.BASE_LUCK,param1.baseLuck);
         this.stats[StatType.BASE_HEALTH] = new Stat(StatType.BASE_HEALTH,param1.baseHP);
      }
      
      public function getEffectGuardian() : StatsEffectGuardian
      {
         return this.guardian;
      }
      
      public function getLevel() : uint
      {
         throw new Error("Must implement this method");
      }
      
      public function getStat(param1:int) : Stat
      {
         return this.stats[param1];
      }
      
      public function downHP(param1:uint) : void
      {
         this.stats[StatType.HEALTH].modifyValue(-param1);
         this.onChange.emit();
      }
      
      public function addXP(param1:uint) : void
      {
         this.stats[StatType.EXPERIENCE].modifyValue(param1);
         this.onChange.emit();
      }
      
      public function refillHealth() : void
      {
         this.stats[StatType.HEALTH].fill(100);
         this.onChange.emit();
      }
      
      public function getDefense() : Number
      {
         return this.getStat(StatType.DEFENSE).getValue();
      }
      
      public function getAttack() : Number
      {
         return this.getStat(StatType.ATTACK).getValue();
      }
      
      public function getLuck() : Number
      {
         return this.getStat(StatType.LUCK).getValue();
      }
      
      public function clear() : void
      {
         var _loc1_:Stat = null;
         this.fighter = null;
         this.guardian.clear();
         this.onChange.clear();
         for each(_loc1_ in this.stats)
         {
            _loc1_.clear();
         }
      }
      
      public function isDead() : Boolean
      {
         return this.getStat(StatType.HEALTH).getValue() == 0;
      }
      
      public function leveling(param1:uint) : void
      {
         this.levelingStrat.level(param1,this);
      }
      
      public function loadData() : void
      {
      }
   }
}

