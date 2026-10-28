package view.figthers
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import main_game.character.Fighter;
   import main_game.dungeon.Damage;
   import sound.FighterSoundManager;
   import util.Util;
   import view.figthers.animations.HitAnimation;
   import view.figthers.animations.IFighterAnimation;
   import view.figthers.animations.IdleAnimation;
   import view.figthers.animations.NoneAnimation;
   
   public class FighterView
   {
      
      protected var fighter:Fighter;
      
      private var currentAnimation:IFighterAnimation;
      
      private var nextAnimation:IFighterAnimation;
      
      protected var soundManager:FighterSoundManager;
      
      public function FighterView(param1:Fighter)
      {
         super();
         this.fighter = param1;
         this.setSoundManager();
      }
      
      public function getFighter() : Fighter
      {
         return this.fighter;
      }
      
      protected function setSoundManager() : void
      {
         throw new Error("Abstract Class");
      }
      
      public function get fighterSoundManager() : FighterSoundManager
      {
         return this.soundManager;
      }
      
      public function animate(param1:IFighterAnimation) : void
      {
         this.nextAnimation = param1;
         if(this.currentAnimation == null)
         {
            this.endCurrentAnimation(null);
         }
         else if(this.nextAnimation.forceKill())
         {
            this.currentAnimation.kill();
            this.endCurrentAnimation(this.currentAnimation);
         }
      }
      
      protected function endCurrentAnimation(param1:IFighterAnimation) : void
      {
         if(this.nextAnimation == null)
         {
            if(param1.mustGoToIdle())
            {
               this.nextAnimation = new IdleAnimation();
            }
            else
            {
               this.nextAnimation = new NoneAnimation();
            }
         }
         this.currentAnimation = this.nextAnimation;
         this.nextAnimation = null;
         this.currentAnimation.getAtFinish().addAtFirst(this.endCurrentAnimation);
         this.currentAnimation.make(this);
      }
      
      public function pause() : void
      {
         this.currentAnimation.pause();
         this.soundManager.pause();
      }
      
      public function resume() : void
      {
         this.currentAnimation.resume();
         this.soundManager.resume();
      }
      
      public function clear() : void
      {
         this.currentAnimation.kill();
         this.currentAnimation = null;
      }
      
      public function playAnimation(param1:IFighterAnimation) : void
      {
      }
      
      public function set x(param1:Number) : void
      {
      }
      
      public function get x() : Number
      {
         return 0;
      }
      
      public function set y(param1:Number) : void
      {
      }
      
      public function get y() : Number
      {
         return 0;
      }
      
      public function getMC() : MovieClip
      {
         return null;
      }
      
      public function putIn(param1:DisplayObjectContainer) : void
      {
      }
      
      public function onHit(param1:FighterView, param2:Damage, param3:Function, param4:Function = null) : void
      {
         this.bringToFront();
         var _loc5_:HitAnimation = new HitAnimation(param1,param2,param3,param4);
         this.animate(_loc5_);
      }
      
      protected function bringToFront() : void
      {
         Util.bringToFront(this.getMC());
      }
   }
}

