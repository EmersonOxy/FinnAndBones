package main_game.mixer
{
   public class MixData
   {
      
      private var recipes:Vector.<Recipe>;
      
      public function MixData(param1:Object)
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         super();
         this.recipes = new Vector.<Recipe>();
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            this.recipes.push(new Recipe(int(_loc2_),_loc3_.item1,_loc3_.item2,_loc3_.itemResult,_loc3_.showAdvice.toLowerCase() == "true"));
         }
      }
      
      public function getRecipes() : Vector.<Recipe>
      {
         return this.recipes;
      }
      
      public function getRecipeById(param1:int) : Recipe
      {
         var _loc2_:Recipe = this.recipes[Math.max(param1 - 1,0)];
         var _loc3_:int = 0;
         while(_loc3_ < this.recipes.length && _loc2_.getId() != param1)
         {
            _loc2_ = this.recipes[_loc3_];
            _loc3_++;
         }
         if(_loc2_.getId() == param1)
         {
            return _loc2_;
         }
         return null;
      }
   }
}

