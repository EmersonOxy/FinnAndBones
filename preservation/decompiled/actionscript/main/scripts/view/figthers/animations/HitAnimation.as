package view.figthers.animations
{
   import cb.actions.Functor;
   import cb.conditions.AnimationLabelAt;
   import cb.conditions.EndAnimation;
   import cb.display.SmartMC;
   import cb.utils.Rule;
   import conditions.Or;
   import flash.display.MovieClip;
   import main_game.character.Enemy;
   import main_game.character.Finn;
   import main_game.dungeon.Damage;
   import main_game.element.Element;
   import main_game.items.Item;
   import view.figthers.FighterView;
   
   public class HitAnimation extends FighterAnimation
   {
      
      private var receiver:FighterView;
      
      private var damage:Damage;
      
      private var die:Boolean;
      
      private var rule:Rule;
      
      private var element:Element;
      
      private var atContact:Function;
      
      public function HitAnimation(param1:FighterView, param2:Damage, param3:Function, param4:Function = null)
      {
         var _loc5_:String = "attack";
         if(param2.isCritical())
         {
            _loc5_ = "critical";
         }
         super(_loc5_);
         this.receiver = param1;
         this.damage = param2;
         this.atContact = param4;
         this.rule = new Rule("made_hit","took_hit");
         this.rule.completed.add(param3);
      }
      
      override public function make(param1:FighterView) : void
      {
         var weapon:Item = null;
         var fighter:FighterView = param1;
         if(this.name == "critical")
         {
            fighter.fighterSoundManager.playCritical();
            if((fighter.getFighter() as Finn).gear.shield.isEmpty())
            {
               name += "_sword";
            }
         }
         else
         {
            fighter.fighterSoundManager.playAttack();
         }
         fighter.playAnimation(this);
         this.current_mc = fighter.getMC();
         if(fighter.getFighter().isFinn())
         {
            weapon = (fighter.getFighter() as Finn).gear.weapon.getContent();
            if(weapon)
            {
               this.element = weapon.getElement();
            }
         }
         else
         {
            this.element = (fighter.getFighter() as Enemy).getElement();
         }
         this.current_smc = new SmartMC(current_mc);
         current_smc.trigger(new Or(new AnimationLabelAt("end_animation"),new EndAnimation()),new Functor(this.finishMe));
         current_smc.trigger(new AnimationLabelAt("hit"),new Functor(function(param1:MovieClip):void
         {
            setEffect(current_mc,element);
            hitReceiver(param1);
         }));
      }
      
      private function hitReceiver(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         var other:IFighterAnimation = new HurtAnimation(this.damage,this.element);
         other.getAtFinish().add(function(param1:IFighterAnimation):void
         {
            rule.check("took_hit");
         });
         this.receiver.animate(other);
         this.receiver.getFighter().takeDamage(this.damage);
         this.atContact();
      }
      
      private function finishMe(param1:MovieClip) : void
      {
         this.rule.check("made_hit");
         finish(null);
      }
      
      private function finishOther(param1:IFighterAnimation) : void
      {
         this.rule.check("took_hit");
      }
      
      override public function forceKill() : Boolean
      {
         return true;
      }
   }
}

