package view.figthers
{
   import drag_and_drop.DragListener;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import main_game.character.Finn;
   import main_game.items.Item;
   import main_game.items.ItemFactory;
   import sound.FinnSoundManager;
   import view.effect.PotionEffect;
   import view.figthers.animations.IFighterAnimation;
   import view.items.modifiers.IAnimationModifier;
   
   public class FinnView extends FighterView
   {
      
      private var mc:MovieClip;
      
      private var dragger:DragListener;
      
      public function FinnView(param1:Finn)
      {
         super(param1);
         this.createMc();
         this.dragger = new DragListener(this.mc,param1.liver);
         this.finn.onPotionConsumition.add(this.consumePotion);
      }
      
      private function get finn() : Finn
      {
         return getFighter() as Finn;
      }
      
      override protected function setSoundManager() : void
      {
         this.soundManager = new FinnSoundManager(this.finn);
      }
      
      protected function consumePotion(param1:Item) : void
      {
         new PotionEffect(param1,this.mc);
      }
      
      private function createMc() : void
      {
         var _loc1_:String = "Sword";
         if(this.finn.gear.weapon.isEmpty())
         {
            _loc1_ = "Hand";
         }
         this.mc = main.swfLoader.getObject("assets.Finn" + _loc1_) as MovieClip;
         this.setSword(this.mc.sword);
         this.setShield(this.mc.shield);
      }
      
      private function setSword(param1:MovieClip) : void
      {
         var _loc2_:IAnimationModifier = ItemFactory.getInstance().getSwordModifier(this.finn.gear.weapon.getContent());
         _loc2_.modify(param1);
      }
      
      private function setShield(param1:MovieClip) : void
      {
         var _loc2_:IAnimationModifier = ItemFactory.getInstance().getShieldModifier(this.finn.gear.shield.getContent());
         _loc2_.modify(param1);
      }
      
      override public function playAnimation(param1:IFighterAnimation) : void
      {
         this.mc.gotoAndPlay(param1.getName());
      }
      
      override public function getMC() : MovieClip
      {
         return this.mc;
      }
      
      override public function putIn(param1:DisplayObjectContainer) : void
      {
         param1["finn"] = this.mc;
         param1.addChild(this.mc);
      }
      
      override public function set x(param1:Number) : void
      {
         this.mc.x = param1;
      }
      
      override public function get x() : Number
      {
         return this.mc.x;
      }
      
      override public function set y(param1:Number) : void
      {
         this.mc.y = param1;
      }
      
      override public function get y() : Number
      {
         return this.mc.y;
      }
      
      override public function clear() : void
      {
         this.pop();
         this.dragger.clear();
         super.clear();
      }
      
      private function pop() : void
      {
         this.mc.parent.removeChild(this.mc);
      }
   }
}

