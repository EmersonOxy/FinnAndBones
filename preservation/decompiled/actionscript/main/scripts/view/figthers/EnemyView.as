package view.figthers
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import main_game.character.Enemy;
   import main_game.character.Fighter;
   import sound.EnemySoundManager;
   import util.Util;
   import view.figthers.animations.IFighterAnimation;
   
   public class EnemyView extends FighterView
   {
      
      private var container:MovieClip;
      
      public function EnemyView(param1:Fighter)
      {
         super(param1);
         this.container = new MovieClip();
         this.container.enemy = null;
      }
      
      override public function getMC() : MovieClip
      {
         return this.container.enemy;
      }
      
      override protected function setSoundManager() : void
      {
         this.soundManager = new EnemySoundManager(fighter as Enemy);
      }
      
      override public function playAnimation(param1:IFighterAnimation) : void
      {
         if(this.getMC() != null)
         {
            this.container.removeChild(this.getMC());
         }
         this.container.enemy = this.getNewMc(param1);
         this.container.addChild(this.container.enemy);
         this.container.enemy.gotoAndPlay(1);
      }
      
      protected function getNewMc(param1:IFighterAnimation) : MovieClip
      {
         var _loc2_:String = "assets." + this.fighter.getName() + "." + param1.getName();
         var _loc3_:Class = main.swfLoader.getClass(_loc2_);
         return new _loc3_();
      }
      
      override public function putIn(param1:DisplayObjectContainer) : void
      {
         param1["enemy"] = this.container;
         param1.addChild(this.container);
      }
      
      override public function set x(param1:Number) : void
      {
         this.container.x = param1;
      }
      
      override public function get x() : Number
      {
         return this.container.x;
      }
      
      override public function set y(param1:Number) : void
      {
         this.container.y = param1;
      }
      
      override public function get y() : Number
      {
         return this.container.y;
      }
      
      override protected function bringToFront() : void
      {
         var _loc1_:MovieClip = this.container;
         Util.bringToFront(_loc1_);
      }
      
      override public function clear() : void
      {
         super.clear();
         if(this.container.enemy != null)
         {
            this.container.removeChild(this.container.enemy);
         }
         this.container.enemy = null;
         if(this.container.parent)
         {
            this.container.parent.removeChild(this.container);
         }
         this.container = null;
      }
   }
}

