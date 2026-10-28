package main_game.character
{
   import main_game.character.stats.EnemyStats;
   import main_game.character.stats.Stats;
   import main_game.element.Element;
   
   public class Enemy extends Fighter
   {
      
      protected var element:Element;
      
      public function Enemy(param1:String, param2:CharacterConfigData, param3:Number)
      {
         this.element = param2.element;
         super(param1,param2);
         this.stats.leveling(param3);
      }
      
      override protected function createStats(param1:CharacterConfigData) : Stats
      {
         return new EnemyStats(param1,this);
      }
      
      public function getElement() : Element
      {
         return this.element;
      }
      
      public function getType() : String
      {
         return this.getName().charAt(5);
      }
   }
}

