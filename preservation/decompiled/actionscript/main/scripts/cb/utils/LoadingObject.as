package cb.utils
{
   import cb.data.Locale;
   import cb.display.SwfBulkLoader;
   import cb.signals.Signal;
   
   public class LoadingObject
   {
      
      public var loaded:Signal;
      
      private var rule:Rule;
      
      private var toLoad:Array;
      
      private var locale:Locale;
      
      private var swfBulkLoader:SwfBulkLoader;
      
      public function LoadingObject(param1:Object)
      {
         var _loc2_:String = null;
         super();
         this.rule = new Rule();
         this.toLoad = [];
         this.loaded = new Signal();
         this.rule.completed.add(this.ruleCompleted);
         for(_loc2_ in param1)
         {
            this.rule.set(_loc2_);
         }
         if(param1.swfs)
         {
            this.swfBulkLoader = new SwfBulkLoader(param1.swfs);
            this.swfBulkLoader.loaded.add(this.swfLoaded);
            this.toLoad.push(this.swfBulkLoader);
         }
         else
         {
            this.rule.check("swfs");
         }
         if(param1.locale)
         {
            this.locale = new Locale(param1.locale);
            this.locale.loaded.add(this.localeLoaded);
            this.locale.load();
            this.toLoad.push(this.locale);
         }
         else
         {
            this.rule.check("locale");
         }
      }
      
      private function ruleCompleted() : void
      {
         this.loaded.emit(this);
      }
      
      private function localeLoaded(param1:Locale) : void
      {
         this.rule.check("locale");
      }
      
      private function swfLoaded(param1:SwfBulkLoader) : void
      {
         param1.loaded.clear();
         this.rule.check("swfs");
      }
      
      public function getLocale() : Locale
      {
         return this.locale;
      }
      
      public function getSwfLoader() : SwfBulkLoader
      {
         return this.swfBulkLoader;
      }
      
      public function load() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.toLoad)
         {
            _loc1_.load();
         }
      }
   }
}

