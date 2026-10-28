package main_game.character.stats
{
   import main_game.items.Item;
   
   public class StatsEffectGuardian
   {
      
      private var stats:Stats;
      
      public function StatsEffectGuardian(param1:Stats)
      {
         super();
         this.stats = param1;
      }
      
      public function removeEfectsOfItem(param1:Item) : void
      {
         if(param1 != null)
         {
            param1.getPrimaryModifier().disaffect(this.stats);
            param1.getSecondaryModifier().disaffect(this.stats);
            this.stats.onChange.emit();
         }
      }
      
      public function addEfectsOfItem(param1:Item) : void
      {
         if(param1 != null)
         {
            param1.getPrimaryModifier().affect(this.stats);
            param1.getSecondaryModifier().affect(this.stats);
            this.stats.onChange.emit();
         }
      }
      
      public function clear() : void
      {
         this.stats = null;
      }
   }
}

