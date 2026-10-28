package cb.media
{
   import cb.utils.Tween;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class cbSoundMixer implements SoundMixable
   {
      
      private var _mute:Boolean;
      
      private var paused:Boolean;
      
      private var sounds:Dictionary;
      
      private var channels:Dictionary;
      
      private var toPause:Array;
      
      private var queueDic:Dictionary;
      
      private var toResume:Dictionary;
      
      private var fades:Dictionary;
      
      public function cbSoundMixer(param1:SoundLoader)
      {
         super();
         this.sounds = param1.data;
         this.channels = new Dictionary();
         this.toPause = new Array();
         this.queueDic = new Dictionary();
         this.fades = new Dictionary();
         this.paused = false;
         this._mute = false;
      }
      
      public function addSoundLoader(param1:SoundLoader) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1.data)
         {
            this.sounds[_loc2_] = param1.data[_loc2_];
         }
      }
      
      public function mute() : void
      {
         var _loc1_:cbSound = null;
         var _loc2_:SoundChannel = null;
         for each(_loc1_ in this.sounds)
         {
            _loc1_.stop();
         }
         for each(_loc2_ in this.channels)
         {
            if(_loc2_)
            {
               _loc2_.stop();
            }
         }
         this._mute = true;
      }
      
      public function pause() : void
      {
         var _loc1_:String = null;
         this.paused = true;
         this.toResume = new Dictionary();
         for(_loc1_ in this.channels)
         {
            if(this.channels[_loc1_] != undefined)
            {
               if(this.sounds[_loc1_].playing())
               {
                  this.toResume[_loc1_] = this.channels[_loc1_];
                  this.pauseSound(_loc1_);
               }
            }
         }
      }
      
      public function pauseSound(param1:String) : void
      {
         if(this.channels[param1] == undefined)
         {
            return;
         }
         this.sounds[param1].pause(this.channels[param1].position);
         this.channels[param1].stop();
      }
      
      public function resumeSound(param1:String) : void
      {
         if(this._mute)
         {
            return;
         }
         this.channels[param1] = this.sounds[param1].resume();
      }
      
      public function isSongPaused(param1:String) : Boolean
      {
         return this.sounds[param1].isPaused();
      }
      
      public function isPaused() : Boolean
      {
         return this.paused;
      }
      
      public function resume() : void
      {
         var _loc1_:String = null;
         this.paused = false;
         for(_loc1_ in this.toResume)
         {
            this.resumeSound(_loc1_);
         }
      }
      
      public function unmute() : void
      {
         this._mute = false;
      }
      
      public function isMuted() : Boolean
      {
         return this._mute;
      }
      
      public function queue(param1:String, param2:cbSound, param3:Boolean = false) : cbSound
      {
         if(this._mute)
         {
            return null;
         }
         param2.onFinish(this.soundFinish);
         this.queueDic[param2] = {
            "snd":param1,
            "loop":param3
         };
         return this.sounds[param1];
      }
      
      private function soundFinish(param1:String) : void
      {
         var _loc2_:cbSound = null;
         if(this._mute)
         {
            delete this.queueDic[_loc2_];
            return;
         }
         _loc2_ = this.sounds[param1];
         this.play(this.queueDic[_loc2_].snd,0,this.queueDic[_loc2_].loop);
         delete this.queueDic[_loc2_];
      }
      
      private function loopSound(param1:String) : void
      {
         this.play(param1,0,true);
      }
      
      public function changeVolume(param1:String, param2:Number) : void
      {
         this.sounds[param1].volume = param2;
         this.channels[param1].soundTransform = new SoundTransform(param2);
      }
      
      public function play(param1:String, param2:Number = 0, param3:Boolean = false, param4:Number = -1) : cbSound
      {
         if(this._mute)
         {
            return null;
         }
         if(param3)
         {
            this.sounds[param1].onFinish(this.loopSound);
         }
         var _loc5_:SoundTransform = null;
         if(param4 > -1)
         {
            _loc5_ = new SoundTransform(param4);
         }
         this.channels[param1] = this.sounds[param1].play(param2,0,_loc5_);
         return this.sounds[param1];
      }
      
      public function stop(param1:String) : void
      {
         if(this.channels[param1] == undefined)
         {
            return;
         }
         this.channels[param1].stop();
         delete this.channels[param1];
         if(this.toResume)
         {
            delete this.toResume[param1];
         }
         this.sounds[param1].stop();
      }
      
      public function isPlaying(param1:String) : Boolean
      {
         if(this.sounds[param1] == undefined)
         {
            return false;
         }
         return this.sounds[param1].playing();
      }
      
      public function fadeIn(param1:String, param2:uint) : cbSound
      {
         var channel:SoundChannel = null;
         var obj:Object = null;
         var sound:String = param1;
         var time:uint = param2;
         channel = this.channels[sound];
         if(!channel)
         {
            return null;
         }
         if(this.fades[channel])
         {
            Tween.killTweensOf(this.fades[channel]);
         }
         obj = {"volume":0};
         this.fades[channel] = obj;
         channel.soundTransform = new SoundTransform(0);
         Tween.to(obj,time,{"volume":this.sounds[sound].originalVolume},function():void
         {
            changeVolume(sound,obj.volume);
            sounds[sound].setCurrentTransform(new SoundTransform(obj.volume));
            delete fades[channel];
         },function():void
         {
            changeVolume(sound,obj.volume);
         });
         return this.sounds[sound];
      }
      
      public function fadeOut(param1:String, param2:uint) : cbSound
      {
         var channel:SoundChannel = null;
         var obj:Object = null;
         var sound:String = param1;
         var time:uint = param2;
         channel = this.channels[sound];
         if(!channel)
         {
            return null;
         }
         if(this.fades[channel])
         {
            Tween.killTweensOf(this.fades[channel]);
         }
         obj = {"volume":this.sounds[sound].volume};
         this.fades[channel] = obj;
         Tween.to(obj,time,{"volume":0},function():void
         {
            changeVolume(sound,obj.volume);
            sounds[sound].setCurrentTransform(new SoundTransform(obj.volume));
            delete fades[channel];
         },function():void
         {
            changeVolume(sound,obj.volume);
         });
         return this.sounds[sound];
      }
   }
}

