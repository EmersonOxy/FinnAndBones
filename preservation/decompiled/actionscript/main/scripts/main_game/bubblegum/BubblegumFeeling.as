package main_game.bubblegum
{
   public class BubblegumFeeling implements BubblegumInteraction
   {
      
      private var theFeeling:String;
      
      public function BubblegumFeeling(param1:String)
      {
         super();
         this.theFeeling = param1;
      }
      
      public static function getJoy() : BubblegumFeeling
      {
         return new BubblegumFeeling("happy");
      }
      
      public static function getSadness() : BubblegumFeeling
      {
         return new BubblegumFeeling("sad");
      }
      
      public function get feeling() : String
      {
         return this.theFeeling;
      }
      
      public function make(param1:InteractiveBubblegum) : void
      {
         param1.expressFeeling(this);
      }
   }
}

