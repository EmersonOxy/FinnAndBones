package main_game.dungeon
{
   import main_game.character.Enemy;
   import main_game.character.Fighter;
   import main_game.character.Finn;
   import main_game.character.stats.StatType;
   import main_game.element.Element;
   import main_game.item_containers.Slot;
   import main_game.items.Item;
   
   public class DamageCalculator
   {
      
      public function DamageCalculator()
      {
         super();
      }
      
      public static function calculateDamage(param1:Fighter, param2:Fighter) : Damage
      {
         var _loc5_:Element = null;
         var _loc21_:String = null;
         var _loc28_:Item = null;
         var _loc29_:String = null;
         var _loc30_:String = null;
         var _loc31_:Slot = null;
         var _loc32_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Number = param1.stats.getLuck();
         var _loc8_:Number = param2.stats.getLuck();
         var _loc9_:Number = param1.stats.getLevel() + 1;
         var _loc10_:Number = param2.stats.getLevel() + 1;
         var _loc11_:* = main.config.get("Damage");
         var _loc12_:Array = _loc11_["VariableAttackPercentage"].split(":");
         _loc12_[0] = Number(_loc12_[0]) / 100;
         _loc12_[1] = Number(_loc12_[1]) / 100;
         var _loc13_:Number = Number(_loc11_["CriticalMultiplier"]);
         var _loc14_:Number = Number(_loc11_["EvadeFactor"]);
         var _loc15_:Number = Number(_loc11_["CriticalFactor"]);
         var _loc16_:Number = _loc11_["MinimumCritical"] / 100;
         var _loc17_:Number = _loc11_["MinimumEvade"] / 100;
         var _loc18_:Number = _loc11_["LuckCap"] / 100;
         var _loc19_:Number = 0;
         if(_loc7_ < _loc8_)
         {
            _loc19_ = Math.max(_loc17_,Math.min(_loc18_,_loc14_ * (1 - _loc7_ / _loc8_)));
         }
         _loc4_ = Math.random() < _loc19_;
         var _loc20_:Number = 1;
         if(param2.isFinn())
         {
            _loc28_ = (param2 as Finn).gear.shield.getContent();
            _loc29_ = "N";
            if(_loc28_ != null)
            {
               _loc29_ = _loc28_.getElement().type;
            }
            _loc5_ = (param1 as Enemy).getElement();
            _loc21_ = _loc5_.type;
            _loc20_ = Number(_loc11_[_loc29_ + "vs" + _loc21_ + "_defence"]);
            if(_loc29_ + _loc21_ == Element.FIRE + Element.ICE || _loc29_ + _loc21_ == Element.ICE + Element.FIRE)
            {
               _loc6_ = true;
            }
         }
         else if(param1.isFinn())
         {
            _loc21_ = (param2 as Enemy).getElement().type;
            _loc30_ = "N";
            _loc31_ = (param1 as Finn).gear.weapon;
            if(!_loc31_.isEmpty())
            {
               _loc5_ = _loc31_.getContent().getElement();
               _loc30_ = _loc5_.type;
               _loc32_ = 0;
               if(_loc7_ > _loc8_)
               {
                  _loc32_ = Math.max(_loc16_,Math.min(_loc18_,_loc15_ * (1 - _loc8_ / _loc7_)));
               }
               _loc3_ = Math.random() < _loc32_;
            }
            _loc20_ = Number(_loc11_[_loc30_ + "vs" + _loc21_ + "_attack"]);
            if(_loc30_ + _loc21_ == Element.FIRE + Element.ICE || _loc30_ + _loc21_ == Element.ICE + Element.FIRE)
            {
               _loc6_ = true;
            }
         }
         var _loc22_:int = param1.stats.getStat(StatType.ATTACK).getValue();
         var _loc23_:int = param2.stats.getStat(StatType.DEFENSE).getValue();
         var _loc24_:Number = (_loc22_ - _loc23_) * _loc20_;
         _loc24_ -= _loc24_ * _loc12_[0];
         var _loc25_:Number = _loc12_[0] + _loc12_[1];
         _loc25_ = _loc25_ * Math.random();
         _loc24_ += _loc24_ * _loc25_;
         var _loc26_:int = Math.max(1,Math.round(_loc24_));
         if(_loc4_)
         {
            _loc26_ = 0;
         }
         else if(_loc3_)
         {
            _loc26_ *= _loc13_;
         }
         var _loc27_:ElementBonus = null;
         if(_loc6_)
         {
            _loc27_ = new ElementBonus(_loc5_,_loc20_);
         }
         return new Damage(_loc26_,!_loc4_,_loc3_,param2,_loc27_);
      }
   }
}

