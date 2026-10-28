package loader
{
   import cb.media.SoundLoader;
   import sound.SoundManager;
   import util.Util;
   
   public class SoundResourceLoader implements ResourceLoader
   {
      
      private var soundManager:SoundManager;
      
      public function SoundResourceLoader(param1:SoundManager)
      {
         super();
         this.soundManager = param1;
      }
      
      public function load(param1:String, param2:Function) : void
      {
         var _loc3_:SoundLoader = new SoundLoader(param1);
         _loc3_.loaded.add(Util.l(this.soundLoaded,param2));
         _loc3_.load();
      }
      
      private function soundLoaded(param1:SoundLoader, param2:Function) : void
      {
         this.soundManager.addSound(param1);
         param2();
      }
   }
}

