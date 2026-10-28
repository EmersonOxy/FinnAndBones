package cb.media
{
   import cb.signals.Signal;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class cbSound implements IEventDispatcher
   {
      
      public var volume:Number = 1;
      
      public var originalVolume:Number = 1;
      
      public var startMilliseconds:Number = 0;
      
      public var endMilliseconds:Number = 0;
      
      private var endTimer:Timer;
      
      private var qSound:cbSound;
      
      private var isPlaying:Boolean = false;
      
      private var paused:Boolean = false;
      
      private var atFinish:Array;
      
      private var name:String;
      
      private var currentSndTr:SoundTransform = null;
      
      private var sound:Sound;
      
      private var positionToResume:Number;
      
      private var saveAtFinish:Boolean = false;
      
      public var progress:Signal;
      
      private var loadedSoFar:int;
      
      public function cbSound(param1:String, param2:URLRequest = null)
      {
         super();
         this.atFinish = new Array();
         this.progress = new Signal();
         this.name = param1;
         if(param2 == null)
         {
            return;
         }
         this.sound = new Sound(param2);
         this.sound.addEventListener(ProgressEvent.PROGRESS,this.progressListener,false,0,true);
      }
      
      private function progressListener(param1:ProgressEvent) : void
      {
         this.progress.emit(param1.bytesLoaded - this.loadedSoFar);
         this.loadedSoFar = param1.bytesLoaded;
         if(param1.bytesLoaded == param1.bytesTotal)
         {
            this.progress.clear();
         }
      }
      
      public function setSound(param1:Sound) : void
      {
         this.sound = param1;
      }
      
      public function playing() : Boolean
      {
         return this.isPlaying;
      }
      
      public function play(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : SoundChannel
      {
         this.isPlaying = true;
         this.paused = false;
         this.endTimer = new Timer(this.sound.length - this.startMilliseconds - this.endMilliseconds,1);
         this.endTimer.addEventListener(TimerEvent.TIMER,this.soundComplete,false,0,true);
         this.endTimer.start();
         var _loc4_:Number = param1 == 0 ? this.startMilliseconds : 0;
         var _loc5_:SoundTransform = this.setCurrentTransform(param3);
         if(_loc4_ == 0 && param1 != 0)
         {
            _loc4_ = param1;
         }
         return this.sound.play(_loc4_,param2,_loc5_);
      }
      
      public function stop() : void
      {
         this.isPlaying = false;
         if(this.endTimer)
         {
            this.endTimer.stop();
            this.endTimer.reset();
         }
         if(this.saveAtFinish)
         {
            this.saveAtFinish = false;
         }
         else
         {
            this.atFinish = new Array();
         }
         this.currentSndTr = null;
      }
      
      public function isPaused() : Boolean
      {
         return this.paused;
      }
      
      public function pause(param1:Number) : void
      {
         this.isPlaying = false;
         this.paused = true;
         if(this.endTimer)
         {
            this.endTimer.stop();
         }
         this.saveAtFinish = true;
         this.positionToResume = param1;
      }
      
      public function setCurrentTransform(param1:SoundTransform) : SoundTransform
      {
         var _loc2_:SoundTransform = null;
         if(param1 == null)
         {
            if(this.currentSndTr)
            {
               _loc2_ = this.currentSndTr;
            }
            else
            {
               _loc2_ = new SoundTransform(this.volume);
               this.currentSndTr = _loc2_;
            }
         }
         else
         {
            _loc2_ = param1;
            this.currentSndTr = _loc2_;
         }
         return _loc2_;
      }
      
      public function resume() : SoundChannel
      {
         var _loc2_:int = 0;
         this.isPlaying = true;
         this.paused = false;
         if(this.endTimer)
         {
            _loc2_ = this.sound.length - this.positionToResume - this.endMilliseconds;
            if(_loc2_ < 0)
            {
               _loc2_ = 1;
            }
            this.endTimer.delay = _loc2_;
            if(!this.endTimer.hasEventListener(TimerEvent.TIMER))
            {
               this.endTimer.addEventListener(TimerEvent.TIMER,this.soundComplete);
            }
            this.endTimer.start();
         }
         var _loc1_:SoundTransform = this.setCurrentTransform(this.currentSndTr);
         return this.sound.play(this.positionToResume,0,_loc1_);
      }
      
      public function onFinish(param1:Function) : void
      {
         this.atFinish.push(param1);
      }
      
      private function soundComplete(param1:TimerEvent) : void
      {
         var _loc3_:Function = null;
         this.isPlaying = false;
         this.endTimer.removeEventListener(TimerEvent.TIMER,this.soundComplete);
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.atFinish)
         {
            _loc2_.push(_loc3_);
         }
         this.atFinish = new Array();
         for each(_loc3_ in _loc2_)
         {
            _loc3_(this.name);
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.sound.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.sound.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.sound.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.sound.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.sound.willTrigger(param1);
      }
   }
}

