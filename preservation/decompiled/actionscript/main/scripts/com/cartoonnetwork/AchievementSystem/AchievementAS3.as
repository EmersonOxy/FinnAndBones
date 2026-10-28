package com.cartoonnetwork.AchievementSystem
{
   import com.cartoonnetwork.connect.Connection;
   import flash.display.Loader;
   import flash.utils.Timer;
   
   public class AchievementAS3
   {
      
      public static var _achievementNotificationFinished:Boolean;
      
      public static var STATUS_CONNECTING:int = 0;
      
      public static var STATUS_SHOWING_ACHIEVEMENT:int = 1;
      
      public static var STATUS_READY:int = 2;
      
      public static var _uniqueVal:int = -1;
      
      private var _swfLoader:Loader = new Loader();
      
      private var _connectTimer:Timer;
      
      private var _connectedToModule:Boolean;
      
      public var _xmlLoaded:Boolean = false;
      
      public var _status:int;
      
      private var _moduleConnection:Connection;
      
      private var _displayConnection:Connection;
      
      public function AchievementAS3()
      {
         super();
         this._moduleConnection = new Connection("fromAchieveModule","toAchieveModule",this,true);
      }
      
      public function sendStat(param1:String, param2:int) : void
      {
         this._moduleConnection.send("updateStat",param1,param2);
      }
      
      public function xmlLoaded() : void
      {
         this._xmlLoaded = true;
         this._displayConnection = new Connection("fromDisplayModule","toDisplayModule",this,false);
      }
      
      public function achievementEarned(param1:Array) : void
      {
         this.showAchievement(param1[0],param1[1]);
      }
      
      public function toString() : String
      {
         return "<< AchievementAS3 >>";
      }
      
      public function achievementNotificationGameLoaded() : void
      {
         this._moduleConnection.send("achievementNotificationGameLoaded");
      }
      
      public function achievementNotificationGameStarted() : void
      {
         this._moduleConnection.send("achievementNotificationGameStarted");
      }
      
      public function achievementNotificationGameEnded() : void
      {
         this._moduleConnection.send("achievementNotificationGameEnded");
      }
      
      public function achievementNotificationFinished() : void
      {
         AchievementAS3._achievementNotificationFinished = true;
      }
      
      public function isAchievmentNotificationFinished() : Boolean
      {
         var _loc1_:Boolean = _achievementNotificationFinished;
         _achievementNotificationFinished = false;
         return _loc1_;
      }
      
      public function showAchievement(param1:String, param2:String) : void
      {
         this._displayConnection.send("displayAchievement",param1,param2);
      }
   }
}

