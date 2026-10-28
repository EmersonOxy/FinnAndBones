package main_game.items
{
   import main_game.item_containers.ItemContainer;
   
   public class Category
   {
      
      public static var SHIELD_CATEGORY:String = "S";
      
      public static var EQUIPABLE_CATEGORY:String = "E";
      
      public static var WEAPON_CATEGORY:String = "W";
      
      public static var CONSUMABLE_CATEGORY:String = "C";
      
      protected var item:Item;
      
      public function Category(param1:Item, param2:Object)
      {
         super();
         this.item = param1;
      }
      
      public function get type() : String
      {
         throw new Error("Abstract class");
      }
      
      public function canBeContained(param1:ItemContainer) : Boolean
      {
         return true;
      }
      
      public function clear() : void
      {
         this.item = null;
      }
   }
}

