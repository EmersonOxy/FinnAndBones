package main_game.items
{
   import main_game.character.stats.StatType;
   import main_game.element.*;
   import main_game.item_containers.ItemContainer;
   import main_game.items.modifiers.HealthModifier;
   import main_game.items.modifiers.IModifier;
   import main_game.items.modifiers.MaxHealthModifier;
   import main_game.items.modifiers.Modifier;
   import main_game.items.modifiers.NullModifier;
   
   public class Item
   {
      
      protected var id:String;
      
      public var name:String;
      
      protected var mc_name:String;
      
      protected var maxMod:int;
      
      protected var mix_time:Number;
      
      protected var primaryModifier:IModifier;
      
      protected var secondaryModifier:IModifier;
      
      protected var element:Element;
      
      protected var category:Category;
      
      protected var duration:int;
      
      public function Item(param1:String, param2:Object)
      {
         super();
         this.id = param1;
         this.name = param2.NameString;
         this.mc_name = param2.MovieClip;
         this.mix_time = param2.MixTime;
         this.maxMod = param2.MaxMod;
         this.duration = param2.Duration;
         this.primaryModifier = this.createModifier(param2.FirstModifier);
         this.secondaryModifier = this.createModifier(param2.SecondModifier);
         this.element = Element.parseElement(param2.Element);
         switch(param2.Category)
         {
            case Category.EQUIPABLE_CATEGORY:
               this.category = new Equipment(this,param2);
               break;
            case Category.CONSUMABLE_CATEGORY:
               this.category = new Consumable(this,param2);
               break;
            case Category.WEAPON_CATEGORY:
               this.category = new Weapon(this,param2);
               break;
            case Category.SHIELD_CATEGORY:
               this.category = new Shield(this,param2);
               break;
            default:
               throw new Error("Unknown type");
         }
      }
      
      public function getMcName() : String
      {
         return this.mc_name;
      }
      
      public function getMaxMod() : int
      {
         return this.maxMod;
      }
      
      public function getDuration() : int
      {
         return this.duration;
      }
      
      private function createModifier(param1:Object) : IModifier
      {
         var _loc2_:IModifier = null;
         var _loc3_:int = StatType.parse(param1.Category);
         if(_loc3_ == StatType.MAX_HP)
         {
            _loc2_ = new MaxHealthModifier(param1);
         }
         else if(_loc3_ == StatType.HEALTH)
         {
            _loc2_ = new HealthModifier(param1);
         }
         else if(StatType.getStatTypes().indexOf(_loc3_) >= 0)
         {
            _loc2_ = new Modifier(param1);
         }
         else
         {
            _loc2_ = new NullModifier();
         }
         return _loc2_;
      }
      
      public function getID() : String
      {
         return this.id;
      }
      
      public function getNameToShow() : String
      {
         var _loc3_:String = null;
         var _loc1_:Array = this.name.split(";");
         var _loc2_:String = "";
         for each(_loc3_ in _loc1_)
         {
            if(_loc2_ != "")
            {
               _loc2_ += " ";
            }
            _loc2_ += main.locale.get(_loc3_);
         }
         return _loc2_;
      }
      
      public function getPrimaryModifier() : IModifier
      {
         return this.primaryModifier;
      }
      
      public function getSecondaryModifier() : IModifier
      {
         return this.secondaryModifier;
      }
      
      public function canBeContained(param1:ItemContainer) : Boolean
      {
         return this.category.canBeContained(param1);
      }
      
      public function clear() : void
      {
         this.getCategory().clear();
         this.element.clear();
         this.primaryModifier.clear();
         this.secondaryModifier.clear();
      }
      
      public function getCategory() : Category
      {
         return this.category;
      }
      
      public function getMixTime() : Number
      {
         return this.mix_time;
      }
      
      public function getElement() : Element
      {
         return this.element;
      }
      
      public function toObject() : Object
      {
         return {"id":this.id};
      }
   }
}

