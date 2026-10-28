package cb.media
{
   public interface SoundMixable
   {
      
      function mute() : void;
      
      function unmute() : void;
      
      function isMuted() : Boolean;
      
      function queue(param1:String, param2:cbSound, param3:Boolean = false) : cbSound;
      
      function play(param1:String, param2:Number = 0, param3:Boolean = false, param4:Number = -1) : cbSound;
      
      function stop(param1:String) : void;
   }
}

