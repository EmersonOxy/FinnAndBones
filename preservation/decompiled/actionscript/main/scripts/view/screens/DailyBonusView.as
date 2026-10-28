package view.screens
{
   import bonus.IDailyBonus;
   import bonus.filter.BonusIcon;
   import flash.utils.Dictionary;
   
   public class DailyBonusView extends AnimatedScreen
   {
      
      private var message:String;
      
      public function DailyBonusView(param1:IDailyBonus, param2:String)
      {
         super(main.swfLoader.getClass("assets.Bonus"),new Dictionary());
         container = "bonus";
         this.message = param2;
         this.initialize(param1);
         bg.gotoAndStop(0);
      }
      
      private function initialize(param1:IDailyBonus) : void
      {
         bg[container].title.title.text = this.message;
         var _loc2_:BonusIcon = param1.getIcon();
         var _loc3_:Vector.<BonusIcon> = param1.getFilter().getIcons();
         switch(_loc3_.length)
         {
            case 3:
               _loc3_[0].addToHolder(bg[container].holder_1a,param1.getAction());
               _loc3_[1].addToHolder(bg[container].holder_1b,param1.getAction());
               _loc3_[2].addToHolder(bg[container].holder_1c,param1.getAction());
               _loc2_.addToHolder(bg[container].holder_1d);
               break;
            case 1:
               _loc3_[0].addToHolder(bg[container].holder_2a,param1.getAction());
               _loc2_.addToHolder(bg[container].holder_2b);
               break;
            case 0:
               _loc2_.addToHolder(bg[container].holder_3b);
         }
      }
   }
}

