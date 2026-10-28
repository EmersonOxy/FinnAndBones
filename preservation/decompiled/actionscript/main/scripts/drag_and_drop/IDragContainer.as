package drag_and_drop
{
   import main_game.items.Item;
   
   public interface IDragContainer
   {
      
      function remove(param1:Item) : void;
      
      function add(param1:Item) : void;
      
      function moveFrom(param1:Item, param2:IDragContainer) : void;
      
      function canSwap(param1:IDragContainer) : Boolean;
      
      function itsCompatible(param1:Item, param2:IDragContainer) : Boolean;
      
      function canMoveFrom(param1:Item, param2:IDragContainer) : Boolean;
      
      function getContainToDrag() : Item;
      
      function clear() : void;
   }
}

