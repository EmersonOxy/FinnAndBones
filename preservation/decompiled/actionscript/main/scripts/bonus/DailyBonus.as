package bonus
{
   import bonus.filter.AllFilter;
   import bonus.filter.FireFilter;
   import bonus.filter.IBonusFilter;
   import bonus.filter.IceFilter;
   import bonus.filter.NoneFilter;
   import bonus.filter.NormalFilter;
   import flash.globalization.DateTimeFormatter;
   import main_game.element.Element;
   
   public class DailyBonus
   {
      
      public static var config:ClassLoader;
      
      private static const specialDungeonName:String = "specialDungeon";
      
      private static const xpBonusName:String = "xpPercent";
      
      private static const xtraLevelName:String = "enemyExtraLevel";
      
      private static const filterName:String = "filter";
      
      private static const elementName:String = "element";
      
      public function DailyBonus()
      {
         super();
      }
      
      public static function getBonusOfDate(param1:Date) : IDailyBonus
      {
         var _loc2_:Object = getBonusConfigOfDate(param1);
         if(_loc2_)
         {
            return DailyBonus.getBonus(_loc2_);
         }
         return null;
      }
      
      private static function getBonusConfigOfDate(param1:Date) : Object
      {
         var _loc5_:Object = null;
         var _loc2_:Object = config.get("SpecialEvents");
         var _loc3_:DateTimeFormatter = new DateTimeFormatter("en-US");
         _loc3_.setDateTimePattern("\'date_\'MM_dd_yyyy");
         var _loc4_:Object = _loc2_[_loc3_.format(param1)];
         if(!_loc4_)
         {
            _loc5_ = config.get("Weekly");
            _loc3_.setDateTimePattern("EEEE");
            _loc4_ = _loc5_[_loc3_.format(param1)];
         }
         return _loc4_;
      }
      
      private static function getBonus(param1:Object) : IDailyBonus
      {
         var _loc2_:IBonusFilter = null;
         if(param1.hasOwnProperty(specialDungeonName))
         {
            return new ExtraDungeon(param1[specialDungeonName],param1[elementName]);
         }
         if(param1.hasOwnProperty(filterName))
         {
            _loc2_ = parseFilter(param1[filterName]);
            if(param1.hasOwnProperty(xpBonusName))
            {
               return new XpBonus(param1[xpBonusName],_loc2_);
            }
            if(param1.hasOwnProperty(xtraLevelName))
            {
               return new ExtraLevelBonus(param1[xtraLevelName],_loc2_);
            }
         }
         return null;
      }
      
      private static function isConfigOfSpecialDungeon(param1:Object, param2:Element) : Boolean
      {
         return Boolean(param1) && param1.hasOwnProperty(specialDungeonName) && Element.parseElement(param1[elementName]) == param2;
      }
      
      public static function getNextSpecialDungeonDate(param1:Element) : Date
      {
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc2_:Date = new Date();
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         while(_loc4_ < 7)
         {
            _loc3_ = DailyBonus.getBonusConfigOfDate(_loc2_);
            if(isConfigOfSpecialDungeon(_loc3_,param1))
            {
               return _loc2_;
            }
            _loc2_ = new Date(_loc2_.time + 1000 * 60 * 60 * 24);
            _loc4_++;
         }
         _loc2_ = null;
         var _loc5_:Object = config.get("SpecialEvents");
         for(_loc6_ in _loc5_)
         {
            if(isConfigOfSpecialDungeon(_loc5_[_loc6_],param1))
            {
               _loc7_ = _loc6_.split("_");
               if(_loc2_ == null || !isAfter(_loc7_[3],_loc7_[1],_loc7_[2],_loc2_.getFullYear(),_loc2_.getMonth() + 1,_loc2_.getDate()))
               {
                  _loc2_ = new Date(_loc7_[3],_loc7_[1] - 1,_loc7_[2]);
               }
            }
         }
         return _loc2_;
      }
      
      private static function parseFilter(param1:String) : IBonusFilter
      {
         switch(param1)
         {
            case "All":
               return new AllFilter();
            case "Ice":
               return new IceFilter();
            case "Fire":
               return new FireFilter();
            case "Normal":
               return new NormalFilter();
            default:
               return new NoneFilter();
         }
      }
      
      public static function getNextSpecialBonusDate(param1:Date) : Date
      {
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc2_:int = param1.getFullYear();
         var _loc3_:int = param1.getMonth() + 1;
         var _loc4_:int = param1.getDate();
         var _loc5_:Object = config.get("SpecialEvents");
         var _loc6_:Date = null;
         for(_loc7_ in _loc5_)
         {
            _loc8_ = _loc7_.split("_");
            if(isAfter(_loc8_[3],_loc8_[1],_loc8_[2],_loc2_,_loc3_,_loc4_))
            {
               if(_loc6_ == null || !isAfter(_loc8_[3],_loc8_[1],_loc8_[2],_loc6_.getFullYear(),_loc6_.getMonth() + 1,_loc6_.getDate()))
               {
                  _loc6_ = new Date(_loc8_[3],_loc8_[1] - 1,_loc8_[2]);
               }
            }
         }
         return _loc6_;
      }
      
      private static function isAfter(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Boolean
      {
         return param1 > param4 || param1 == param4 && param2 > param5 || param1 == param4 && param2 == param5 && param3 > param6;
      }
   }
}

