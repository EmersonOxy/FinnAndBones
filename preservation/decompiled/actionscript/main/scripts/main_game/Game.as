package main_game
{
   import cb.signals.Signal;
   import main_game.bubblegum.BubblegumPrincess;
   import main_game.character.CharacterFactory;
   import main_game.character.Finn;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.DungeonFactory;
   import main_game.inventory.Inventory;
   import main_game.map.Level;
   import main_game.map.Map;
   import main_game.mixer.Mixer;
   
   public class Game
   {
      
      private var inv:Inventory;
      
      private var map:Map;
      
      private var mix:Mixer;
      
      private var finn:Finn;
      
      private var princess:BubblegumPrincess;
      
      private var current_dungeon:Dungeon;
      
      private var pauseSignal:Signal;
      
      private var onDungeonSignal:Signal;
      
      public function Game()
      {
         super();
      }
      
      public function get onPause() : Signal
      {
         return this.pauseSignal;
      }
      
      public function get onDungeon() : Signal
      {
         return this.onDungeonSignal;
      }
      
      public function enter() : void
      {
         this.finn = CharacterFactory.getInstance().getFinn();
         this.pauseSignal = new Signal();
         this.onDungeonSignal = new Signal();
         this.inv = new Inventory();
         this.mix = new Mixer();
         this.map = new Map();
         this.princess = new BubblegumPrincess();
      }
      
      public function exit() : void
      {
         this.inv.clear();
         this.inv = null;
         this.finn.clear();
         this.finn = null;
         this.mix.clear();
         this.mix = null;
         this.map.clear();
         this.map = null;
         this.princess.clear();
         this.princess = null;
         if(this.current_dungeon != null)
         {
            this.current_dungeon.clear();
            this.current_dungeon = null;
         }
         this.onPause.clear();
         this.pauseSignal = null;
         this.onDungeonSignal.clear();
         this.onDungeonSignal = null;
      }
      
      public function goToDungeon(param1:Level) : Dungeon
      {
         this.current_dungeon = DungeonFactory.getInstance().getDungeon(param1);
         this.current_dungeon.enter();
         this.onDungeon.emit(this.current_dungeon);
         main.saveSystem.saveLastPlayed(param1.getDungeonId());
         return this.current_dungeon;
      }
      
      public function getDungeon() : Dungeon
      {
         return this.current_dungeon;
      }
      
      public function exitDungeon() : void
      {
         this.current_dungeon.exit();
         this.current_dungeon = null;
      }
      
      public function getFinn() : Finn
      {
         return this.finn;
      }
      
      public function getBubblegum() : BubblegumPrincess
      {
         return this.princess;
      }
      
      public function getInventory() : Inventory
      {
         return this.inv;
      }
      
      public function getMixer() : Mixer
      {
         return this.mix;
      }
      
      public function getMap() : Map
      {
         return this.map;
      }
   }
}

