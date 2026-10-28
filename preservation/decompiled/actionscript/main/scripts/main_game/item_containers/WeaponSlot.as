package main_game.item_containers
{
   public class WeaponSlot extends Slot
   {
      
      public function WeaponSlot()
      {
         super();
      }
      
      override public function canContainConsumable() : Boolean
      {
         return false;
      }
      
      override public function canContainEquipment() : Boolean
      {
         return false;
      }
      
      override public function canContainShield() : Boolean
      {
         return false;
      }
   }
}

