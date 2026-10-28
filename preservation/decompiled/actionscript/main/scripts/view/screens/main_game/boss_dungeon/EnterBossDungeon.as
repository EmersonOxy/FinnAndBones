package view.screens.main_game.boss_dungeon
{
   import cb.gameloop.GameLoop;
   import main_game.dungeon.Dungeon;
   import sound.GameSounds;
   import view.figthers.FinnView;
   import view.figthers.animations.IFighterAnimation;
   import view.figthers.animations.IdleAnimation;
   import view.figthers.animations.RunAnimation;
   import view.screens.main_game.dungeon.BackgroundView;
   
   public class EnterBossDungeon implements InnerBossDungeonView
   {
      
      private var bossDungeonView:BossDungeonView;
      
      private var atEnd:Function;
      
      private var gameLoop:GameLoop;
      
      private var paused:Boolean;
      
      private var walk:RunAnimation;
      
      public function EnterBossDungeon(param1:BossDungeonView, param2:Function)
      {
         super();
         this.bossDungeonView = param1;
         this.atEnd = param2;
         this.gameLoop = new GameLoop(param1.background);
         this.gameLoop.updated.add(this.refresh);
         this.paused = false;
         this.start();
      }
      
      private function start() : void
      {
         var _loc1_:Number = Number(Dungeon.DungeonConfig["height_fighters"]);
         var _loc2_:FinnView = this.bossDungeonView.getFinnView();
         var _loc3_:BossView = this.bossDungeonView.getBossView();
         _loc2_.y = _loc1_;
         _loc3_.y = _loc1_;
         _loc2_.x = Dungeon.DungeonConfig["position_finn"] - 2.1 * Dungeon.DungeonConfig["lenght_step"];
         _loc2_.putIn(this.bossDungeonView.background.arena);
         this.walk = new RunAnimation(4,true,false);
         this.walk.getAtFinish().add(this.endPositionating);
         _loc2_.animate(this.walk);
         _loc3_.animate(new IdleAnimation());
         this.gameLoop.start();
      }
      
      public function resume() : void
      {
         if(this.paused)
         {
            this.gameLoop.start();
            this.bossDungeonView.getFinnView().resume();
            this.bossDungeonView.getBossView().resume();
            this.paused = false;
         }
      }
      
      public function pause() : void
      {
         if(!this.paused)
         {
            this.gameLoop.stop();
            this.bossDungeonView.getFinnView().pause();
            this.bossDungeonView.getBossView().pause();
            this.paused = true;
         }
      }
      
      private function refresh(param1:int) : void
      {
         this.bossDungeonView.getFinnView().x = this.bossDungeonView.getFinnView().x + BackgroundView.ARENA_VELOCITY;
      }
      
      private function endPositionating(param1:IFighterAnimation) : void
      {
         this.walk = null;
         this.gameLoop.stop();
         this.atEnd();
      }
      
      public function playMusic() : void
      {
         main.soundManager.playMusic(GameSounds.BOSS_MUSIC);
      }
      
      public function stopMusic() : void
      {
         main.soundManager.stopMusic(GameSounds.BOSS_MUSIC);
      }
      
      public function clear() : void
      {
         this.gameLoop.updated.clear();
         this.gameLoop = null;
         if(this.walk != null)
         {
            this.walk.kill();
            this.walk = null;
         }
         this.bossDungeonView = null;
         this.atEnd = null;
      }
   }
}

