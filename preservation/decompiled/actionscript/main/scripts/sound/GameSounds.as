package sound
{
   import cb.utils.Random;
   
   public class GameSounds
   {
      
      public static const soundsToLoad:Array = ["mapSounds.snd","combatSounds0.snd","combatSounds1.snd","combatSounds2.snd","combatSounds3.snd"];
      
      private static const variations:Array = ["_a","_b","_c","_d","_e","_f","_g"];
      
      public static const MOUSE_OVER:String = "mouse_over";
      
      public static const POP_UP:String = "pop_up";
      
      public static const BUTTON_CLICK:String = "button_click";
      
      public static const ITEM_CLICK:String = "item_click";
      
      public static const MIX_CLICK:String = "mix_click";
      
      public static const ITEM_DROP_OK:String = "item_drop_ok";
      
      public static const ITEM_DROP_FAIL:String = "item_drop_back";
      
      public static const MIX_DONE:String = "mix_done";
      
      public static const ITEM_TRASH:String = "item_trash";
      
      public static const CONSUMABLE:String = "consumable";
      
      public static const INTRO_MUSIC:String = "intro_music";
      
      public static const MAP_MUSIC:String = "map_music";
      
      public static const COMBAT_MUSIC:String = "combat_music";
      
      public static const COMBAT_MUSIC2:String = "combat_music2";
      
      public static const BOSS_MUSIC:String = "boss_music";
      
      public static const FIST_ATTACK:String = "fist_attack";
      
      public static const SWORD_ATTACK:String = "sword_attack";
      
      public static const FIRE_ATTACK:String = "fire_attack";
      
      public static const ICE_ATTACK:String = "ice_attack";
      
      public static const SHIELD_BLOCK:String = "shield_block";
      
      public static const SHIELD_BLOCK_ICE:String = "shield_block_ice";
      
      public static const SHIELD_BLOCK_FIRE:String = "shield_block_fire";
      
      public static const FIST_BLOCK:String = "fist_block";
      
      public static const FINN_LOSE:String = "finn_lose";
      
      public static const DUNGEON_COMPLETED:String = "dungeon_completed";
      
      public static const ENEMY2_ATTACK:String = "enemy2_attack";
      
      public static const ENEMY2_ATTACK_ICE:String = "enemy2_attack_ice";
      
      public static const ENEMY2_ATTACK_FIRE:String = "enemy2_attack_fire";
      
      public static const CRITICAL:String = "critical";
      
      public static const CRITICAL_SHIELD:String = "critical_shield";
      
      public static const LEVEL_UP:String = "level_up";
      
      public static const WIN_MUSIC:String = "youwin_music";
      
      public static const TRANSITION_IN:String = "transition_open";
      
      public static const TRANSITION_OUT:String = "transition_close";
      
      public static const BOSS_ATTACK:String = "boss_attack";
      
      public static const BOSS_LOSE:String = "boss_die";
      
      public static const SMOKE:String = "loot";
      
      public static const SORCERER_ATTACK:String = "sorcerer_attack";
      
      public static const AX_ATTACK:String = "ax_attack";
      
      public function GameSounds()
      {
         super();
      }
      
      public static function get mapSounds() : Array
      {
         return [soundsToLoad[0]];
      }
      
      public static function get combatSounds() : Array
      {
         return soundsToLoad.slice(1,4);
      }
      
      public static function get combatSoundsBasic() : Array
      {
         return soundsToLoad.slice(1,3);
      }
      
      public static function get bossSounds() : Array
      {
         return soundsToLoad.slice(1);
      }
      
      private static function getVariation(param1:int) : String
      {
         return variations[Random.nextInt(param1 - 1)];
      }
      
      public static function get FINN_HURT() : String
      {
         return "finn_hurt" + getVariation(3);
      }
      
      public static function get ENEMY1_HURT() : String
      {
         return "enemy1_hurt" + getVariation(2);
      }
      
      public static function get ENEMY1_LOSE() : String
      {
         return "enemy1_lose" + getVariation(2);
      }
      
      public static function get ENEMY2_HURT() : String
      {
         return "enemy2_hurt" + getVariation(2);
      }
      
      public static function get ENEMY2_LOSE() : String
      {
         return "enemy2_lose" + getVariation(2);
      }
      
      public static function get BOSS_HURT() : String
      {
         return "boss_hurt" + getVariation(2);
      }
   }
}

