package sound
{
   import main_game.character.Enemy;
   import main_game.element.Element;
   
   public class EnemySoundManager extends FighterSoundManager
   {
      
      private var hurtFunction:Function;
      
      private var dieFunction:Function;
      
      public function EnemySoundManager(param1:Enemy)
      {
         var hurt:String = null;
         var attack:String = null;
         var die:String = null;
         var critical:String = null;
         var block:String = null;
         var evade:String = null;
         var enemy:Enemy = param1;
         var type:String = enemy.getType();
         var element:Element = enemy.getElement();
         if(type == "1")
         {
            this.hurtFunction = function():String
            {
               return GameSounds.ENEMY1_HURT;
            };
            this.dieFunction = function():String
            {
               return GameSounds.ENEMY1_LOSE;
            };
            if(element.isOfFire)
            {
               attack = GameSounds.FIRE_ATTACK;
               evade = GameSounds.SHIELD_BLOCK_FIRE;
            }
            else if(element.isOfIce)
            {
               attack = GameSounds.ICE_ATTACK;
               evade = GameSounds.SHIELD_BLOCK_ICE;
            }
            else
            {
               attack = GameSounds.SWORD_ATTACK;
               evade = GameSounds.SHIELD_BLOCK;
            }
         }
         else if(type == "2")
         {
            this.hurtFunction = function():String
            {
               return GameSounds.ENEMY2_HURT;
            };
            this.dieFunction = function():String
            {
               return GameSounds.ENEMY2_LOSE;
            };
            if(element.isOfFire)
            {
               attack = GameSounds.ENEMY2_ATTACK_FIRE;
               evade = GameSounds.SHIELD_BLOCK_FIRE;
            }
            else if(element.isOfIce)
            {
               attack = GameSounds.ENEMY2_ATTACK_ICE;
               evade = GameSounds.SHIELD_BLOCK_ICE;
            }
            else
            {
               attack = GameSounds.ENEMY2_ATTACK;
               evade = GameSounds.SHIELD_BLOCK;
            }
         }
         super("",attack,"","",evade);
      }
      
      override public function playHurt() : void
      {
         hurt = this.hurtFunction();
         super.playHurt();
      }
      
      override public function playDie() : void
      {
         die = this.dieFunction();
         super.playDie();
      }
   }
}

