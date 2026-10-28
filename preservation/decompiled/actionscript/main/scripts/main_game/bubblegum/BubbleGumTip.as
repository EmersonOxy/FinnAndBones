package main_game.bubblegum
{
   import main_game.item_containers.ISlot;
   import main_game.item_containers.NullSlot;
   import main_game.items.Item;
   
   public class BubbleGumTip implements BubblegumInteraction
   {
      
      private var text:String;
      
      public var principalSlot:ISlot;
      
      public var secondarySlot:ISlot;
      
      public function BubbleGumTip(param1:String, param2:Item = null, param3:Item = null)
      {
         super();
         this.principalSlot = new NullSlot();
         this.secondarySlot = new NullSlot();
         this.principalSlot.add(param2);
         this.secondarySlot.add(param3);
         this.text = param1;
      }
      
      public function get tipText() : String
      {
         return this.text;
      }
      
      public function make(param1:InteractiveBubblegum) : void
      {
         param1.sayTip(this);
      }
      
      public function getTime() : int
      {
         var _loc1_:Number = Number(main.config.get("Bubblegum").delayAdvice);
         _loc1_ += Number(this.text.length) / 6 / 2;
         return 1000 * _loc1_;
      }
      
      public function clear() : void
      {
         this.principalSlot.clear();
         this.secondarySlot.clear();
      }
   }
}

