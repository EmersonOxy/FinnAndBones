package main_game.bubblegum
{
   import main_game.items.Item;
   
   public class MixRecipe
   {
      
      private var item1Id:Item;
      
      private var item2Id:Item;
      
      private var resultId:String;
      
      public function MixRecipe(param1:Item, param2:Item, param3:String)
      {
         super();
         this.item1Id = param1;
         this.item2Id = param2;
         this.resultId = param3;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:MixRecipe = param1 as MixRecipe;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.result == _loc2_.result && (_loc2_.item1.getID() == this.item1.getID() && _loc2_.item2.getID() == this.item2.getID() || _loc2_.item2.getID() == this.item1.getID() && _loc2_.item1.getID() == this.item2.getID());
      }
      
      public function get item1() : Item
      {
         return this.item1Id;
      }
      
      public function get item2() : Item
      {
         return this.item2Id;
      }
      
      public function get result() : String
      {
         return this.resultId;
      }
   }
}

