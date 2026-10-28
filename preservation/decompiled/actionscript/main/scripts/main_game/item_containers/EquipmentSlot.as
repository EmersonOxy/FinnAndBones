package main_game.item_containers
{
   public class EquipmentSlot extends Slot
   {
      
      public function EquipmentSlot()
      {
         super();
      }
      
      override public function canContainConsumable() : Boolean
      {
         return false;
      }
      
      override public function canContainWeapon() : Boolean
      {
         return false;
      }
      
      override public function canContainShield() : Boolean
      {
         return false;
      }
   }
}

