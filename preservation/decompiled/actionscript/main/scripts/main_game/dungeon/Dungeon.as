package main_game.dungeon
{
   import cb.signals.Signal;
   import main_game.boss_dungeon.BossDungeon;
   import main_game.character.CharacterFactory;
   import main_game.character.Enemy;
   import main_game.character.Finn;
   import main_game.character.Gear;
   import main_game.map.Level;
   import util.ProbabilisticSet;
   
   public class Dungeon
   {
      
      private static var theXpCalulator:IXpCalculator;
      
      public var onFight:Signal;
      
      private var loot:Loot;
      
      private var fights:Vector.<IFight>;
      
      private var current:uint;
      
      private var fighting:Boolean;
      
      protected var level:Level;
      
      protected var stats:DungeonStats;
      
      public var onLose:Signal;
      
      public var onWin:Signal;
      
      public function Dungeon(param1:Level, param2:DungeonConfigData, param3:ProbabilisticSet)
      {
         super();
         this.level = param1;
         this.fighting = false;
         this.onLose = new Signal();
         this.onWin = new Signal();
         this.onFight = new Signal();
         this.stats = new DungeonStats(param1);
         this.fights = new Vector.<IFight>();
         this.initializeFights(param2);
         this.loot = this.createLoot(param2,param3);
         this.current = 0;
      }
      
      public static function get DungeonConfig() : Object
      {
         return main.config.get("DungeonConfig");
      }
      
      public static function get xpCalulator() : IXpCalculator
      {
         if(theXpCalulator == null)
         {
            theXpCalulator = new XpCalculator();
         }
         return theXpCalulator;
      }
      
      public static function set xpCalulator(param1:IXpCalculator) : void
      {
         theXpCalulator = param1;
      }
      
      public function enter() : void
      {
         main.saveSystem.savePendingItems();
         var _loc1_:Finn = main.game.getFinn();
         _loc1_.gear.lock();
         _loc1_.liver.unlock();
         this.stats.start();
      }
      
      public function getId() : String
      {
         return this.level.id;
      }
      
      public function getStats() : DungeonStats
      {
         return this.stats;
      }
      
      public function exit() : void
      {
         main.saveSystem.savePendingItems();
         main.game.getFinn().gear.unlock();
         main.game.getFinn().liver.lock();
         main.game.getFinn().liver.clearBuffs();
         this.clear();
      }
      
      protected function createLoot(param1:DungeonConfigData, param2:ProbabilisticSet) : Loot
      {
         return new Loot(param1,param2);
      }
      
      protected function initializeFights(param1:DungeonConfigData) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Boolean = true;
         for each(_loc3_ in param1.enemiesData)
         {
            this.fights.push(this.createFight(this.createEnemy(_loc3_[0],_loc3_[1]),_loc2_));
            _loc2_ = false;
         }
      }
      
      protected function createFight(param1:Enemy, param2:Boolean) : IFight
      {
         return new Fight(param1,param2);
      }
      
      protected function createEnemy(param1:String, param2:uint) : Enemy
      {
         return CharacterFactory.getInstance().getEnemy(param1,param2);
      }
      
      public function get enemies() : Vector.<Enemy>
      {
         var _loc2_:IFight = null;
         var _loc1_:Vector.<Enemy> = new Vector.<Enemy>();
         for each(_loc2_ in this.fights)
         {
            _loc1_.push(_loc2_.getEnemy());
         }
         return _loc1_;
      }
      
      public function getLoot() : Loot
      {
         return this.loot;
      }
      
      public function startFight() : void
      {
         this.fighting = true;
         this.onFight.emit(this.currentFight);
         this.currentFight.fight();
      }
      
      public function get currentFight() : IFight
      {
         return this.fights[this.current];
      }
      
      public function wonFight() : void
      {
         this.fighting = false;
         if(this.current == this.fights.length - 1)
         {
            main.game.getFinn().gear.unlock();
            main.game.getFinn().liver.lock();
            main.game.getFinn().liver.clearBuffs();
            this.currentFight.deactivate();
            ++this.current;
            this.stats.end(this.getDefeated());
            this.advertiseAchievements();
            this.onWin.emit();
            this.level.clear();
            main.saveSystem.saveClearedLevel(this.getId());
         }
         else
         {
            this.currentFight.leave(this.goToNextFight);
         }
      }
      
      private function advertiseAchievements() : void
      {
         if(this.level.getDungeonId() == BossDungeon.idBossLevel)
         {
            main.achievementDispatcher.endLastDungeon();
         }
         if(this.level.getDungeonId() == "8")
         {
            main.achievementDispatcher.finishFirstPage();
         }
         var _loc1_:Gear = main.game.getFinn().gear;
         if(_loc1_.equipment_1.isEmpty() && _loc1_.equipment_2.isEmpty() && _loc1_.shield.isEmpty() && _loc1_.weapon.isEmpty())
         {
            main.achievementDispatcher.unequippedDungeonCompleted(this.level);
         }
      }
      
      public function suddenDeath() : void
      {
         this.stats.end(this.getDefeated());
         if(this.fighting)
         {
            this.currentFight.suddenDeath();
            this.fighting = false;
         }
         else
         {
            this.onLose.emit();
         }
      }
      
      protected function getDefeated() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this.current)
         {
            _loc1_.push(this.fights[_loc2_].getEnemy());
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function goToNextFight() : void
      {
         this.currentFight.deactivate();
         ++this.current;
         this.startFight();
      }
      
      public function lostFight() : void
      {
         this.fighting = false;
         this.stats.end(this.getDefeated());
         main.game.getFinn().gear.unlock();
         main.game.getFinn().liver.lock();
         main.game.getFinn().liver.clearBuffs();
         this.onLose.emit();
      }
      
      public function clear() : void
      {
         var _loc1_:IFight = null;
         while(this.current < this.fights.length)
         {
            this.currentFight.deactivate();
            ++this.current;
         }
         for each(_loc1_ in this.fights)
         {
            _loc1_.clear();
         }
         this.fights = null;
         this.stats.clear();
         this.stats = null;
         this.onLose.clear();
         this.onLose = null;
         this.onWin.clear();
         this.onWin = null;
         this.onFight.clear();
         this.onFight = null;
      }
      
      public function getLevel() : Level
      {
         return this.level;
      }
   }
}

