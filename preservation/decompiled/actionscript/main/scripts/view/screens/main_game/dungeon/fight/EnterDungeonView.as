package view.screens.main_game.dungeon.fight
{
   import cb.gameloop.GameLoop;
   import main_game.dungeon.Dungeon;
   import view.figthers.FinnView;
   import view.figthers.animations.IFighterAnimation;
   import view.figthers.animations.RunAnimation;
   import view.screens.main_game.dungeon.BackgroundView;
   import view.screens.main_game.dungeon.InnerDungeonView;
   
   public class EnterDungeonView implements InnerDungeonView
   {
      
      private var bg:BackgroundView;
      
      private var finnView:FinnView;
      
      private var atEnd:Function;
      
      private var paused:Boolean;
      
      private var gameLoop:GameLoop;
      
      private var walk:RunAnimation;
      
      public function EnterDungeonView(param1:FinnView, param2:BackgroundView, param3:Function)
      {
         super();
         this.bg = param2;
         this.finnView = param1;
         this.atEnd = param3;
         this.gameLoop = new GameLoop(param2);
         this.gameLoop.updated.add(this.refresh);
         this.paused = false;
         this.start();
      }
      
      public function start() : void
      {
         var _loc1_:Number = Dungeon.DungeonConfig["position_finn"] - Dungeon.DungeonConfig["lenght_step"] * 2;
         this.finnView.putIn(this.bg.arena);
         this.finnView.x = _loc1_ - Dungeon.DungeonConfig["start_lenght_step"];
         this.finnView.y = Dungeon.DungeonConfig["height_fighters"];
         this.walk = new RunAnimation(2,true,false);
         this.walk.getAtFinish().add(this.endEnter);
         this.finnView.animate(this.walk);
         if(!this.paused)
         {
            this.gameLoop.start();
         }
      }
      
      private function endEnter(param1:IFighterAnimation) : void
      {
         this.walk = null;
         this.gameLoop.stop();
         this.atEnd();
      }
      
      private function refresh(param1:int) : void
      {
         this.finnView.x += BackgroundView.ARENA_VELOCITY;
      }
      
      public function resume() : void
      {
         if(this.paused)
         {
            this.paused = false;
            this.gameLoop.start();
            this.finnView.resume();
         }
      }
      
      public function pause() : void
      {
         if(!this.paused)
         {
            this.paused = true;
            this.gameLoop.stop();
            this.finnView.pause();
         }
      }
      
      public function clear() : void
      {
         this.gameLoop.updated.clear();
         this.gameLoop = null;
         if(this.walk != null)
         {
            this.walk.kill();
         }
         this.walk = null;
      }
   }
}

