package view.screens.main_game.cookBook
{
   import flash.display.MovieClip;
   import main_game.mixer.MixStrategy;
   import main_game.mixer.Recipe;
   
   public class CookBookPage
   {
      
      private static const RECIPES:uint = 6;
      
      private var bg:MovieClip;
      
      private var recipes:Vector.<RecipeView>;
      
      public function CookBookPage(param1:Array)
      {
         super();
         this.bg = main.swfLoader.getObject("assets.RecipesContainer") as MovieClip;
         this.initializeRecipes(param1);
      }
      
      private function initializeRecipes(param1:Array) : void
      {
         var _loc3_:Recipe = null;
         var _loc4_:RecipeView = null;
         this.recipes = new Vector.<RecipeView>();
         var _loc2_:int = 0;
         while(_loc2_ < RECIPES)
         {
            _loc3_ = null;
            if(_loc2_ < param1.length)
            {
               _loc3_ = MixStrategy.getRecipe(param1[_loc2_]);
               _loc4_ = new RecipeView(this.bg["recipe" + (_loc2_ + 1).toString()],_loc3_);
               this.recipes.push(_loc4_);
            }
            else
            {
               this.bg.removeChild(this.bg["recipe" + (_loc2_ + 1).toString()]);
            }
            _loc2_++;
         }
      }
      
      public function getMc() : MovieClip
      {
         return this.bg;
      }
      
      public function pop() : void
      {
         if(this.bg.parent != null)
         {
            this.bg.parent.removeChild(this.bg);
         }
         this.clear();
      }
      
      public function clear() : void
      {
         var _loc1_:RecipeView = null;
         for each(_loc1_ in this.recipes)
         {
            _loc1_.clear();
         }
         this.recipes = null;
         this.bg = null;
      }
   }
}

