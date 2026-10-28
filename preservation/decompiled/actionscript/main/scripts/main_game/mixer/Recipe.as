package main_game.mixer
{
   import main_game.items.Item;
   
   public class Recipe
   {
      
      private var id:int;
      
      private var i1:String;
      
      private var i2:String;
      
      private var res:String;
      
      private var show:Boolean;
      
      public function Recipe(param1:int, param2:String, param3:String, param4:String, param5:Boolean)
      {
         super();
         this.id = param1;
         this.i1 = param2;
         this.i2 = param3;
         this.res = param4;
         this.show = param5;
      }
      
      public function getId() : int
      {
         return this.id;
      }
      
      public function get mustShow() : Boolean
      {
         return this.show;
      }
      
      public function areIngredients(param1:Item, param2:Item, param3:Boolean = false) : Boolean
      {
         var _loc4_:String = MixStrategy.removeMix(param1.getID());
         var _loc5_:String = MixStrategy.removeMix(param2.getID());
         return _loc4_ == this.i1 && _loc5_ == this.i2 || !param3 && _loc5_ == this.i1 && _loc4_ == this.i2;
      }
      
      public function isResult(param1:Item) : Boolean
      {
         return param1.getID() == this.res;
      }
      
      public function get primary() : String
      {
         return this.i1;
      }
      
      public function get secondary() : String
      {
         return this.i2;
      }
      
      public function get result() : String
      {
         return this.res;
      }
   }
}

