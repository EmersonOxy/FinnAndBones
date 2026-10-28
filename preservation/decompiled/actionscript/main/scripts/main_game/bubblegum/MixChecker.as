package main_game.bubblegum
{
   import cb.utils.Random;
   import main_game.item_containers.ISlot;
   import main_game.items.Item;
   import main_game.mixer.MixStrategy;
   import main_game.mixer.Recipe;
   import util.ProbabilisticSet;
   
   public class MixChecker
   {
      
      private static const MEMORY:uint = 3;
      
      private var banned:Array;
      
      private var slots:Array;
      
      private var mixables:ProbabilisticSet;
      
      public function MixChecker(param1:Array)
      {
         super();
         this.banned = new Array();
         this.slots = param1;
      }
      
      public function checkForMixes(param1:Array) : Boolean
      {
         var _loc2_:Item = null;
         if(!main.theTutorial.isMixKnown())
         {
            return false;
         }
         this.mixables = new ProbabilisticSet();
         for each(_loc2_ in param1)
         {
            this.checkMixWithItem(_loc2_);
         }
         return this.mixables.length > 0;
      }
      
      public function searchForSlotsMixes(param1:Array) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:ISlot = null;
         var _loc5_:Item = null;
         var _loc6_:Item = null;
         var _loc7_:int = 0;
         var _loc8_:Item = null;
         this.mixables = new ProbabilisticSet();
         if(param1 != null && param1.length > 0)
         {
            _loc3_ = new Array();
            for each(_loc4_ in param1)
            {
               _loc5_ = _loc4_.getContent();
               if(_loc5_ != null)
               {
                  _loc3_.push(_loc5_);
               }
            }
            if(_loc3_.length > 0)
            {
               this.checkForMixes(_loc3_);
            }
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.slots.length - 1)
         {
            _loc6_ = (this.slots[_loc2_] as ISlot).getContent();
            if(_loc6_ != null)
            {
               _loc7_ = _loc2_ + 1;
               while(_loc7_ < this.slots.length)
               {
                  _loc8_ = (this.slots[_loc7_] as ISlot).getContent();
                  if(_loc8_ != null)
                  {
                     this.checkMixWithItems(_loc6_,_loc8_);
                  }
                  _loc7_++;
               }
            }
            _loc2_++;
         }
         return this.mixables.length > 0;
      }
      
      public function getMix() : MixRecipe
      {
         var _loc2_:MixRecipe = null;
         var _loc1_:Array = new Array();
         while(this.mixables.length > 0)
         {
            _loc2_ = this.mixables.pop() as MixRecipe;
            if(!this.isBanned(_loc2_))
            {
               this.addBanned(_loc2_);
               return _loc2_;
            }
            _loc1_.push(_loc2_);
         }
         if(_loc1_.length > 0)
         {
            return _loc1_[Random.nextInt(_loc1_.length - 1)];
         }
         return null;
      }
      
      private function addBanned(param1:MixRecipe) : void
      {
         if(!this.isBanned(param1))
         {
            if(this.banned.length >= MEMORY)
            {
               this.banned.shift();
            }
            this.banned.push(param1);
         }
      }
      
      private function isBanned(param1:MixRecipe) : Boolean
      {
         var _loc2_:MixRecipe = null;
         for each(_loc2_ in this.banned)
         {
            if(_loc2_.equals(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkMixWithItem(param1:Item) : void
      {
         var _loc2_:ISlot = null;
         var _loc3_:Item = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in this.slots)
         {
            if(!_loc2_.isEmpty())
            {
               _loc3_ = _loc2_.getContent();
               this.checkMixWithItems(param1,_loc3_);
            }
         }
      }
      
      private function checkMixWithItems(param1:Item, param2:Item) : void
      {
         var _loc3_:Recipe = MixStrategy.getSpecialMixId(param1,param2,true);
         if(_loc3_ != null && _loc3_.mustShow)
         {
            this.addRecipe(new MixRecipe(param1,param2,_loc3_.result),this.mixables);
         }
         _loc3_ = MixStrategy.getSpecialMixId(param2,param1,true);
         if(_loc3_ != null && _loc3_.mustShow)
         {
            this.addRecipe(new MixRecipe(param2,param1,_loc3_.result),this.mixables);
         }
      }
      
      private function addRecipe(param1:MixRecipe, param2:ProbabilisticSet) : void
      {
         if(!param2.contains(param1))
         {
            param2.add(param1);
         }
      }
      
      public function clear() : void
      {
         this.banned = null;
         this.mixables = null;
      }
   }
}

