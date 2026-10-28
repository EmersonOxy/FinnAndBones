package main_game.dungeon
{
   import flash.utils.Dictionary;
   import main_game.boss_dungeon.BossDungeon;
   import main_game.map.Level;
   import util.ProbabilisticSet;
   import view.screens.main_game.boss_dungeon.BossDungeonView;
   import view.screens.main_game.dungeon.DungeonView;
   import view.screens.main_game.states.DungeonState;
   
   public class DungeonFactory
   {
      
      private static var instance:DungeonFactory;
      
      private static var config:Dictionary;
      
      private static var firstLootData:Dictionary;
      
      public function DungeonFactory(param1:SingletonLock)
      {
         super();
         if(!param1)
         {
            throw new Error("Static Class");
         }
      }
      
      public static function set firstLoot(param1:Dictionary) : void
      {
         if(firstLootData != null)
         {
            throw new Error("Can\'t do that");
         }
         firstLootData = param1;
      }
      
      public static function getInstance() : DungeonFactory
      {
         if(instance == null)
         {
            instance = new DungeonFactory(new SingletonLock());
         }
         return instance;
      }
      
      public static function setConfig(param1:Dictionary) : void
      {
         config = param1;
      }
      
      public static function getConfigFor(param1:String) : DungeonConfigData
      {
         return new DungeonConfigParser(config[param1]);
      }
      
      public function getDungeonsIds() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for(_loc2_ in config)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getDungeon(param1:Level) : Dungeon
      {
         var _loc2_:DungeonConfigData = getConfigFor(param1.getDungeonId());
         if(param1.getDungeonId() == BossDungeon.idBossLevel)
         {
            return new BossDungeon(param1,_loc2_,this.getFirstLoot(param1));
         }
         return new Dungeon(param1,_loc2_,this.getFirstLoot(param1));
      }
      
      private function getFirstLoot(param1:Level) : ProbabilisticSet
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc2_:ProbabilisticSet = new ProbabilisticSet();
         if(!param1.isCleared())
         {
            _loc3_ = DungeonConfigParser.parseLootData(firstLootData[param1.id]);
            for each(_loc4_ in _loc3_)
            {
               _loc2_.add(_loc4_[0],_loc4_[1]);
            }
         }
         return _loc2_;
      }
      
      public function getViewFor(param1:DungeonState) : DungeonView
      {
         if(param1.getDungeon().getId() == BossDungeon.idBossLevel)
         {
            return new BossDungeonView(param1);
         }
         return new DungeonView(param1);
      }
   }
}

class SingletonLock
{
   
   public function SingletonLock()
   {
      super();
   }
}
