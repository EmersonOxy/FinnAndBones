package main_game.map
{
   import main_game.element.Element;
   
   public class LegendaryLevel extends Level
   {
      
      private var theElement:Element;
      
      private var date:Date;
      
      public function LegendaryLevel(param1:String, param2:Element, param3:Date, param4:uint = 1)
      {
         super(param1,param4);
         this.theElement = param2;
         this.date = param3;
      }
      
      override public function isLegendary() : Boolean
      {
         return true;
      }
      
      public function getDate() : Date
      {
         return this.date;
      }
      
      public function get element() : Element
      {
         return this.theElement;
      }
      
      override public function getName() : String
      {
         return main.locale.get("legendaryDungeonName");
      }
      
      override public function getArea() : uint
      {
         return 1;
      }
   }
}

