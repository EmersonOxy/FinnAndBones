package view.screens.main_game.boss_dungeon
{
   import main_game.boss_dungeon.Boss;
   import main_game.boss_dungeon.BossFight;
   import main_game.character.CharacterFactory;
   import main_game.dungeon.IFight;
   import sound.GameSounds;
   import view.figthers.FinnView;
   import view.screens.main_game.dungeon.DungeonView;
   import view.screens.main_game.dungeon.WinWindow;
   import view.screens.main_game.states.IDungeonState;
   
   public class BossDungeonView extends DungeonView
   {
      
      private var bossView:BossView;
      
      private var won:Boolean = false;
      
      public function BossDungeonView(param1:IDungeonState)
      {
         super(param1);
         this.timeLine.clear();
      }
      
      override protected function initialize() : void
      {
         this.bossView = CharacterFactory.getInstance().getBossView(dungeon.getDungeon().currentFight.getEnemy() as Boss);
         super.initialize();
      }
      
      override protected function start() : void
      {
         this.innerView.clear();
         this.innerView = new EnterBossDungeon(this,dungeon.getDungeon().startFight);
      }
      
      public function getBossView() : BossView
      {
         return this.bossView;
      }
      
      public function getFinnView() : FinnView
      {
         return this.finnView;
      }
      
      override protected function playMusic() : void
      {
         (innerView as InnerBossDungeonView).playMusic();
      }
      
      override protected function stopMusic() : void
      {
         (innerView as InnerBossDungeonView).stopMusic();
      }
      
      override protected function makeWinWindow() : WinWindow
      {
         this.won = true;
         return new WinBossDungeonWindow(getLoot(),getStats(),dungeon.getDungeon().getLevel().isCleared(),this.onToOutro);
      }
      
      private function onToOutro() : void
      {
         (dungeon as BossDungeonState).onToOutro.emit();
      }
      
      override public function onFight(param1:IFight) : void
      {
         this.innerView.clear();
         this.innerView = new BossFightView(this,dungeon.getDungeon().currentFight as BossFight);
      }
      
      override protected function endEnterFinishWindow() : void
      {
         super.endEnterFinishWindow();
         if(this.bossView)
         {
            this.bossView.clear();
            this.bossView = null;
         }
      }
      
      override protected function get soundTrack() : String
      {
         return GameSounds.BOSS_MUSIC;
      }
      
      override public function clear() : void
      {
         super.clear();
         if(this.bossView)
         {
            this.bossView.clear();
            this.bossView = null;
         }
      }
   }
}

