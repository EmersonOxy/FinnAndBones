package main_game.dungeon
{
   import flash.display.MovieClip;
   import main_game.character.Fighter;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   
   public class Damage
   {
      
      private var hp_damage:uint;
      
      private var hit:Boolean;
      
      private var critical:Boolean;
      
      private var target:Fighter;
      
      private var elementBonus:ElementBonus;
      
      public function Damage(param1:uint, param2:Boolean, param3:Boolean, param4:Fighter, param5:ElementBonus = null)
      {
         super();
         this.hp_damage = param1;
         this.hit = param2;
         this.critical = param3;
         this.target = param4;
         this.elementBonus = param5;
      }
      
      public function apply(param1:Stats) : void
      {
         param1.downHP(this.hp_damage);
      }
      
      public function getHitterFeedback() : Array
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Array = [];
         if(this.isCritical())
         {
            _loc1_ = main.swfLoader.getObject("assets.criticalHit") as MovieClip;
            _loc1_.number_heathl_parts_blocked.title.title.text = main.locale.get("critical_bonus");
            _loc2_.push(_loc1_);
         }
         if(Boolean(this.doesHeHit()) && Boolean(this.elementBonus) && this.elementBonus.value > 1)
         {
            if(this.elementBonus.element.isOfFire)
            {
               _loc1_ = main.swfLoader.getObject("assets.elementBonus_fire") as MovieClip;
            }
            else if(this.elementBonus.element.isOfIce)
            {
               _loc1_ = main.swfLoader.getObject("assets.elementBonus_ice") as MovieClip;
            }
            _loc1_.number_heathl_parts_blocked.title.title.text = main.locale.get("element_bonus",[int(this.elementBonus.value * 100)]);
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getDefenderFeedback() : Array
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Array = [];
         if(!this.doesHeHit())
         {
            _loc1_ = main.swfLoader.getObject("assets.blocked") as MovieClip;
            _loc1_.number_heathl_parts_blocked.title.title.text = main.locale.get("evade_bonus");
            _loc2_.push(_loc1_);
         }
         else if(Boolean(this.elementBonus) && this.elementBonus.value < 1)
         {
            if(this.elementBonus.element.isOfFire)
            {
               _loc1_ = main.swfLoader.getObject("assets.elementBonus_fire") as MovieClip;
            }
            else if(this.elementBonus.element.isOfIce)
            {
               _loc1_ = main.swfLoader.getObject("assets.elementBonus_ice") as MovieClip;
            }
            _loc1_.number_heathl_parts_blocked.title.title.text = main.locale.get("element_bonus",[int((2 - this.elementBonus.value) * 100)]);
         }
         return _loc2_;
      }
      
      public function doesHeDie() : Boolean
      {
         return this.doesHeHit() && this.target.stats.getStat(StatType.HEALTH).getValue() <= this.hp_damage;
      }
      
      public function doesHeHit() : Boolean
      {
         return this.hit;
      }
      
      public function isCritical() : Boolean
      {
         return this.critical;
      }
      
      public function stringValue() : String
      {
         return this.hp_damage.toString();
      }
   }
}

