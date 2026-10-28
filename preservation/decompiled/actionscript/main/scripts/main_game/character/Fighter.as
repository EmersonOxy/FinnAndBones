package main_game.character
{
   import cb.signals.Signal;
   import main_game.character.stats.Stats;
   import main_game.dungeon.Damage;
   import main_game.dungeon.IFight;
   import sound.FighterSoundManager;
   
   public class Fighter
   {
      
      public var onHit:Signal;
      
      public var stats:Stats;
      
      private var name:String;
      
      private var nameString:String;
      
      protected var soundManager:FighterSoundManager;
      
      public function Fighter(param1:String, param2:CharacterConfigData)
      {
         super();
         this.name = param1;
         this.onHit = new Signal();
         this.nameString = param2.nameString;
         this.stats = this.createStats(param2);
      }
      
      public function isFinn() : Boolean
      {
         return false;
      }
      
      protected function createStats(param1:CharacterConfigData) : Stats
      {
         throw new Error("must override this method");
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function prepareForFight(param1:IFight) : void
      {
      }
      
      public function hit(param1:Fighter, param2:Damage, param3:Function) : void
      {
         this.onHit.emit(this,param1,param2,param3);
      }
      
      public function takeDamage(param1:Damage) : void
      {
         param1.apply(this.stats);
      }
      
      public function clear() : void
      {
         this.onHit.clear();
         this.stats.clear();
      }
      
      public function getNameToShow() : Object
      {
         return main.locale.get(this.nameString);
      }
   }
}

