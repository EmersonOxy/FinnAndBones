package main_game.character.stats
{
   import flash.display.MovieClip;
   
   public class StatType
   {
      
      public static const NULL:int = -1;
      
      public static const LUCK:int = 1;
      
      public static const ATTACK:int = 2;
      
      public static const DEFENSE:int = 3;
      
      public static const HEALTH:int = 4;
      
      public static const MAX_HP:int = 5;
      
      public static const EXPERIENCE:int = 6;
      
      public static const MAX_XP:int = 7;
      
      public static const BASE_LUCK:int = 8;
      
      public static const BASE_ATTACK:int = 9;
      
      public static const BASE_DEFENSE:int = 10;
      
      public static const BASE_HEALTH:int = 11;
      
      public static const BASE_XP:int = 12;
      
      public function StatType()
      {
         super();
      }
      
      public static function getStatTypes() : Array
      {
         return [LUCK,ATTACK,DEFENSE,HEALTH,MAX_HP];
      }
      
      public static function parse(param1:String) : int
      {
         if(param1 == null || param1 == "")
         {
            return NULL;
         }
         switch(param1)
         {
            case "L":
               return LUCK;
            case "A":
               return ATTACK;
            case "D":
               return DEFENSE;
            case "H":
               return HEALTH;
            case "MH":
               return MAX_HP;
            case "XP":
               return EXPERIENCE;
            case "MX":
               return MAX_XP;
            default:
               throw new Error("Parse error");
         }
      }
      
      public static function toString(param1:int) : String
      {
         switch(param1)
         {
            case LUCK:
               return "L";
            case ATTACK:
               return "A";
            case DEFENSE:
               return "D";
            case HEALTH:
               return "H";
            case MAX_HP:
               return "MH";
            case EXPERIENCE:
               return "XP";
            case MAX_XP:
               return "MX";
            default:
               throw new Error("Parse error");
         }
      }
      
      public static function stringOfStat(param1:int) : String
      {
         switch(param1)
         {
            case LUCK:
               return "Luck";
            case ATTACK:
               return "Attack";
            case DEFENSE:
               return "Defense";
            case HEALTH:
               return "Health";
            case MAX_HP:
               return "Health";
            case EXPERIENCE:
               return "Experience";
            case MAX_XP:
               return "Experience";
            default:
               throw new Error("Parse error");
         }
      }
      
      public static function setMcIcon(param1:MovieClip, param2:int) : void
      {
         switch(param2)
         {
            case StatType.LUCK:
               param1.gotoAndStop("luck");
               break;
            case StatType.DEFENSE:
               param1.gotoAndStop("defence");
               break;
            case StatType.ATTACK:
               param1.gotoAndStop("attack");
               break;
            case StatType.HEALTH:
               param1.gotoAndStop("health");
               break;
            case StatType.MAX_HP:
               param1.gotoAndStop("max_health");
         }
      }
   }
}

