package view.screens.main_game.dungeon
{
   import view.screens.main_game.boss_dungeon.InnerBossDungeonView;
   
   public class EmptyInnerView implements InnerBossDungeonView
   {
      
      private var _soundTrack:String;
      
      public function EmptyInnerView(param1:String)
      {
         super();
         this._soundTrack = param1;
      }
      
      public function resume() : void
      {
      }
      
      public function pause() : void
      {
      }
      
      public function clear() : void
      {
      }
      
      public function playMusic() : void
      {
         main.soundManager.playMusic(this._soundTrack);
      }
      
      public function stopMusic() : void
      {
         main.soundManager.stopMusic(this._soundTrack);
      }
   }
}

