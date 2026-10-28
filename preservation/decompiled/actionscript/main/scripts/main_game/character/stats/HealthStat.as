package main_game.character.stats
{
   public class HealthStat extends Stat
   {
      
      private var maxHealth:Stat;
      
      public function HealthStat(param1:int, param2:Stat, param3:Number = 0)
      {
         this.maxHealth = param2;
         super(param1,param3);
      }
      
      override public function modifyValue(param1:Number) : void
      {
         this.value = Math.max(0,Math.min(this.value + param1,this.getUpperBound().getValue()));
      }
      
      public function modifyUpperBound(param1:Number) : void
      {
         this.maxHealth.modifyValue(param1);
         this.fill(100);
      }
      
      public function fill(param1:Number = 100) : void
      {
         this.modifyValue(Math.floor(this.getUpperBound().getValue() * param1 / 100));
      }
      
      public function getUpperBound() : Stat
      {
         return this.maxHealth;
      }
      
      public function getpercentage() : Number
      {
         return Math.ceil(getValue() * 100 / this.getUpperBound().getValue());
      }
   }
}

