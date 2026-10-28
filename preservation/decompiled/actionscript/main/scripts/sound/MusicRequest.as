package sound
{
   public class MusicRequest
   {
      
      private var soundName:String;
      
      private var startTime:Number;
      
      private var volume:Number;
      
      public function MusicRequest(param1:String, param2:Number, param3:Number)
      {
         super();
         this.soundName = param1;
         this.startTime = param2;
         this.volume = param3;
      }
      
      public function equal(param1:MusicRequest) : Boolean
      {
         return this.soundName == param1.getName() && this.startTime == param1.getStartTime() && this.volume == param1.getVolume();
      }
      
      public function getName() : String
      {
         return this.soundName;
      }
      
      public function getVolume() : Number
      {
         return this.volume;
      }
      
      public function getStartTime() : Number
      {
         return this.startTime;
      }
   }
}

