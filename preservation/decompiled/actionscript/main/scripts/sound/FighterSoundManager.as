package sound
{
   public class FighterSoundManager
   {
      
      protected var hurt:String;
      
      protected var attack:String;
      
      protected var critical:String;
      
      protected var die:String;
      
      protected var block:String;
      
      protected var lastSound:String;
      
      public function FighterSoundManager(param1:String, param2:String, param3:String, param4:String, param5:String)
      {
         super();
         this.hurt = param1;
         this.attack = param2;
         this.die = param3;
         this.critical = param4;
         this.block = param5;
      }
      
      public function playHurt() : void
      {
         main.soundManager.playFx(this.hurt);
      }
      
      public function playBlock() : void
      {
         main.soundManager.playFx(this.block);
      }
      
      public function playDie() : void
      {
         main.soundManager.playFx(this.die);
      }
      
      public function playAttack() : void
      {
         main.soundManager.playFx(this.attack);
      }
      
      public function playCritical() : void
      {
         main.soundManager.playFx(this.critical);
      }
      
      public function pause() : void
      {
         if(this.lastSound != null)
         {
            if(main.soundManager.isPlaying(this.lastSound))
            {
               main.soundManager.pauseSound(this.lastSound);
            }
            else
            {
               this.lastSound = null;
            }
         }
      }
      
      public function resume() : void
      {
         if(this.lastSound != null)
         {
            main.soundManager.resumeSound(this.lastSound);
         }
      }
   }
}

