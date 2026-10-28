package main_game.dungeon
{
   import util.Util;
   
   public class DungeonConfigParser implements DungeonConfigData
   {
      
      private var enemies:Array;
      
      private var loot:Array;
      
      private var backgrounds:Array;
      
      public function DungeonConfigParser(param1:Object)
      {
         super();
         this.parseEnemies(param1);
         this.loot = parseLootData(param1);
         this.parseBackground(param1);
      }
      
      public static function parseLootData(param1:Object) : Array
      {
         var _loc4_:Array = null;
         var _loc2_:Array = new Array();
         var _loc3_:uint = 1;
         while(_loc3_ <= 10)
         {
            _loc4_ = param1["lootDrop" + _loc3_].split(":");
            if(_loc4_[0] == "null")
            {
               break;
            }
            _loc2_.push([_loc4_[0],_loc4_[1]]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function parseEnemies(param1:Object) : void
      {
         var _loc3_:Array = null;
         this.enemies = new Array();
         var _loc2_:uint = 1;
         while(_loc2_ <= 10)
         {
            _loc3_ = param1["enemy" + _loc2_].split(":");
            if(_loc3_[0] == "null")
            {
               break;
            }
            this.enemies.push([_loc3_[0],_loc3_[1]]);
            _loc2_++;
         }
      }
      
      private function parseBackground(param1:Object) : void
      {
         this.backgrounds = new Array();
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            this.backgrounds.push(Util.parseArray(param1["layer" + _loc2_]));
            _loc2_++;
         }
      }
      
      public function get enemiesData() : Array
      {
         return this.enemies;
      }
      
      public function get lootData() : Array
      {
         return this.loot;
      }
      
      public function get backgroundsData() : Array
      {
         return this.backgrounds;
      }
   }
}

