package view.figthers.animations
{
   import main_game.dungeon.Damage;
   import main_game.element.Element;
   import view.figthers.FighterView;
   
   public class HurtAnimation extends FighterAnimation
   {
      
      private static const DIE:String = "die";
      
      private static const HURT:String = "hurt";
      
      private static const EVADE:String = "evade";
      
      private var damage:Damage;
      
      private var element:Element;
      
      public function HurtAnimation(param1:Damage, param2:Element)
      {
         var _loc3_:String = null;
         this.damage = param1;
         if(param1.doesHeDie())
         {
            _loc3_ = DIE;
         }
         else if(param1.doesHeHit())
         {
            _loc3_ = HURT;
         }
         else
         {
            _loc3_ = EVADE;
         }
         this.element = param2;
         super(_loc3_);
      }
      
      override public function make(param1:FighterView) : void
      {
         if(name == EVADE)
         {
            param1.fighterSoundManager.playBlock();
         }
         else if(name == HURT)
         {
            param1.fighterSoundManager.playHurt();
         }
         else if(name == DIE)
         {
            param1.fighterSoundManager.playDie();
         }
         super.make(param1);
         setEffect(param1.getMC(),this.element);
      }
      
      override public function forceKill() : Boolean
      {
         return true;
      }
      
      override public function mustGoToIdle() : Boolean
      {
         return this.name != "die";
      }
   }
}

