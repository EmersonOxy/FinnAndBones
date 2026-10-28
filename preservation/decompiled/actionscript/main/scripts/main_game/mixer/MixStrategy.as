package main_game.mixer
{
   import flash.utils.Dictionary;
   import main_game.character.stats.StatType;
   import main_game.items.*;
   import main_game.items.modifiers.IModifier;
   import main_game.items.modifiers.NullModifier;
   
   public class MixStrategy
   {
      
      private static var recipes:MixData;
      
      public function MixStrategy()
      {
         super();
      }
      
      public static function set config(param1:Dictionary) : void
      {
         recipes = new MixData(param1);
      }
      
      public static function get mixConfig() : Object
      {
         return main.config.get("MixConfig");
      }
      
      public static function isSpecial(param1:Item) : Boolean
      {
         var _loc2_:Recipe = null;
         for each(_loc2_ in recipes.getRecipes())
         {
            if(_loc2_.isResult(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getSpecialMixId(param1:Item, param2:Item, param3:Boolean = false) : Recipe
      {
         var _loc4_:Recipe = null;
         for each(_loc4_ in recipes.getRecipes())
         {
            if(_loc4_.areIngredients(param1,param2,param3))
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function getRecipe(param1:int) : Recipe
      {
         return recipes.getRecipeById(param1);
      }
      
      public static function removeMix(param1:String) : String
      {
         if(param1.search("Mix_") == 0)
         {
            return param1.substring(4);
         }
         return param1;
      }
      
      public function getMix(param1:Item, param2:Item) : MixResult
      {
         var _loc5_:Item = null;
         var _loc6_:Boolean = false;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc3_:ItemFactory = ItemFactory.getInstance();
         var _loc4_:Recipe = getSpecialMixId(param1,param2);
         if(_loc4_ != null)
         {
            _loc6_ = false;
            if(param1.getCategory().type == Category.SHIELD_CATEGORY || param1.getCategory().type == Category.WEAPON_CATEGORY)
            {
               _loc7_ = _loc3_.getConfigOfItem(_loc4_.result);
               _loc8_ = "Mix_" + removeMix(_loc4_.result);
               _loc9_ = new Object();
               for(_loc10_ in _loc7_)
               {
                  _loc9_[_loc10_] = _loc7_[_loc10_];
               }
               _loc9_.FirstModifier = param1.getPrimaryModifier().toObject();
               _loc9_.FirstModifier.Value = Math.max(_loc9_.FirstModifier.Value,_loc7_.FirstModifier.Value);
               if(param1.getSecondaryModifier().getCategory() != StatType.NULL)
               {
                  _loc9_.SecondModifier = param1.getSecondaryModifier().toObject();
                  _loc6_ = true;
               }
               this.applyLimitToModifiers(_loc9_);
               if(_loc9_.FirstModifier.Value != _loc7_.FirstModifier.Value)
               {
                  _loc6_ = true;
               }
            }
            if(!_loc6_)
            {
               _loc5_ = _loc3_.getItem(_loc4_.result);
            }
            else
            {
               _loc5_ = _loc3_.getCustomItem(_loc8_,_loc9_);
            }
            return new MixResult(_loc5_,_loc4_);
         }
         return new MixResult(this.makeMix(param1,param2));
      }
      
      private function getSpecialConfigForWeapons(param1:Item, param2:Recipe) : Object
      {
         var prop:String = null;
         var primary:Item = param1;
         var recipe:Recipe = param2;
         var equalOrNull:Function = function(param1:Object, param2:IModifier):Boolean
         {
            return StatType.parse(param1.Category) == StatType.NULL || StatType.parse(param1.Category) == param2.getCategory();
         };
         var factory:ItemFactory = ItemFactory.getInstance();
         var initialConfig:Object = factory.getConfigOfItem(recipe.result);
         var finalConfig:Object = new Object();
         for(prop in initialConfig)
         {
            finalConfig[prop] = initialConfig[prop];
         }
         if(equalOrNull(finalConfig.FirstModifier,primary.getPrimaryModifier()))
         {
            finalConfig.FirstModifier = primary.getPrimaryModifier().toObject();
            finalConfig.FirstModifier.Value = Math.max(finalConfig.FirstModifier.Value,initialConfig.FirstModifier.Value);
         }
         if(equalOrNull(finalConfig.SecondModifier,primary.getSecondaryModifier()))
         {
            finalConfig.SecondModifier = primary.getSecondaryModifier().toObject();
            finalConfig.SecondModifier.Value = Math.max(finalConfig.SecondModifier.Value,initialConfig.SecondModifier.Value);
         }
         this.applyLimitToModifiers(finalConfig);
         if(finalConfig.FirstModifier.Value != initialConfig.FirstModifier.Value || finalConfig.SecondModifier.Value != initialConfig.SecondModifier.Value)
         {
            return finalConfig;
         }
         return null;
      }
      
      private function makeMix(param1:Item, param2:Item) : Item
      {
         var _loc3_:String = "Mix_" + removeMix(param1.getID());
         var _loc4_:Object = new Object();
         _loc4_.NameString = param1.name;
         _loc4_.Category = param1.getCategory().type;
         var _loc5_:IModifier = param1.getPrimaryModifier();
         var _loc6_:IModifier = param1.getSecondaryModifier();
         var _loc7_:IModifier = param2.getPrimaryModifier();
         var _loc8_:IModifier = param2.getSecondaryModifier();
         var _loc9_:Boolean = this.isConsumable(param1);
         _loc4_.MovieClip = param1.getMcName();
         if(_loc5_.getCategory() == StatType.HEALTH && _loc6_.getCategory() == StatType.NULL)
         {
            _loc4_.Duration = param2.getDuration();
         }
         else
         {
            _loc4_.Duration = param1.getDuration();
         }
         _loc4_.MaxMod = param1.getMaxMod();
         var _loc10_:Number = Number(mixConfig.primaryModifier);
         var _loc11_:Number = Number(mixConfig.secondaryModifier);
         if(this.isConsumable(param1) && this.isConsumable(param2))
         {
            _loc11_ = Number(mixConfig.potionModifier);
         }
         if(this.sameCategory(_loc5_,_loc7_))
         {
            _loc4_.FirstModifier = this.combine(_loc5_,_loc7_,_loc10_,_loc11_,_loc9_);
            _loc4_.SecondModifier = this.combine(_loc6_,_loc8_,_loc10_,_loc11_,_loc9_);
         }
         else
         {
            _loc4_.FirstModifier = this.combine(_loc5_,new NullModifier(),_loc10_,_loc10_,_loc9_);
            _loc4_.SecondModifier = this.combine(_loc7_,_loc6_,_loc11_,_loc10_,_loc9_);
         }
         this.applyLimitToModifiers(_loc4_);
         _loc4_.Element = param1.getElement().type;
         _loc4_.MixTime = param1.getMixTime();
         return ItemFactory.getInstance().getCustomItem(_loc3_,_loc4_);
      }
      
      private function applyLimitToModifiers(param1:Object) : void
      {
         var _loc2_:Number = Number(mixConfig.secondModMaxPercent);
         var _loc3_:Number = Number(param1.MaxMod);
         _loc2_ = Math.round(_loc3_ * _loc2_ / 100);
         param1.FirstModifier.Value = Math.max(-_loc3_,Math.min(_loc3_,param1.FirstModifier.Value));
         if(param1.SecondModifier.Value != null)
         {
            param1.SecondModifier.Value = Math.max(-_loc2_,Math.min(_loc2_,param1.SecondModifier.Value));
         }
      }
      
      private function combine(param1:IModifier, param2:IModifier, param3:Number = 1, param4:Number = 1, param5:Boolean = false) : Object
      {
         var _loc6_:Object = new Object();
         if(param1.getCategory() == StatType.NULL)
         {
            if(param2.getCategory() == StatType.NULL)
            {
               _loc6_.Category = null;
               _loc6_.Value = null;
            }
            else
            {
               _loc6_.Category = param2.getCategory();
               _loc6_.Value = this.getNumber(param2.getValue(),param4);
            }
         }
         else if(param2.getCategory() != StatType.NULL && this.sameCategory(param1,param2))
         {
            _loc6_.Category = param1.getCategory();
            _loc6_.Value = this.getNumber(param1.getValue(),param3) + this.getNumber(param2.getValue(),param4);
         }
         else
         {
            _loc6_.Category = param1.getCategory();
            _loc6_.Value = this.getNumber(param1.getValue(),param3);
         }
         if(_loc6_.Category == StatType.MAX_HP || _loc6_.Category == StatType.HEALTH)
         {
            if(param5)
            {
               _loc6_.Category = StatType.HEALTH;
            }
            else
            {
               _loc6_.Category = StatType.MAX_HP;
            }
         }
         if(_loc6_.Category != null)
         {
            _loc6_.Category = StatType.toString(_loc6_.Category);
         }
         return _loc6_;
      }
      
      private function getNumber(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Math.floor(param1 * param2);
         if(param1 < 0)
         {
            return Math.min(-1,_loc3_);
         }
         if(param1 > 0)
         {
            return Math.max(1,_loc3_);
         }
         return _loc3_;
      }
      
      private function isConsumable(param1:Item) : Boolean
      {
         return param1.getCategory().type == Category.CONSUMABLE_CATEGORY;
      }
      
      private function sameCategory(param1:IModifier, param2:IModifier) : Boolean
      {
         return param1.getCategory() == param2.getCategory() || this.modifiesHealth(param1) && this.modifiesHealth(param2);
      }
      
      private function modifiesHealth(param1:IModifier) : Boolean
      {
         return param1.getCategory() == StatType.MAX_HP || param1.getCategory() == StatType.HEALTH;
      }
      
      private function healthCategory(param1:Boolean) : int
      {
         if(param1)
         {
            return StatType.HEALTH;
         }
         return StatType.MAX_HP;
      }
   }
}

