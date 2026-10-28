package main_game.map
{
   import bonus.DailyBonus;
   import cb.utils.cbArray;
   import flash.utils.Dictionary;
   import main_game.dungeon.DungeonFactory;
   import main_game.element.Element;
   
   public class Map
   {
      
      private var levels:Dictionary;
      
      public function Map()
      {
         super();
         this.initializeLevels();
         this.setConections();
         this.getLevel("1").unlock();
         this.loadSave();
         this.unlockUnlocked();
      }
      
      public function getNextLevel(param1:Level) : Level
      {
         var _loc2_:Vector.<Level> = param1.getCorrelative();
         if(_loc2_.length > 0)
         {
            return _loc2_[0];
         }
         return null;
      }
      
      public function getPreviousLevel(param1:String) : Level
      {
         var _loc2_:Level = null;
         if(!this.levels[param1])
         {
            return null;
         }
         for each(_loc2_ in this.levels)
         {
            if(_loc2_.getCorrelative().indexOf(this.levels[param1]) >= 0)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function biggestUnlockedLevel() : Level
      {
         var _loc1_:Level = null;
         var _loc2_:int = 1;
         while(_loc2_ <= 25)
         {
            if((this.levels[_loc2_] as Level).isUnlocked())
            {
               _loc1_ = this.levels[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLevel(param1:String) : Level
      {
         return this.levels[param1];
      }
      
      public function getLevels() : Dictionary
      {
         return this.levels;
      }
      
      private function initializeLevels() : void
      {
         var _loc1_:String = null;
         this.levels = new Dictionary();
         for each(_loc1_ in DungeonFactory.getInstance().getDungeonsIds())
         {
            if(_loc1_ == "31")
            {
               this.addLevel(new LegendaryLevel(_loc1_,Element.ice,DailyBonus.getNextSpecialDungeonDate(Element.ice)));
            }
            else if(_loc1_ == "32")
            {
               this.addLevel(new LegendaryLevel(_loc1_,Element.fire,DailyBonus.getNextSpecialDungeonDate(Element.fire)));
            }
            else if(["26","27","28","29","30"].indexOf(_loc1_) >= 0)
            {
               this.addLevel(new SpecialLevel(_loc1_));
            }
            else
            {
               this.addLevel(new Level(_loc1_));
            }
         }
      }
      
      public function addLevel(param1:Level) : void
      {
         this.levels[param1.getDungeonId()] = param1;
      }
      
      private function setConections() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 25)
         {
            this.levels[_loc1_].addCorrelative(this.levels[_loc1_ + 1]);
            _loc1_++;
         }
         this.levels[4].addCorrelative(this.levels[26]);
         this.levels[15].addCorrelative(this.levels[27]);
         this.levels[19].addCorrelative(this.levels[28]);
         this.levels[23].addCorrelative(this.levels[29]);
         this.levels[29].addCorrelative(this.levels[30]);
         this.levels[26].addCorrelative(this.levels[6]);
         this.levels[27].addCorrelative(this.levels[16]);
         this.levels[28].addCorrelative(this.levels[20]);
         this.levels[30].addCorrelative(this.levels[24]);
      }
      
      private function loadSave() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = main.saveSystem.getClearedLevels();
         for each(_loc2_ in _loc1_)
         {
            this.getLevel(_loc2_).clear();
         }
      }
      
      public function unlockUnlocked() : cbArray
      {
         var _loc2_:Level = null;
         var _loc3_:Level = null;
         var _loc1_:cbArray = new cbArray();
         for each(_loc2_ in this.levels)
         {
            if(_loc2_.isCleared())
            {
               for each(_loc3_ in _loc2_.getCorrelative())
               {
                  if(_loc3_.isLocked())
                  {
                     _loc3_.unlock();
                     _loc1_.pushIfNotPresent(_loc3_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function clear() : void
      {
         this.levels = null;
      }
   }
}

