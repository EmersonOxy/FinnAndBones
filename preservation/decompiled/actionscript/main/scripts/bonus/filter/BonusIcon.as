package bonus.filter
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class BonusIcon
   {
      
      public static const Kill:String = "Kill";
      
      private var type:String;
      
      private var title:String;
      
      private var label:String;
      
      public function BonusIcon(param1:ConstructorLock, param2:String, param3:String = null, param4:String = "1")
      {
         super();
         this.type = param2;
         this.title = param3;
         this.label = param4;
      }
      
      public static function getFire() : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"Fire");
      }
      
      public static function getIce() : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"Ice");
      }
      
      public static function getNormal() : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"Normal");
      }
      
      public static function getXpIcon() : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"XpIcon",main.locale.get("dailyXp"));
      }
      
      public static function getExtraDungeon(param1:String) : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"Dungeon" + param1);
      }
      
      public static function getLevelIcon(param1:Boolean) : BonusIcon
      {
         return new BonusIcon(new ConstructorLock(),"LevelIcon",main.locale.get("dailyLvl"),param1 ? "up" : "down");
      }
      
      public function addToHolder(param1:DisplayObjectContainer, param2:String = "") : void
      {
         var _loc3_:Class = main.swfLoader.getClass("assets." + param2 + this.type);
         var _loc4_:MovieClip = new _loc3_();
         if(this.title != null)
         {
            _loc4_.title.title.text = this.title;
         }
         _loc4_.gotoAndStop(this.label);
         param1.addChild(_loc4_);
      }
   }
}

class ConstructorLock
{
   
   public function ConstructorLock()
   {
      super();
   }
}
