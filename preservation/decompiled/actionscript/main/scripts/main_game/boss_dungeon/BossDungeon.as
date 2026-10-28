package main_game.boss_dungeon
{
   import main_game.character.CharacterFactory;
   import main_game.character.Enemy;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.DungeonConfigData;
   import main_game.dungeon.IFight;
   import main_game.map.Level;
   import util.ProbabilisticSet;
   
   public class BossDungeon extends Dungeon
   {
      
      public static const idBossLevel:String = "25";
      
      public function BossDungeon(param1:Level, param2:DungeonConfigData, param3:ProbabilisticSet)
      {
         super(param1,param2,param3);
      }
      
      override protected function createFight(param1:Enemy, param2:Boolean) : IFight
      {
         return new BossFight(param1 as Boss);
      }
      
      override protected function createEnemy(param1:String, param2:uint) : Enemy
      {
         return CharacterFactory.getInstance().getBoss(param2);
      }
   }
}

