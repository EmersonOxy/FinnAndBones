package view.screens.main_game.states
{
   import cb.utils.cbArray;
   import main_game.map.Level;
   import main_game.map.Map;
   import sound.GameSounds;
   import view.screens.main_game.GameView;
   import view.screens.main_game.map.MapView;
   
   public class MapState extends BasicPausableState
   {
      
      private var principal:GameView;
      
      private var mapView:MapView;
      
      private var map:Map;
      
      public function MapState(param1:String, param2:GameView, param3:Function = null, param4:Function = null)
      {
         this.principal = param2;
         super(param1,param3,param4);
      }
      
      override public function enter() : void
      {
         this.map = main.game.getMap();
         this.mapView = new MapView(this);
         this.mapView.onToMainMenu.add(this.toMainMenu);
         this.mapView.onToDungeon.add(this.toLevel);
         this.principal.gameHolder["map"] = this.mapView;
         this.principal.gameHolder.addChild(this.mapView);
         var _loc1_:cbArray = this.map.unlockUnlocked();
         this.mapView.refreshUnlocked(_loc1_);
         main.game.getFinn().stats.refillHealth();
         super.enter();
         main.soundManager.playMusic(GameSounds.MAP_MUSIC);
      }
      
      override public function leave() : void
      {
         this.mapView.close();
         this.map = null;
         super.leave();
      }
      
      private function toMainMenu() : void
      {
         this.principal.toMainMenu();
      }
      
      private function toLevel(param1:Level) : void
      {
         this.principal.toLevelWaiting(param1);
      }
      
      public function getMap() : Map
      {
         return this.map;
      }
   }
}

