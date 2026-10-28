package
{
   import cb.logger.Appender;
   import cb.logger.JSConsoleAppender;
   import cb.logger.Log;
   import com.cartoonnetwork.AchievementSystem.AchievementAS3;
   import main_game.map.Level;
   
   public class AchievementDispatcher
   {
      
      private static const FriendlyJR:String = "200";
      
      private static const FirstMap:String = "201";
      
      private static const Mix:String = "202";
      
      private static const FinalLevel:String = "203";
      
      private static const Unequipped:String = "204";
      
      private var achievementSystem:AchievementAS3;
      
      public function AchievementDispatcher()
      {
         super();
         this.logger().addAppender(new Appender());
         this.logger().addAppender(new JSConsoleAppender());
         this.achievementSystem = new AchievementAS3();
      }
      
      private function logger() : Log
      {
         return Log.getLogger("achievement");
      }
      
      public function gameLoaded() : void
      {
         this.achievementSystem.achievementNotificationGameLoaded();
         this.logger().log("game loaded");
      }
      
      public function gamePlayed() : void
      {
         this.achievementSystem.achievementNotificationGameStarted();
         this.logger().log("game played");
      }
      
      public function gameWon() : void
      {
         this.achievementSystem.achievementNotificationGameEnded();
         this.logger().log("game ended");
      }
      
      public function madeMix() : void
      {
         this.achievementSystem.sendStat(Mix,1);
         this.logger().log("Mix made");
      }
      
      public function finishFirstPage() : void
      {
         this.achievementSystem.sendStat(FirstMap,1);
         this.logger().log("Dungeon 8 cleared");
      }
      
      public function unequippedDungeonCompleted(param1:Level) : void
      {
         this.achievementSystem.sendStat(Unequipped,1);
         this.logger().log("Clear 10 different dungeons without equipment");
      }
      
      public function friendlyRockJrObtained() : void
      {
         this.achievementSystem.sendStat(FriendlyJR,1);
         this.logger().log("FriendlyRockJr created");
      }
      
      public function endLastDungeon() : void
      {
         this.achievementSystem.sendStat(FinalLevel,1);
         this.logger().log("Last dungeon cleared");
      }
   }
}

