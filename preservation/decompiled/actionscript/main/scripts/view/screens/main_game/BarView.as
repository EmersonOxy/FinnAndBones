package view.screens.main_game
{
   import cb.data.Locale;
   import flash.display.MovieClip;
   
   public class BarView
   {
      
      private var mc:MovieClip;
      
      private var currentVal:Number;
      
      private var totalVal:Number;
      
      private var locale:Locale;
      
      private var localeText:String;
      
      public function BarView(param1:MovieClip, param2:Locale = null, param3:String = "", param4:Number = 0, param5:Number = 100)
      {
         super();
         this.mc = param1;
         this.currentVal = param4;
         this.totalVal = param5;
         this.locale = param2;
         this.localeText = param3;
         this.current = this.currentVal;
         this.total = this.totalVal;
      }
      
      public function get current() : Number
      {
         return this.currentVal;
      }
      
      public function get total() : Number
      {
         return this.totalVal;
      }
      
      public function set current(param1:Number) : void
      {
         this.currentVal = Math.round(param1);
         if(this.locale != null && this.localeText != "")
         {
            this.mc.title.title.text = main.locale.get(this.localeText,[this.current.toString(),this.total.toString()]);
         }
         var _loc2_:uint = Math.ceil(this.current * 100 / this.total);
         if(this.current != this.total)
         {
            _loc2_ = Math.min(99,_loc2_);
         }
         this.mc.gotoAndStop(_loc2_);
      }
      
      public function set total(param1:Number) : void
      {
         this.totalVal = Math.ceil(param1);
         if(this.locale != null && this.localeText != "")
         {
            this.mc.title.text = main.locale.get(this.localeText,[this.current.toString(),this.total.toString()]);
         }
         this.mc.gotoAndStop(Math.ceil(this.current * 100 / this.total));
      }
      
      public function clear() : void
      {
         this.mc = null;
         this.locale = null;
      }
   }
}

