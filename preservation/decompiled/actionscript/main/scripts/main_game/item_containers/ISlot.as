package main_game.item_containers
{
   import cb.signals.Signal;
   import drag_and_drop.IDragContainer;
   import main_game.items.Item;
   
   public interface ISlot extends IDragContainer
   {
      
      function get onChange() : Signal;
      
      function isEmpty() : Boolean;
      
      function getContent() : Item;
   }
}

