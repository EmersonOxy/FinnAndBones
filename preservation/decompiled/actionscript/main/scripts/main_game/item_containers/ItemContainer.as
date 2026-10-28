package main_game.item_containers
{
   public interface ItemContainer
   {
      
      function canContainEquipment() : Boolean;
      
      function canContainWeapon() : Boolean;
      
      function canContainConsumable() : Boolean;
      
      function canContainShield() : Boolean;
   }
}

