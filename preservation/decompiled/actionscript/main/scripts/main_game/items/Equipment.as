package main_game.items
{
   import main_game.item_containers.ItemContainer;
   
   public class Equipment extends Category
   {
      
      public function Equipment(param1:Item, param2:Object)
      {
         super(param1,param2);
      }
      
      override public function get type() : String
      {
         return EQUIPABLE_CATEGORY;
      }
      
      override public function canBeContained(param1:ItemContainer) : Boolean
      {
         return param1.canContainEquipment();
      }
   }
}

