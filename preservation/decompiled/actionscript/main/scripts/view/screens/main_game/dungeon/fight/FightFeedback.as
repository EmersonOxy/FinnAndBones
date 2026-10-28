package view.screens.main_game.dungeon.fight
{
   import cb.actions.Functor;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class FightFeedback extends Sprite
   {
      
      private static const gap:Number = -50;
      
      private var slots:Object;
      
      public function FightFeedback()
      {
         super();
         this.slots = new Object();
         this.slots[0] = null;
         this.slots[1] = null;
         this.slots[2] = null;
      }
      
      public function showIn(param1:DisplayObjectContainer) : void
      {
         param1.addChild(this);
      }
      
      public function addFeedback(param1:MovieClip) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(!this.slots[_loc2_])
            {
               this.slots[_loc2_] = param1;
               if(_loc2_ > 0)
               {
                  _loc3_ = this.slots[_loc2_ - 1];
                  param1.y = _loc3_.y + _loc3_.height + gap;
               }
               this.makeAppear(param1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function makeAppear(param1:MovieClip) : void
      {
         this.addChild(param1);
         param1.gotoAndPlay(1);
         var _loc2_:SmartMC = new SmartMC(param1);
         _loc2_.trigger(new EndAnimation(),new Functor(this.removePoster,param1));
      }
      
      private function removePoster(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:MovieClip = param2[0];
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            if(this.slots[_loc4_] == _loc3_)
            {
               this.slots[_loc4_] = null;
               _loc3_.stop();
               this.removeChild(_loc3_);
               break;
            }
            _loc4_++;
         }
      }
      
      public function pause() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(this.slots[_loc1_])
            {
               this.slots[_loc1_].stop();
            }
            _loc1_++;
         }
      }
      
      public function resume() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(this.slots[_loc1_])
            {
               this.slots[_loc1_].play();
            }
            _loc1_++;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(this.slots[_loc1_])
            {
               this.slots[_loc1_].stop();
            }
            _loc1_++;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         this.slots = null;
      }
   }
}

