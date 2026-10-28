package bonus
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import jh.PackedResources;
   
   public class FileLoader extends EventDispatcher
   {
      
      private var loader:URLLoader;
      
      private var uri:String;
      
      public var data:Object;
      
      public var name:String;
      
      public function FileLoader(param1:String)
      {
         super();
         this.uri = param1;
         this.name = param1;
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
            this.data = new _loc3_();
            this.removeListeners();
            this.loader = null;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
         }
         var _loc2_:URLRequest = new URLRequest(this.uri);
         this.loader.load(_loc2_);
      }
      
      private function removeListeners() : void
      {
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
      }
      
      private function loaderCompleteHandler(param1:Event) : void
      {
         this.data = this.loader.data;
         dispatchEvent(param1);
         this.removeListeners();
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
         throw new Error(param1);
      }
   }
}

