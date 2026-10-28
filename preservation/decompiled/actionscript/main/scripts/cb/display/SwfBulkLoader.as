package cb.display
{
   import cb.data.TextLoader;
   import cb.signals.Signal;
   import cb.utils.Rule;
   import flash.utils.Dictionary;
   
   public class SwfBulkLoader
   {
      
      private var textLoader:TextLoader;
      
      public var loaded:Signal;
      
      public var progress:Signal;
      
      private var rule:Rule;
      
      private var swfs:Dictionary;
      
      public var load:Function;
      
      public function SwfBulkLoader(param1:*)
      {
         super();
         if(param1 is String)
         {
            this.load = this.loadFile;
            this.textLoader = new TextLoader(param1);
         }
         else
         {
            if(!(param1 is Array))
            {
               throw new Error(param1,"type unsupported");
            }
            this.textLoader = new TextLoader("");
            this.textLoader.data = param1;
            this.load = this.loadArray;
         }
         this.progress = new Signal();
         this.loaded = new Signal();
      }
      
      private function loadArray() : void
      {
         this.fileLoaded(null);
      }
      
      private function loadFile() : void
      {
         this.textLoader.loaded.add(this.fileLoaded);
         this.textLoader.load();
      }
      
      public function getClass(param1:String) : Class
      {
         var _loc2_:SwfLoader = null;
         var _loc3_:int = 0;
         var _loc4_:* = this.swfs;
         for each(_loc2_ in _loc4_)
         {
            return _loc2_.getClass(param1);
         }
         return null;
      }
      
      public function getObject(param1:String) : Object
      {
         var _loc2_:SwfLoader = null;
         var _loc3_:int = 0;
         var _loc4_:* = this.swfs;
         for each(_loc2_ in _loc4_)
         {
            return _loc2_.getObject(param1);
         }
         return null;
      }
      
      private function bulkCompleted() : void
      {
         this.loaded.emit(this);
      }
      
      private function fileLoaded(param1:TextLoader) : void
      {
         var _loc2_:String = null;
         this.textLoader.loaded.clear();
         this.rule = new Rule();
         this.swfs = new Dictionary();
         this.rule.completed.add(this.bulkCompleted);
         for each(_loc2_ in this.textLoader.data)
         {
            if(_loc2_ != "")
            {
               this.rule.set(_loc2_);
               this.swfs[_loc2_] = new SwfLoader(_loc2_);
               this.swfs[_loc2_].loaded.add(this.swfLoaded);
               this.swfs[_loc2_].progress.add(this.progress.emit);
               this.swfs[_loc2_].load();
            }
         }
      }
      
      private function swfLoaded(param1:SwfLoader) : void
      {
         param1.loaded.clear();
         param1.progress.clear();
         this.rule.check(param1.getUrl());
      }
   }
}

