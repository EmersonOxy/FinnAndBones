package main_game.character.stats
{
   public class LevelingStragegy
   {
      
      protected var maxHPMod:Number;
      
      protected var attMod:Number;
      
      protected var defMod:Number;
      
      protected var luckMod:Number;
      
      public function LevelingStragegy(param1:Object)
      {
         super();
         this.maxHPMod = param1.maxHPMod;
         this.attMod = param1.attMod;
         this.defMod = param1.defMod;
         this.luckMod = param1.luckMod;
      }
      
      public function level(param1:uint, param2:Stats) : uint
      {
         var _loc3_:Number = NaN;
         var _loc5_:Stat = null;
         var _loc6_:Number = NaN;
         var _loc4_:uint = param2.getLevel();
         if(param1 == _loc4_)
         {
            return param1;
         }
         _loc5_ = param2.getStat(StatType.LUCK);
         _loc6_ = param2.getStat(StatType.BASE_LUCK).getValue();
         this.levelUp(_loc5_,_loc6_,this.luckMod,_loc4_,param1);
         var _loc7_:HealthStat = param2.getStat(StatType.HEALTH) as HealthStat;
         _loc6_ = param2.getStat(StatType.BASE_HEALTH).getValue();
         this.levelUp(_loc7_.getUpperBound(),_loc6_,this.maxHPMod,_loc4_,param1);
         this.levelUp(_loc7_,_loc6_,this.maxHPMod,_loc4_,param1);
         _loc5_ = param2.getStat(StatType.ATTACK);
         _loc6_ = param2.getStat(StatType.BASE_ATTACK).getValue();
         this.levelUp(_loc5_,_loc6_,this.attMod,_loc4_,param1);
         _loc5_ = param2.getStat(StatType.DEFENSE);
         _loc6_ = param2.getStat(StatType.BASE_DEFENSE).getValue();
         this.levelUp(_loc5_,_loc6_,this.defMod,_loc4_,param1);
         return param1;
      }
      
      protected function levelUp(param1:Stat, param2:Number, param3:Number, param4:uint, param5:uint) : void
      {
         if(param4 == param5)
         {
            return;
         }
         var _loc6_:Number = param2;
         if(param4 > 1)
         {
            _loc6_ = param2 * Math.pow(param3,param4 - 1);
         }
         var _loc7_:Number = param2 * Math.pow(param3,param5 - 1) - _loc6_;
         param1.modifyValue(Math.round(_loc7_));
      }
   }
}

