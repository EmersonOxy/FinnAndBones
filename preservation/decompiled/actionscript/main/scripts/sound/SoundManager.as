package sound
{
   import cb.data.ButtonGroup;
   import cb.media.SoundLoader;
   import cb.media.cbSound;
   import cb.media.cbSoundMixer;
   import cb.utils.cbArray;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class SoundManager
   {
      
      private var soundMixer:cbSoundMixer;
      
      private var musicList:cbArray;
      
      public function SoundManager()
      {
         super();
         this.musicList = new cbArray();
      }
      
      public function addSound(param1:SoundLoader) : void
      {
         this.soundMixer.addSoundLoader(param1);
      }
      
      public function start(param1:SoundLoader) : void
      {
         this.soundMixer = new cbSoundMixer(param1);
         this.initializeSound();
      }
      
      public function ready() : Boolean
      {
         return this.soundMixer != null;
      }
      
      private function initializeSound() : void
      {
         ButtonGroup.get("gui").setSoundMixer(this.soundMixer).setClickSound(GameSounds.BUTTON_CLICK).setOverSound(GameSounds.MOUSE_OVER);
         ButtonGroup.get("gui_mix").setSoundMixer(this.soundMixer).setClickSound(GameSounds.MIX_CLICK).setOverSound(GameSounds.MOUSE_OVER);
         ButtonGroup.get("sound_gui").setSoundMixer(this.soundMixer).setClickSound(GameSounds.BUTTON_CLICK).setOverSound(GameSounds.MOUSE_OVER).addClick(this.onSoundClick);
         if(main.saveSystem.isSoundMuted())
         {
            this.soundMixer.mute();
         }
      }
      
      public function onSoundClick(param1:MouseEvent) : void
      {
         var _loc2_:MusicRequest = null;
         if(this.soundMixer.isMuted())
         {
            this.soundMixer.unmute();
            _loc2_ = this.actualMusic;
            if(_loc2_ != null)
            {
               this.playRequest(_loc2_);
            }
         }
         else
         {
            this.soundMixer.mute();
         }
         main.saveSystem.saveMuteState(this.soundMixer.isMuted());
         this.updateSoundButton(param1.currentTarget as MovieClip);
      }
      
      public function updateSoundButton(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = param1.getChildByName("icon") as MovieClip;
         var _loc3_:MovieClip = param1.getChildByName("frame") as MovieClip;
         if(!_loc2_)
         {
            return;
         }
         if(this.soundMixer.isMuted())
         {
            _loc2_.gotoAndStop("off");
            _loc3_.gotoAndStop("off");
         }
         else
         {
            _loc2_.gotoAndStop("on");
            _loc3_.gotoAndStop("on");
         }
      }
      
      public function playMusic(param1:String, param2:Number = 0, param3:Number = -1) : cbSound
      {
         var _loc5_:MusicRequest = null;
         var _loc4_:MusicRequest = new MusicRequest(param1,param2,param3);
         if(this.musicList.length != 0)
         {
            _loc5_ = this.actualMusic;
            if(_loc5_.equal(_loc4_))
            {
               return null;
            }
            this.stopMusic(_loc5_.getName());
         }
         this.musicList.push(_loc4_);
         return this.playRequest(_loc4_);
      }
      
      public function stopMusic(param1:String = "") : void
      {
         var _loc3_:* = 0;
         if(param1 == "" && this.actualMusic != null)
         {
            param1 = this.actualMusic.getName();
         }
         if(this.musicList.length == 0)
         {
            return;
         }
         var _loc2_:MusicRequest = this.actualMusic;
         if(_loc2_.getName() != param1)
         {
            _loc3_ = int(this.musicList.length - 2);
            while(_loc3_ >= 0)
            {
               _loc2_ = this.musicList[_loc3_];
               if(_loc2_.getName() == param1)
               {
                  this.musicList.remove(_loc2_);
                  break;
               }
               _loc3_--;
            }
         }
         else
         {
            this.musicList.pop();
            this.soundMixer.stop(param1);
            _loc2_ = this.actualMusic;
            if(_loc2_ != null)
            {
               this.playRequest(_loc2_);
            }
         }
      }
      
      private function get actualMusic() : MusicRequest
      {
         if(this.musicList.length == 0)
         {
            return null;
         }
         return this.musicList[this.musicList.length - 1];
      }
      
      public function playFx(param1:String, param2:Number = 0, param3:Number = -1) : cbSound
      {
         return this.soundMixer.play(param1,param2,false,param3);
      }
      
      public function stopFx(param1:String) : void
      {
         this.soundMixer.stop(param1);
      }
      
      private function playRequest(param1:MusicRequest) : cbSound
      {
         return this.soundMixer.play(param1.getName(),param1.getStartTime(),true,param1.getVolume());
      }
      
      public function resumeSound(param1:String) : void
      {
         this.soundMixer.resumeSound(param1);
      }
      
      public function pauseSound(param1:String) : void
      {
         this.soundMixer.pauseSound(param1);
      }
      
      public function isPlaying(param1:String) : Boolean
      {
         return this.soundMixer.isPlaying(param1);
      }
   }
}

