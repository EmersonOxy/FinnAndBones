package view.screens.main_game.boss_dungeon
{
   import main_game.boss_dungeon.BossFight;
   import main_game.dungeon.Dungeon;
   import sound.GameSounds;
   import util.Util;
   import view.figthers.FinnView;
   import view.figthers.animations.IdleAnimation;
   import view.screens.main_game.dungeon.fight.BasicFightView;
   
   public class BossFightView extends BasicFightView implements InnerBossDungeonView
   {
      
      private var bossDungeonView:BossDungeonView;
      
      public function BossFightView(param1:BossDungeonView, param2:BossFight)
      {
         this.bossDungeonView = param1;
         super(param2,param1.background);
         main.soundManager.playMusic(GameSounds.BOSS_MUSIC);
      }
      
      private function get bossView() : BossView
      {
         return this.bossDungeonView.getBossView();
      }
      
      override protected function initializeViews(param1:Array) : void
      {
         enemy = fight.getEnemy();
         var _loc2_:FinnView = this.bossDungeonView.getFinnView();
         views[_loc2_.getFighter()] = _loc2_;
         views[this.bossView.getFighter()] = this.bossView;
      }
      
      override protected function enter(param1:Function) : void
      {
         this.bossView.animate(new IdleAnimation());
         this.bossView.x = this.bossDungeonView.getFinnView().x + (Dungeon.DungeonConfig["position_enemy"] - Dungeon.DungeonConfig["position_finn"]) + 100;
         this.bossView.putIn(this.bossDungeonView.background.arena);
         this.bossDungeonView.getFinnView().animate(new IdleAnimation());
         this.bossDungeonView.background.onMove.add(Util.l(this.backgroundMove,param1));
         this.bossDungeonView.background.beginScroll();
      }
      
      private function backgroundMove(param1:Number, param2:Function) : void
      {
         this.bossDungeonView.getFinnView().x = this.bossDungeonView.getFinnView().x - param1;
         this.bossDungeonView.getBossView().x = this.bossDungeonView.getBossView().x - param1;
         if(this.bossDungeonView.getFinnView().x <= Dungeon.DungeonConfig["position_finn"])
         {
            this.bossDungeonView.background.onMove.remove(this.backgroundMove);
            this.bossDungeonView.background.endScroll();
            super.enter(param2);
         }
      }
      
      override protected function won() : void
      {
         this.bossDungeonView.dungeon.getDungeon().wonFight();
      }
      
      override protected function lose() : void
      {
         this.bossDungeonView.dungeon.getDungeon().lostFight();
      }
      
      public function playMusic() : void
      {
         main.soundManager.playMusic(GameSounds.BOSS_MUSIC);
      }
      
      public function stopMusic() : void
      {
         main.soundManager.stopMusic(GameSounds.BOSS_MUSIC);
      }
   }
}

