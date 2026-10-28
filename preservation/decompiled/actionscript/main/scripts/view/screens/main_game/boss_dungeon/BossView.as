package view.screens.main_game.boss_dungeon
{
   import flash.display.MovieClip;
   import main_game.boss_dungeon.Boss;
   import main_game.character.Fighter;
   import sound.BossSoundManager;
   import view.figthers.EnemyView;
   import view.figthers.animations.IFighterAnimation;
   
   public class BossView extends EnemyView
   {
      
      public function BossView(param1:Fighter)
      {
         super(param1);
      }
      
      override protected function getNewMc(param1:IFighterAnimation) : MovieClip
      {
         var _loc2_:String = "assets." + "boss_normal" + "." + param1.getName();
         var _loc3_:Class = main.swfLoader.getClass(_loc2_);
         return new _loc3_();
      }
      
      override protected function setSoundManager() : void
      {
         this.soundManager = new BossSoundManager(this.fighter as Boss);
      }
   }
}

