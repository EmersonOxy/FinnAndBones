package persistence
{
   import cb.gameloop.GameLoop;
   import flash.display.DisplayObject;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import main_game.mixer.Recipe;
   
   public class SaveSystem
   {
      
      private static const SAVE_FILE:String = "cbjs";
      
      private static const SOUND:String = "m";
      
      private static const PLAYED:String = "p";
      
      private static const LAST_PLAYED:String = "lp";
      
      private static const CLEARED_LEVELS:String = "cl";
      
      private static const EXPERIENCE:String = "xp";
      
      private static const TUTORIAL:String = "t";
      
      private static const RECIPES:String = "r";
      
      private var pendingSaves:Object;
      
      private var _recipes:Array;
      
      private var gameLoop:GameLoop;
      
      private var recipesChange:Boolean;
      
      private var lastPlayed:String;
      
      public function SaveSystem(param1:DisplayObject)
      {
         super();
         this.recipesChange = false;
         this.gameLoop = new GameLoop(param1);
         this.pendingSaves = {};
         this.gameLoop.updated.add(this.realSavePending);
      }
      
      private static function getSaveIdForInventory(param1:uint) : String
      {
         return "i" + param1;
      }
      
      private static function getSaveIdForGear(param1:uint) : String
      {
         return "g" + param1;
      }
      
      private static function getSaveIdForMix(param1:uint) : String
      {
         return "m" + param1;
      }
      
      private static function getSaveIdForlevel(param1:String) : String
      {
         return "d" + param1;
      }
      
      public function hasPlayed() : Boolean
      {
         return Boolean(SharedUtils.load(SAVE_FILE,PLAYED));
      }
      
      public function onFirstPlay() : void
      {
         SharedUtils.save(SAVE_FILE,PLAYED,true);
      }
      
      public function onTutorialComplete(param1:uint) : void
      {
         SharedUtils.save(SAVE_FILE,TUTORIAL,param1);
      }
      
      public function tutorialStepCompleted() : uint
      {
         return uint(SharedUtils.load(SAVE_FILE,TUTORIAL));
      }
      
      public function savePendingItems() : void
      {
         this.gameLoop.start();
      }
      
      private function realSavePending(param1:int) : void
      {
         this.savePending();
         this.gameLoop.stop();
      }
      
      private function savePending() : void
      {
         if(this.recipesChange)
         {
            this.pendingSaves[RECIPES] = this.recipes;
            this.recipesChange = false;
         }
         SharedUtils.saveBulk(SAVE_FILE,this.pendingSaves);
         this.pendingSaves = {};
      }
      
      public function saveInventorySlot(param1:uint, param2:Item) : void
      {
         this.saveItem(param2,getSaveIdForInventory(param1));
      }
      
      public function loadInventoryItem(param1:uint) : Item
      {
         return this.loadItem(getSaveIdForInventory(param1));
      }
      
      public function saveGear(param1:uint, param2:Item) : void
      {
         this.saveItem(param2,getSaveIdForGear(param1));
         this.savePendingItems();
      }
      
      public function loadGearItem(param1:uint) : Item
      {
         return this.loadItem(getSaveIdForGear(param1));
      }
      
      public function saveMix(param1:uint, param2:Item) : void
      {
         this.saveItem(param2,getSaveIdForMix(param1));
      }
      
      public function loadMixItem(param1:uint) : Item
      {
         return this.loadItem(getSaveIdForMix(param1));
      }
      
      public function saveRecipe(param1:Recipe) : void
      {
         var _loc2_:int = this.recipes.indexOf(param1.getId());
         if(_loc2_ < 0)
         {
            this.recipes.push(param1.getId());
            this.recipesChange = true;
         }
      }
      
      public function get recipes() : Array
      {
         if(this._recipes == null)
         {
            this._recipes = SharedUtils.load(SAVE_FILE,RECIPES);
            if(this._recipes == null)
            {
               this._recipes = new Array();
            }
         }
         return this._recipes;
      }
      
      private function saveItem(param1:Item, param2:String) : void
      {
         if(param1 == null)
         {
            this.pendingSaves[param2] = null;
         }
         else
         {
            this.pendingSaves[param2] = param1.toObject();
         }
      }
      
      private function loadItem(param1:String) : Item
      {
         var _loc2_:Object = SharedUtils.load(SAVE_FILE,param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return ItemFactory.getInstance().itemFromObject(_loc2_);
      }
      
      public function getClearedLevels() : Array
      {
         var _loc1_:Object = SharedUtils.load(SAVE_FILE,CLEARED_LEVELS);
         if(_loc1_ == null)
         {
            _loc1_ = [];
         }
         return _loc1_ as Array;
      }
      
      public function saveClearedLevel(param1:String) : void
      {
         var _loc2_:Array = this.getClearedLevels();
         if(_loc2_.indexOf(param1) < 0)
         {
            _loc2_.push(param1);
         }
         SharedUtils.save(SAVE_FILE,CLEARED_LEVELS,_loc2_);
      }
      
      public function saveLastPlayed(param1:String) : void
      {
         this.lastPlayed = param1;
         this.pendingSaves[LAST_PLAYED] = this.lastPlayed;
      }
      
      public function getLastPlayed() : String
      {
         if(this.lastPlayed == null)
         {
            this.lastPlayed = SharedUtils.load(SAVE_FILE,LAST_PLAYED) || "1";
         }
         return this.lastPlayed;
      }
      
      public function saveExperience(param1:uint) : void
      {
         SharedUtils.save(SAVE_FILE,EXPERIENCE,param1);
      }
      
      public function getExperience() : uint
      {
         return uint(SharedUtils.load(SAVE_FILE,EXPERIENCE));
      }
      
      public function saveMuteState(param1:Boolean) : void
      {
         SharedUtils.save(SAVE_FILE,SOUND,param1);
      }
      
      public function isSoundMuted() : Boolean
      {
         return Boolean(SharedUtils.load(SAVE_FILE,SOUND));
      }
      
      public function reset() : void
      {
         this._recipes = null;
         this.recipesChange = false;
         this.lastPlayed = "1";
         var _loc1_:Boolean = this.isSoundMuted();
         SharedUtils.clear(SAVE_FILE);
         this.pendingSaves[PLAYED] = false;
         this.pendingSaves[TUTORIAL] = 0;
         this.pendingSaves[RECIPES] = main.config.get("InitialConfig").initialRecipes as Array;
         this.pendingSaves[SOUND] = _loc1_;
         this.pendingSaves[EXPERIENCE] = main.config.get("InitialConfig").initialExperience;
         this.pendingSaves[LAST_PLAYED] = "1";
         if(!main.config.get("InitialConfig").tutorialOn)
         {
            this.pendingSaves[TUTORIAL] = 6;
         }
         var _loc2_:* = int(main.config.get("InitialConfig").clearedLevel);
         while(_loc2_ > 0)
         {
            this.saveClearedLevel(_loc2_.toString());
            _loc2_--;
         }
         var _loc3_:int = 0;
         var _loc4_:Array = main.config.get("InitialConfig").inventory as Array;
         while(_loc3_ < 12 && _loc3_ < _loc4_.length)
         {
            this.saveInventorySlot(_loc3_,ItemFactory.getInstance().getItem(_loc4_[_loc3_]));
            _loc3_++;
         }
         this.savePending();
      }
   }
}

