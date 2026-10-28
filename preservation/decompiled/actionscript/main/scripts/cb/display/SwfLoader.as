package cb.display
{
   import cb.signals.Signal;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class SwfLoader
   {
      
      public var loaded:Signal;
      
      public var progress:Signal;
      
      private var loader:Loader;
      
      private var url:String;
      
      private var loadedSoFar:int;
      
      public function SwfLoader(param1:String)
      {
         super();
         this.loaded = new Signal();
         this.progress = new Signal();
         this.loader = new Loader();
         this.url = param1;
      }
      
      public function load() : void
      {
         var _loc1_:LoaderContext = new LoaderContext();
         _loc1_.applicationDomain = ApplicationDomain.currentDomain;
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadSwfComplete);
         this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressListener);
         this.loader.load(new URLRequest(this.url),_loc1_);
      }
      
      private function progressListener(param1:ProgressEvent) : void
      {
         this.progress.emit(param1.bytesLoaded - this.loadedSoFar);
         this.loadedSoFar = param1.bytesLoaded;
      }
      
      private function loadSwfComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.loadSwfComplete);
         this.loaded.emit(this);
      }
      
      public function unload() : void
      {
         this.loader.unload();
         this.loaded.clear();
         this.loaded = null;
         this.progress.clear();
         this.progress = null;
      }
      
      public function getClass(param1:String) : Class
      {
         return ApplicationDomain.currentDomain.getDefinition(param1) as Class;
      }
      
      public function getObject(param1:String) : Object
      {
         return new (this.getClass(param1))();
      }
      
      public function getUrl() : String
      {
         return this.url;
      }
   }
}

