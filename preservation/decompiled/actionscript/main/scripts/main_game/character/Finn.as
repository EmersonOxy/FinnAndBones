package main_game.character
{
   import cb.signals.Signal;
   import main_game.character.stats.FinnStats;
   import main_game.character.stats.Stats;
   import main_game.dungeon.IFight;
   import main_game.items.Item;
   
   public class Finn extends Fighter
   {
      
      public var liver:Liver;
      
      public var gear:Gear;
      
      public var onPotionConsumition:Signal;
      
      public var endPotionConsumition:Signal;
      
      public function Finn(param1:String, param2:CharacterConfigData)
      {
         super(param1,param2);
         this.onPotionConsumition = new Signal();
         this.endPotionConsumition = new Signal();
         this.liver = new Liver(this);
         this.gear = new Gear(this);
         this.loadData();
      }
      
      public function consumePotion(param1:Item) : void
      {
         this.onPotionConsumition.emit(param1);
      }
      
      public function endPotionEffect(param1:Item) : void
      {
         this.endPotionConsumition.emit(param1);
      }
      
      private function loadData() : void
      {
         this.stats.loadData();
         this.stats.refillHealth();
      }
      
      override public function isFinn() : Boolean
      {
         return true;
      }
      
      override protected function createStats(param1:CharacterConfigData) : Stats
      {
         return new FinnStats(param1,this);
      }
      
      override public function prepareForFight(param1:IFight) : void
      {
      }
      
      override public function clear() : void
      {
         super.clear();
         this.onPotionConsumition.clear();
         this.endPotionConsumition.clear();
         this.gear.clear();
         this.liver.clear();
      }
   }
}

