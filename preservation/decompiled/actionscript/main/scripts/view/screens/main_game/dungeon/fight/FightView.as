package view.screens.main_game.dungeon.fight
{
   import main_game.character.CharacterFactory;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.IFight;
   import view.figthers.FighterView;
   import view.figthers.FinnView;
   import view.figthers.animations.IFighterAnimation;
   import view.figthers.animations.IdleAnimation;
   import view.figthers.animations.RunAnimation;
   import view.screens.main_game.dungeon.BackgroundView;
   
   public class FightView extends BasicFightView
   {
      
      public function FightView(param1:IFight, param2:FighterView, param3:BackgroundView)
      {
         super(param1,param3,param2);
      }
      
      override protected function initializeViews(param1:Array) : void
      {
         var _loc2_:FinnView = param1[0];
         views[main.game.getFinn()] = _loc2_;
         views[fight.getEnemy()] = CharacterFactory.getInstance().getEnemyView(fight.getEnemy());
      }
      
      private function get finnView() : FinnView
      {
         return views[main.game.getFinn()] as FinnView;
      }
      
      override protected function initialize() : void
      {
         enemy = fight.getEnemy();
         var _loc1_:FighterView = views[enemy];
         _loc1_.putIn(bg.arena);
         _loc1_.y = Dungeon.DungeonConfig["height_fighters"];
         _loc1_.x = Dungeon.DungeonConfig["position_enemy"] + Dungeon.DungeonConfig["lenght_step"] * Dungeon.DungeonConfig["steps_to_find_enemy"];
         _loc1_.x += Dungeon.DungeonConfig["end_lenght_step"];
         if(!fight.isFirst())
         {
            _loc1_.x += Dungeon.DungeonConfig["start_lenght_step"];
         }
         _loc1_.animate(new IdleAnimation());
         super.initialize();
      }
      
      override protected function won() : void
      {
         main.game.getDungeon().wonFight();
      }
      
      override protected function lose() : void
      {
         main.game.getDungeon().lostFight();
      }
      
      private function moveEnemy(param1:Number) : void
      {
         views[enemy].x -= param1;
      }
      
      override protected function enter(param1:Function) : void
      {
         var callback:Function = param1;
         var steps:Number = Number(Dungeon.DungeonConfig["steps_to_find_enemy"]);
         var walk:RunAnimation = new RunAnimation(steps,!fight.isFirst());
         this.finnView.animate(walk);
         walk.getAtFinish().add(function(param1:IFighterAnimation):void
         {
            atEndEnter(callback);
         });
         bg.onMove.add(this.moveEnemy);
         bg.beginScroll();
      }
      
      private function atEndEnter(param1:Function) : void
      {
         bg.endScroll();
         bg.onMove.remove(this.moveEnemy);
         super.enter(param1);
      }
      
      override public function clear() : void
      {
         (views[enemy] as FighterView).clear();
         super.clear();
      }
   }
}

