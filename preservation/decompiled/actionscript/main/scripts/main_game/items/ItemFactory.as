package main_game.items
{
   import flash.utils.Dictionary;
   import persistence.SaveError;
   import view.items.ConsumableView;
   import view.items.EquipmentView;
   import view.items.ItemView;
   import view.items.ShieldView;
   import view.items.WeaponView;
   import view.items.modifiers.IAnimationModifier;
   import view.items.modifiers.NullShieldModifier;
   import view.items.modifiers.NullSwordModifier;
   import view.items.modifiers.ShieldModifier;
   import view.items.modifiers.SwordModifier;
   
   public class ItemFactory
   {
      
      private static var instance:ItemFactory;
      
      private static var config:Dictionary;
      
      public function ItemFactory(param1:SingletonLock)
      {
         super();
         if(!param1)
         {
            throw new Error("Static Class");
         }
      }
      
      public static function getInstance() : ItemFactory
      {
         if(instance == null)
         {
            instance = new ItemFactory(new SingletonLock());
         }
         return instance;
      }
      
      public static function setConfig(param1:Dictionary) : void
      {
         config = param1;
      }
      
      public function getItem(param1:String) : Item
      {
         return new Item(param1,config[param1]);
      }
      
      public function getCustomItem(param1:String, param2:Object) : Item
      {
         return new MixItem(param1,param2);
      }
      
      public function getConfigOfItem(param1:String) : Object
      {
         return config[param1];
      }
      
      public function itemFromObject(param1:Object) : Item
      {
         if(param1.hasOwnProperty("id"))
         {
            return this.getItem(param1.id);
         }
         if(param1.hasOwnProperty("mix"))
         {
            return this.getCustomItem(param1.mix.id,param1.mix);
         }
         throw new SaveError("ItemCorrupted");
      }
      
      public function getView(param1:Item) : ItemView
      {
         var _loc2_:ItemView = null;
         switch(param1.getCategory().type)
         {
            case Category.EQUIPABLE_CATEGORY:
               _loc2_ = new EquipmentView(param1);
               break;
            case Category.CONSUMABLE_CATEGORY:
               _loc2_ = new ConsumableView(param1);
               break;
            case Category.WEAPON_CATEGORY:
               _loc2_ = new WeaponView(param1);
               break;
            case Category.SHIELD_CATEGORY:
               _loc2_ = new ShieldView(param1);
               break;
            default:
               throw new Error("Unknown type");
         }
         return _loc2_;
      }
      
      public function getShieldModifier(param1:Item) : IAnimationModifier
      {
         if(param1 == null)
         {
            return new NullShieldModifier();
         }
         return new ShieldModifier(param1.getMcName(),param1.getSecondaryModifier().toObject().Category);
      }
      
      public function getSwordModifier(param1:Item) : IAnimationModifier
      {
         if(param1 == null)
         {
            return new NullSwordModifier();
         }
         return new SwordModifier(param1.getMcName(),param1.getSecondaryModifier().toObject().Category);
      }
   }
}

class SingletonLock
{
   
   public function SingletonLock()
   {
      super();
   }
}
