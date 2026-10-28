package main_game.map
{
   public class SpecialLevel extends Level
   {
      
      public function SpecialLevel(param1:String, param2:uint = 1)
      {
         super(param1,param2);
      }
      
      override public function isSpecial() : Boolean
      {
         return true;
      }
      
      override public function getName() : String
      {
         return main.locale.get("specialDungeonName");
      }
      
      override public function getArea() : uint
      {
         if(getDungeonId() == "26")
         {
            return 1;
         }
         if(getDungeonId() == "27")
         {
            return 2;
         }
         return 3;
      }
   }
}

