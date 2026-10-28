package main_game.dungeon
{
   import main_game.character.Enemy;
   import main_game.character.Finn;
   import main_game.map.Level;
   import main_game.mixer.MixResult;
   
   public class DungeonStats
   {
      
      private var defeated:Array;
      
      private var mixesDone:int;
      
      private var criticalHits:int;
      
      private var theLevel:Level;
      
      private var active:Boolean;
      
      public function DungeonStats(param1:Level)
      {
         super();
         this.active = false;
         this.theLevel = param1;
         this.mixesDone = 0;
         this.criticalHits = 0;
      }
      
      public function start() : void
      {
         this.active = true;
         main.game.getMixer().onMixEnd.add(this.onMix);
         main.game.getFinn().onHit.add(this.onHit);
      }
      
      public function get level() : Level
      {
         return this.theLevel;
      }
      
      private function onMix(param1:MixResult) : void
      {
         this.mixesDone += 1;
      }
      
      private function onHit(param1:Finn, param2:Enemy, param3:Damage, param4:Function) : void
      {
         if(param3.isCritical())
         {
            this.criticalHits += 1;
         }
      }
      
      public function end(param1:Array) : void
      {
         this.defeated = param1;
         this.deactivate();
      }
      
      public function getCombatExperience() : Number
      {
         return Dungeon.xpCalulator.getXp(this.defeated);
      }
      
      public function getMixExperience() : Number
      {
         return Dungeon.xpCalulator.getMixXp(this.mixesDone);
      }
      
      public function getCriticalExperience() : Number
      {
         return Dungeon.xpCalulator.getCriticalXp(this.criticalHits);
      }
      
      public function getDungeonExperience() : Number
      {
         return this.getCombatExperience() + this.getCriticalExperience() + this.getMixExperience();
      }
      
      private function deactivate() : void
      {
         if(this.active)
         {
            main.game.getMixer().onMixEnd.remove(this.onMix);
            main.game.getFinn().onHit.remove(this.onHit);
            this.active = false;
         }
      }
      
      public function clear() : void
      {
         this.deactivate();
      }
   }
}

