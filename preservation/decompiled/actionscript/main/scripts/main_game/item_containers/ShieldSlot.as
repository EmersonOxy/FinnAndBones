package main_game.item_containers
{
   public class ShieldSlot extends Slot
   {
      
      public function ShieldSlot()
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
      
      override public function canContainWeapon() : Boolean
      {
         return false;
      }
   }
}

