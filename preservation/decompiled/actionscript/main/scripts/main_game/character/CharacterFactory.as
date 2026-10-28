package main_game.character
{
   import flash.utils.Dictionary;
   import main_game.boss_dungeon.Boss;
   import view.figthers.EnemyView;
   import view.figthers.FinnView;
   import view.screens.main_game.boss_dungeon.BossView;
   
   public class CharacterFactory
   {
      
      private static var instance:CharacterFactory;
      
      private static var config:Dictionary;
      
      public function CharacterFactory(param1:SingletonLock)
      {
         super();
         if(!param1)
         {
            throw new Error("Static Class");
         }
      }
      
      public static function getInstance() : CharacterFactory
      {
         if(instance == null)
         {
            instance = new CharacterFactory(new SingletonLock());
         }
         return instance;
      }
      
      public static function setConfig(param1:Dictionary) : void
      {
         config = param1;
      }
      
      public function getInitialHealth() : uint
      {
         return uint(config["Finn"]["BaseHP"]);
      }
      
      public function getEnemyView(param1:Enemy) : EnemyView
      {
         return new EnemyView(param1);
      }
      
      public function getFinnView(param1:Finn) : FinnView
      {
         return new FinnView(param1);
      }
      
      public function getBossView(param1:Boss) : BossView
      {
         return new BossView(param1);
      }
      
      public function getBoss(param1:uint) : Boss
      {
         var _loc2_:String = "boss_normal";
         return new Boss(_loc2_,this.getConfig(_loc2_),param1);
      }
      
      public function getEnemy(param1:String, param2:uint) : Enemy
      {
         if(config == null)
         {
            throw new Error("No se cuenta con el archivo de configuracion");
         }
         return new Enemy(param1,this.getConfig(param1),param2);
      }
      
      public function getFinn() : Finn
      {
         return new Finn("Finn",this.getConfig("Finn"));
      }
      
      public function getConfig(param1:String) : CharacterConfigData
      {
         return new CharacterConfigParser(config[param1]);
      }
   }
}

class SingletonLock
{
   
   public function SingletonLock()
   {
      super();
   }
}
