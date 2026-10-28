package main_game.items.modifiers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import main_game.character.stats.Stat;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   
   public class Modifier implements IModifier
   {
      
      protected var characteristic:int;
      
      protected var value:Number;
      
      public function Modifier(param1:Object)
      {
         super();
         this.characteristic = StatType.parse(param1.Category);
         this.value = param1.Value;
      }
      
      public function modifyIcon(param1:MovieClip) : void
      {
         param1.visible = true;
         StatType.setMcIcon(param1,this.characteristic);
      }
      
      public function modifyValue(param1:TextField, param2:int) : void
      {
         param1.text = main.locale.get("popUpValue",[this.value.toString(),param2.toString()]);
      }
      
      public function affect(param1:Stats) : void
      {
         var _loc2_:Stat = this.getStat(param1);
         _loc2_.modifyValue(this.value);
      }
      
      public function disaffect(param1:Stats) : void
      {
         var _loc2_:Stat = this.getStat(param1);
         _loc2_.modifyValue(-this.value);
      }
      
      protected function getStat(param1:Stats) : Stat
      {
         return param1.getStat(this.characteristic);
      }
      
      public function getValue() : Number
      {
         return this.value;
      }
      
      public function getCategory() : int
      {
         return this.characteristic;
      }
      
      public function isInstant() : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
      }
      
      public function toObject() : *
      {
         return {
            "Category":StatType.toString(this.characteristic),
            "Value":this.value
         };
      }
   }
}

