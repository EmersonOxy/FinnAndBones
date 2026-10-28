package main_game.bubblegum
{
   import util.Util;
   
   public class BubblegumFeltTip implements BubblegumInteraction
   {
      
      private var tip:BubbleGumTip;
      
      private var feeling:BubblegumFeeling;
      
      public function BubblegumFeltTip(param1:BubbleGumTip, param2:BubblegumFeeling)
      {
         super();
         this.tip = param1;
         this.feeling = param2;
      }
      
      public function make(param1:InteractiveBubblegum) : void
      {
         param1.expressFeeling(this.feeling,Util.l(this.tip.make,param1));
      }
   }
}

