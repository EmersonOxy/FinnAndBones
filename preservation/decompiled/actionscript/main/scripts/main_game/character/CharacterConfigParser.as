package main_game.character
{
   import main_game.element.Element;
   
   public class CharacterConfigParser implements CharacterConfigData
   {
      
      private var theBaseHP:Number;
      
      private var theBaseAttack:Number;
      
      private var theBaseDefense:Number;
      
      private var theBaseLuck:Number;
      
      private var theBaseXP:Number;
      
      private var theElement:Element;
      
      private var theNameString:String;
      
      public function CharacterConfigParser(param1:Object)
      {
         super();
         this.theBaseHP = param1["BaseHP"];
         this.theBaseAttack = param1["BaseAttack"];
         this.theBaseDefense = param1["BaseDefense"];
         this.theBaseLuck = param1["BaseLuck"];
         this.theBaseXP = param1["BaseXP"];
         this.theElement = Element.parseElement(param1["Element"]);
         this.theNameString = param1["NameString"];
      }
      
      public function get baseHP() : Number
      {
         return this.theBaseHP;
      }
      
      public function get baseAttack() : Number
      {
         return this.theBaseAttack;
      }
      
      public function get baseDefense() : Number
      {
         return this.theBaseDefense;
      }
      
      public function get baseLuck() : Number
      {
         return this.theBaseLuck;
      }
      
      public function get baseXP() : Number
      {
         return this.theBaseXP;
      }
      
      public function get element() : Element
      {
         return this.theElement;
      }
      
      public function get nameString() : String
      {
         return this.theNameString;
      }
   }
}

