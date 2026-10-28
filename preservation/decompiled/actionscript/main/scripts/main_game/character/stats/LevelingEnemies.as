package main_game.character.stats
{
   import bonus.ExtraLevelBonus;
   import main_game.character.CharacterConfigData;
   
   public class LevelingEnemies extends LevelingStragegy
   {
      
      private static var extraLevel:ExtraLevelBonus;
      
      protected var xpMod:Number;
      
      private var extraLevel:int;
      
      public function LevelingEnemies(param1:SingletonLock)
      {
         var _loc2_:Object = main.config.get("Leveling_Enemies");
         super(_loc2_);
         this.xpMod = _loc2_.xpMod;
         this.extraLevel = 0;
      }
      
      public static function setBonus(param1:ExtraLevelBonus) : void
      {
         extraLevel = param1;
      }
      
      public static function getNewInstance(param1:CharacterConfigData) : LevelingEnemies
      {
         var _loc2_:LevelingEnemies = new LevelingEnemies(new SingletonLock());
         if(extraLevel != null)
         {
            extraLevel.apply(param1,_loc2_);
         }
         return _loc2_;
      }
      
      public function setExtraLevel(param1:int) : void
      {
         this.extraLevel = param1;
      }
      
      override public function level(param1:uint, param2:Stats) : uint
      {
         var _loc3_:Number = NaN;
         param1 = Math.max(param1 + this.extraLevel,1);
         var _loc4_:uint = param2.getLevel();
         param1 = super.level(param1,param2);
         if(param1 == _loc4_)
         {
            return param1;
         }
         var _loc5_:Stat = param2.getStat(StatType.EXPERIENCE);
         var _loc6_:Number = param2.getStat(StatType.BASE_XP).getValue();
         levelUp(_loc5_,_loc6_,this.xpMod,_loc4_,param1);
         return param1;
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
