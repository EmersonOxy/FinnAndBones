package cb.media
{
   import cb.data.TextLoader;
   import cb.signals.Signal;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import jh.PackedResources;
   
   public class SoundLoader
   {
      
      private var s:cbSound;
      
      private var bulk:int;
      
      private var total:int;
      
      public var data:Dictionary;
      
      private var textLoader:TextLoader;
      
      private var totalBytesLoaded:int;
      
      private var textToLoad:String;
      
      private var resource:PackedResources;
      
      private var mediaUrl:String;
      
      public var loaded:Signal;
      
      public var progress:Signal;
      
      private var loadedSoFar:int;
      
      public function SoundLoader(param1:String, param2:String = null)
      {
         super();
         this.bulk = 0;
         this.data = new Dictionary();
         this.loaded = new Signal();
         this.progress = new Signal();
         this.textToLoad = param1;
         if(param2 == null)
         {
            this.mediaUrl = "";
         }
         else
         {
            this.mediaUrl = param2;
         }
      }
      
      public function load(param1:PackedResources = null) : void
      {
         this.resource = param1;
         this.textLoader = new TextLoader(this.mediaUrl + this.textToLoad);
         this.textLoader.loaded.add(this.textLoaded);
         this.textLoader.load(param1);
      }
      
      private function textLoaded(param1:TextLoader) : void
      {
         var _loc2_:String = null;
         this.textLoader.loaded.clear();
         for each(_loc2_ in param1.data)
         {
            if(_loc2_ != "")
            {
               ++this.total;
            }
         }
         for each(_loc2_ in param1.data)
         {
            if(_loc2_ != "")
            {
               this.loadSound(this.mediaUrl + _loc2_);
            }
         }
      }
      
      private function loadSound(param1:String, param2:Array = null) : void
      {
         var _loc6_:Class = null;
         var _loc3_:String = param1.slice(param1.lastIndexOf("/") + 1,param1.indexOf(".",param1.lastIndexOf("/")));
         var _loc4_:Array = param1.split(",");
         if(this.resource)
         {
            _loc6_ = this.resource.get(_loc4_[0]) as Class;
            this.data[_loc3_] = new cbSound(_loc3_);
            this.data[_loc3_].setSound(new _loc6_());
         }
         else
         {
            this.data[_loc3_] = new cbSound(_loc3_,new URLRequest(_loc4_[0]));
            this.data[_loc3_].progress.add(this.progress.emit);
         }
         var _loc5_:Function = this.completeHandler;
         if(param2)
         {
            _loc4_ = param2;
            _loc5_ = this.completeOneHandler;
         }
         this.data[_loc3_].volume = _loc4_[1] ? _loc4_[1] : 1;
         this.data[_loc3_].originalVolume = _loc4_[1] ? _loc4_[1] : 1;
         this.data[_loc3_].startMilliseconds = _loc4_[2] ? _loc4_[2] : 0;
         this.data[_loc3_].endMilliseconds = _loc4_[3] ? _loc4_[3] : 0;
         this.data[_loc3_].addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.data[_loc3_].addEventListener(Event.COMPLETE,_loc5_);
         if(this.resource)
         {
            _loc5_();
         }
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
         throw new Error("error loading file: " + param1.text);
      }
      
      private function completeOneHandler(param1:Event = null) : void
      {
         param1.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.completeOneHandler);
         this.loaded.emit(this);
      }
      
      private function completeHandler(param1:Event = null) : void
      {
         param1.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.completeHandler);
         ++this.bulk;
         if(this.bulk == this.total)
         {
            this.loaded.emit(this);
         }
      }
      
      public function loadOne(param1:String, param2:Number, param3:Number, param4:Number) : void
      {
         this.loadSound(param1,[0,param2,param3,param4]);
      }
   }
}

