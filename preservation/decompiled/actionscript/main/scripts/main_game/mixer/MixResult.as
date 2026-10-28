package main_game.mixer
{
   import main_game.items.Item;
   
   public class MixResult
   {
      
      private var _item:Item;
      
      private var _recipe:Recipe;
      
      public function MixResult(param1:Item, param2:Recipe = null)
      {
         super();
         this._item = param1;
         this._recipe = param2;
      }
      
      public function get recipe() : Recipe
      {
         return this._recipe;
      }
      
      public function get item() : Item
      {
         return this._item;
      }
   }
}

