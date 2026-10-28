package main_game.character.stats
{
   import flash.utils.Dictionary;
   
   public class Experience extends Stat
   {
      
      private static var config:Dictionary;
      
      private var level:uint;
      
      private var stats:Stats;
      
      public function Experience(param1:Stats)
      {
         super(StatType.EXPERIENCE,1);
         this.stats = param1;
         this.level = 1;
         this.refreshLevel();
      }
      
      public static function set configuration(param1:Dictionary) : void
      {
         config = param1;
      }
      
      protected function refreshLevel() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:uint = 1;
         while(config[_loc1_]["XP"] <= this.value)
         {
            _loc1_ += 1;
            if(config[_loc1_] == null)
            {
               _loc2_ = Number(config[_loc1_ - 1]["XP"]);
               _loc2_ += _loc2_ / 2;
               config[_loc1_] = {"XP":Math.round(_loc2_)};
            }
         }
         if(_loc1_ != this.level)
         {
            this.stats.leveling(_loc1_);
            this.level = _loc1_;
         }
      }
      
      public function getUpperBound() : Number
      {
         var _loc1_:Number = 0;
         if(this.level > 1)
         {
            _loc1_ = Number(config[this.level - 1]["XP"]);
         }
         return config[this.level]["XP"] - _loc1_;
      }
      
      override public function modifyValue(param1:Number) : void
      {
         super.modifyValue(param1);
         this.refreshLevel();
      }
      
      override public function getValue() : Number
      {
         var _loc1_:Number = 0;
         if(this.level > 1)
         {
            _loc1_ = Number(config[this.level - 1]["XP"]);
         }
         return this.value - _loc1_;
      }
      
      public function getLevel() : uint
      {
         return this.level;
      }
   }
}

