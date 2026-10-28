package main_game.items
{
   import main_game.character.stats.StatType;
   
   public class MixItem extends Item
   {
      
      public function MixItem(param1:String, param2:Object)
      {
         super(param1,param2);
      }
      
      override public function getNameToShow() : String
      {
         var _loc1_:int = this.secondaryModifier.getCategory();
         if(_loc1_ == StatType.NULL)
         {
            _loc1_ = this.primaryModifier.getCategory();
         }
         return main.locale.get("mix" + StatType.stringOfStat(_loc1_),[super.getNameToShow()]);
      }
      
      override public function toObject() : Object
      {
         var _loc1_:* = {
            "id":this.id,
            "NameString":this.name,
            "Category":this.category.type,
            "MovieClip":this.mc_name,
            "FirstModifier":primaryModifier.toObject(),
            "SecondModifier":secondaryModifier.toObject(),
            "Element":this.element.type,
            "MixTime":this.mix_time,
            "MaxMod":this.maxMod,
            "Duration":this.duration
         };
         return {"mix":_loc1_};
      }
   }
}

