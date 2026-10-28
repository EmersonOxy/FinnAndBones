package main_game.map
{
   public class Level
   {
      
      private var dungeonId:String;
      
      private var state:uint;
      
      private var correlative:Vector.<Level>;
      
      public function Level(param1:String, param2:uint = 1)
      {
         super();
         this.dungeonId = param1;
         this.state = param2;
         this.correlative = new Vector.<Level>();
      }
      
      public static function get LOCKED() : uint
      {
         return 1;
      }
      
      public static function get UNLOCKED() : uint
      {
         return 2;
      }
      
      public static function get CLEARED() : uint
      {
         return 3;
      }
      
      public function getArea() : uint
      {
         var _loc1_:int = int(this.dungeonId);
         if(_loc1_ <= 8)
         {
            return 1;
         }
         if(_loc1_ <= 16)
         {
            return 2;
         }
         return 3;
      }
      
      public function isLegendary() : Boolean
      {
         return false;
      }
      
      public function isSpecial() : Boolean
      {
         return false;
      }
      
      public function getDungeonId() : String
      {
         return this.dungeonId;
      }
      
      public function addCorrelative(param1:Level) : void
      {
         this.correlative.push(param1);
      }
      
      public function getCorrelative() : Vector.<Level>
      {
         return this.correlative;
      }
      
      public function isLocked() : Boolean
      {
         return this.state == LOCKED;
      }
      
      public function isCleared() : Boolean
      {
         return this.state == CLEARED;
      }
      
      public function isUnlocked() : Boolean
      {
         return this.state >= UNLOCKED;
      }
      
      public function getName() : String
      {
         return main.locale.get("dungeonName",[this.id]);
      }
      
      public function unlock() : void
      {
         if(this.isLocked())
         {
            this.state = UNLOCKED;
         }
      }
      
      public function clear() : void
      {
         if(!this.isCleared())
         {
            this.state = CLEARED;
         }
      }
      
      public function get id() : String
      {
         return this.dungeonId;
      }
      
      public function get stateUint() : uint
      {
         return this.state;
      }
   }
}

