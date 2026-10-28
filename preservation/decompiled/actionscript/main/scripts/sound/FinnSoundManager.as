package sound
{
   import main_game.character.Finn;
   import main_game.character.Gear;
   import main_game.items.Item;
   
   public class FinnSoundManager extends FighterSoundManager
   {
      
      public function FinnSoundManager(param1:Finn)
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:Gear = param1.gear;
         var _loc5_:Item = _loc2_.weapon.getContent();
         if(_loc5_ == null)
         {
            _loc3_ = GameSounds.FIST_ATTACK;
         }
         else if(_loc5_.getElement().isOfFire)
         {
            _loc3_ = GameSounds.FIRE_ATTACK;
         }
         else if(_loc5_.getElement().isOfIce)
         {
            _loc3_ = GameSounds.ICE_ATTACK;
         }
         else if(_loc5_.getID() == "LegendarySword")
         {
            _loc3_ = GameSounds.SORCERER_ATTACK;
         }
         else if(_loc5_.getID() == "MarcelineBass")
         {
            _loc3_ = GameSounds.AX_ATTACK;
         }
         else
         {
            _loc3_ = GameSounds.SWORD_ATTACK;
         }
         var _loc6_:Item = _loc2_.shield.getContent();
         var _loc7_:String = GameSounds.CRITICAL_SHIELD;
         if(_loc6_ == null)
         {
            _loc4_ = GameSounds.FIST_BLOCK;
            _loc7_ = GameSounds.CRITICAL;
         }
         else if(_loc6_.getElement().isOfFire)
         {
            _loc4_ = GameSounds.SHIELD_BLOCK_FIRE;
         }
         else if(_loc6_.getElement().isOfIce)
         {
            _loc4_ = GameSounds.SHIELD_BLOCK_ICE;
         }
         else
         {
            _loc4_ = GameSounds.SHIELD_BLOCK;
         }
         super("",_loc3_,GameSounds.FINN_LOSE,_loc7_,_loc4_);
      }
      
      override public function playHurt() : void
      {
         this.hurt = GameSounds.FINN_HURT;
         super.playHurt();
      }
      
      override public function playDie() : void
      {
         main.soundManager.stopMusic();
         super.playDie();
      }
   }
}

