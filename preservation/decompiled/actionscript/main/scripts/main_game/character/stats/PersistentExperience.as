package main_game.character.stats
{
   public class PersistentExperience extends Experience
   {
      
      private var persist:Boolean = false;
      
      public function PersistentExperience(param1:Stats)
      {
         super(param1);
      }
      
      public function startPersistence() : void
      {
         this.value = main.saveSystem.getExperience();
         refreshLevel();
         this.persist = true;
      }
      
      override public function modifyValue(param1:Number) : void
      {
         super.modifyValue(param1);
         if(param1 != 0 && this.persist)
         {
            main.saveSystem.saveExperience(this.value);
         }
      }
   }
}

