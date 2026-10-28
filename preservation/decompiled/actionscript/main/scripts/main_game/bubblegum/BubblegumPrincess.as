package main_game.bubblegum
{
   import cb.signals.Signal;
   import cb.utils.Random;
   import main_game.character.Gear;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.Fight;
   import main_game.element.Element;
   import main_game.inventory.Inventory;
   import main_game.item_containers.Slot;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import main_game.mixer.MixResult;
   import util.Locker;
   
   public class BubblegumPrincess
   {
      
      private static const FIRE_FLAME:String = "FireFlame";
      
      private static const ICE_BLOCK:String = "IceBlock";
      
      private static var elementTipShowed:Boolean = false;
      
      private static var iceEnemyTipShowed:Boolean = false;
      
      private var lostForAdvice:int;
      
      private var lostDungeons:Object = {};
      
      private var onInteractionSignal:Signal;
      
      private var mixChecker:MixChecker;
      
      private var theLocker:Locker;
      
      public function BubblegumPrincess()
      {
         super();
         this.theLocker = new Locker();
         this.onInteractionSignal = new Signal();
         main.game.onDungeon.add(this.onDungeon);
         main.game.getMixer().onMixEnd.add(this.itemMixed);
         this.lostForAdvice = main.config.get("Bubblegum").losesForAdvice;
         this.initializeChecker();
      }
      
      public function getLocker() : Locker
      {
         return this.theLocker;
      }
      
      public function get onInteraction() : Signal
      {
         return this.onInteractionSignal;
      }
      
      public function selfAdvertise() : void
      {
         this.emitTip(new BubbleGumTip(main.locale.get("pbClickAdvice")));
      }
      
      private function initializeChecker() : void
      {
         var _loc1_:Gear = main.game.getFinn().gear;
         var _loc2_:Array = [_loc1_.equipment_1,_loc1_.equipment_2,_loc1_.shield,_loc1_.weapon,main.game.getMixer().getSlot(1),main.game.getMixer().getSlot(2)];
         var _loc3_:Inventory = main.game.getInventory();
         var _loc4_:* = int(Inventory.SLOTS - 1);
         while(_loc4_ >= 0)
         {
            _loc2_.push(_loc3_.getSlot(_loc4_));
            _loc4_--;
         }
         this.mixChecker = new MixChecker(_loc2_);
      }
      
      private function checkForMixes(param1:Array) : void
      {
         if(this.theLocker.isLocked || !main.theTutorial.isMixKnown())
         {
            return;
         }
         this.mixChecker.checkForMixes(param1);
         var _loc2_:MixRecipe = this.mixChecker.getMix();
         if(_loc2_ != null)
         {
            this.onNewMix(_loc2_);
         }
      }
      
      public function giveSomeTip() : void
      {
         var _loc1_:MixRecipe = null;
         if(this.theLocker.isLocked)
         {
            return;
         }
         if(!main.theTutorial.isMixKnown())
         {
            this.giveBasicTip();
         }
         else if(Math.random() <= 0.5 && this.mixChecker.searchForSlotsMixes([main.game.getMixer().getSlot(3)]))
         {
            _loc1_ = this.mixChecker.getMix();
            if(_loc1_ != null)
            {
               this.onNewMix(_loc1_);
            }
            else
            {
               this.giveBasicTip();
            }
         }
         else
         {
            this.giveBasicTip();
         }
      }
      
      private function giveBasicTip() : void
      {
         var _loc1_:uint = 1;
         if(!main.theTutorial.isMixKnown())
         {
            _loc1_ = main.config.get("Bubblegum").mixAdvices + 1;
         }
         this.emitTip(new BubbleGumTip(main.locale.get("pbAdvice" + Random.nextRange(_loc1_,main.config.get("Bubblegum").advices))));
      }
      
      private function itemMixed(param1:MixResult) : void
      {
         if(param1.recipe != null)
         {
            this.emitTip(new SpecialMixTip(param1.item));
         }
      }
      
      private function emitTip(param1:BubblegumInteraction) : void
      {
         if(this.theLocker.isLocked)
         {
            return;
         }
         this.onInteraction.emit(param1);
      }
      
      private function onDungeon(param1:Dungeon) : void
      {
         param1.onWin.add(this.onWinDungeon);
         param1.onLose.add(this.onLoseDungeon);
         if(!iceEnemyTipShowed)
         {
            param1.onFight.add(this.onFight);
         }
      }
      
      private function onWinDungeon() : void
      {
         var _loc1_:BubblegumInteraction = null;
         var _loc2_:Dungeon = null;
         var _loc3_:Array = null;
         var _loc4_:Slot = null;
         var _loc5_:MixRecipe = null;
         this.removeSubscriptions();
         this.lostDungeons = {};
         if(main.theTutorial.isMixKnown())
         {
            _loc2_ = main.game.getDungeon();
            _loc3_ = new Array();
            for each(_loc4_ in _loc2_.getLoot().getBooty())
            {
               if(!_loc4_.isEmpty())
               {
                  _loc3_.push(_loc4_.getContent());
               }
            }
            _loc1_ = this.getElementInteraction(_loc3_);
            if(_loc1_ != null)
            {
               elementTipShowed = true;
            }
            else
            {
               this.mixChecker.checkForMixes(_loc3_);
               _loc5_ = this.mixChecker.getMix();
               if(_loc5_ != null)
               {
                  _loc1_ = new BubblegumFeltTip(this.getMixPropouse(_loc5_),BubblegumFeeling.getJoy());
               }
            }
         }
         if(_loc1_ == null)
         {
            _loc1_ = BubblegumFeeling.getJoy();
         }
         this.onInteractionSignal.emit(_loc1_);
      }
      
      private function getElementInteraction(param1:Array) : BubblegumInteraction
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Item = null;
         if(!elementTipShowed)
         {
            for each(_loc4_ in param1)
            {
               _loc2_ = _loc4_.getID();
               if(_loc2_ == FIRE_FLAME)
               {
                  _loc3_ = main.locale.get("pbFire");
                  break;
               }
               if(_loc2_ == ICE_BLOCK)
               {
                  _loc3_ = main.locale.get("pbIce");
                  break;
               }
            }
         }
         if(_loc3_ != null)
         {
            return new BubblegumFeltTip(new BubbleGumTip(_loc3_,ItemFactory.getInstance().getItem(_loc2_)),BubblegumFeeling.getJoy());
         }
         return null;
      }
      
      private function onLoseDungeon() : void
      {
         this.removeSubscriptions();
         var _loc1_:Dungeon = main.game.getDungeon();
         if(this.lostDungeons[_loc1_.getId()] != null)
         {
            this.lostDungeons[_loc1_.getId()] = this.lostDungeons[_loc1_.getId()] + 1;
         }
         else
         {
            this.lostDungeons[_loc1_.getId()] = 1;
         }
         if(this.lostDungeons[_loc1_.getId()] >= this.lostForAdvice)
         {
            this.onInteractionSignal.emit(new BubblegumFeltTip(new BubbleGumTip(main.locale.get("pbLostSeveralTimes")),BubblegumFeeling.getSadness()));
         }
         else
         {
            this.onInteractionSignal.emit(BubblegumFeeling.getSadness());
         }
      }
      
      private function onFight(param1:Fight) : void
      {
         var _loc2_:Element = param1.getEnemy().getElement();
         if(_loc2_.isOfIce && !main.game.getBubblegum().getLocker().isLocked)
         {
            iceEnemyTipShowed = true;
            main.game.getDungeon().onFight.remove(this.onFight);
            this.onInteractionSignal.emit(new BubbleGumTip(main.locale.get("pbIceEnemy")));
         }
      }
      
      private function onNewMix(param1:MixRecipe) : void
      {
         this.onInteractionSignal.emit(this.getMixPropouse(param1));
      }
      
      private function getMixPropouse(param1:MixRecipe) : BubbleGumTip
      {
         return new BubbleGumTip(main.locale.get("pbSpecialMix",[param1.item1.getNameToShow(),param1.item2.getNameToShow()]),param1.item1,param1.item2);
      }
      
      private function removeSubscriptions() : void
      {
         var _loc1_:Dungeon = main.game.getDungeon();
         _loc1_.onWin.remove(this.onWinDungeon);
         _loc1_.onLose.remove(this.onLoseDungeon);
         if(!iceEnemyTipShowed)
         {
            _loc1_.onFight.remove(this.onFight);
         }
      }
      
      public function clear() : void
      {
         main.game.onDungeon.remove(this.onDungeon);
         if(main.game.getMixer() != null)
         {
            main.game.getMixer().onMixEnd.remove(this.itemMixed);
         }
         this.theLocker.clear();
         this.onInteractionSignal.clear();
         this.onInteractionSignal = null;
      }
   }
}

