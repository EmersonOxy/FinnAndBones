package cb.data
{
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import jh.PackedResources;
   
   public class Locale extends TextLoader
   {
      
      private var locale:Dictionary;
      
      public function Locale(param1:String)
      {
         super(param1);
      }
      
      override public function load(param1:PackedResources = null) : void
      {
         var _loc3_:Class = null;
         if(param1)
         {
            _loc3_ = param1.get(uri);
            removeListeners();
            loader = null;
            this.createLocale(new _loc3_());
            loaded.emit(this);
            return;
         }
         var _loc2_:URLRequest = new URLRequest(uri);
         loader.load(_loc2_);
      }
      
      private function createLocale(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         this.locale = new Dictionary();
         data = String(param1).split("\n");
         for each(_loc3_ in data)
         {
            _loc4_ = _loc3_.split(":");
            _loc2_ = _loc4_.shift();
            this.locale[_loc2_] = _loc4_.join(":");
            this.locale[_loc2_] = this.locale[_loc2_].replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm,"$2");
         }
      }
      
      override protected function loaderCompleteHandler(param1:Event) : void
      {
         this.createLocale(loader.data);
         loaded.emit(this);
      }
      
      public function get(param1:String, param2:Array = null) : String
      {
         var s:String;
         var re:RegExp;
         var ix:int = 0;
         var key:String = param1;
         var params:Array = param2;
         if(this.locale[key] == undefined)
         {
            return "missing key [" + key + "]";
         }
         if(params == null)
         {
            return this.locale[key];
         }
         s = this.locale[key];
         re = /\$+\d+/g;
         s = s.replace(re,function():String
         {
            if(arguments[0].substr(0,2) == "$$")
            {
               return arguments[0].substr(1);
            }
            return params[int(arguments[0].substr(1)) - 1];
         });
         return s;
      }
   }
}

