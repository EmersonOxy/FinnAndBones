package sound
{
   import main_game.boss_dungeon.Boss;
   
   public class BossSoundManager extends FighterSoundManager
   {
      
      private var boss:Boss;
      
      public function BossSoundManager(param1:Boss)
      {
         this.boss = param1;
         super("",GameSounds.BOSS_ATTACK,GameSounds.BOSS_LOSE,"",GameSounds.SHIELD_BLOCK);
      }
      
      override public function playHurt() : void
      {
         hurt = GameSounds.BOSS_HURT;
         super.playHurt();
      }
   }
}

