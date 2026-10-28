package main_game.items
{
   import main_game.item_containers.ItemContainer;
   
   public class Shield extends Category
   {
      
      public function Shield(param1:Item, param2:Object)
      {
         super(param1,param2);
      }
      
      override public function get type() : String
      {
         return SHIELD_CATEGORY;
      }
      
      override public function canBeContained(param1:ItemContainer) : Boolean
      {
         return param1.canContainShield();
      }
   }
}

