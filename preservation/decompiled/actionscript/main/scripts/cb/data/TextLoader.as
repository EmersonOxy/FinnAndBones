package cb.data
{
   import cb.signals.Signal;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import jh.PackedResources;
   
   public class TextLoader
   {
      
      protected var loader:URLLoader;
      
      protected var uri:String;
      
      public var data:Object;
      
      public var loaded:Signal;
      
      public var ioFailed:Signal;
      
      public function TextLoader(param1:String)
      {
         super();
         this.loaded = new Signal();
         this.ioFailed = new Signal();
         this.uri = param1;
         this.loader = new URLLoader();
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
      }
      
      public function load(param1:PackedResources = null) : void
      {
         var _loc3_:Class = null;
         if(param1)
         {
            _loc3_ = param1.get(this.uri);
            this.data = String(new _loc3_()).split("\n");
            this.removeListeners();
            this.loader = null;
            this.loaded.emit(this);
            return;
         }
         var _loc2_:URLRequest = new URLRequest(this.uri);
         this.loader.load(_loc2_);
      }
      
      protected function removeListeners() : void
      {
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
      }
      
      protected function loaderCompleteHandler(param1:Event) : void
      {
         this.removeListeners();
         this.data = String(this.loader.data).split("\n");
         var _loc2_:int = 0;
         while(_loc2_ < this.data.length)
         {
            this.data[_loc2_] = this.data[_loc2_].replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm,"$2");
            _loc2_++;
         }
         this.loaded.emit(this);
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.ioFailed.emit(this);
      }
      
      public function get url() : String
      {
         return this.uri;
      }
   }
}

