package view.figthers
{
   import cb.utils.Tween;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import main_game.character.Fighter;
   import main_game.character.stats.HealthStat;
   import main_game.character.stats.StatType;
   import main_game.character.stats.Stats;
   import view.screens.main_game.BarView;
   
   public class HudView
   {
      
      protected var stats:Stats;
      
      protected var mc:MovieClip;
      
      protected var bar:BarView;
      
      private var setter:HudSetter;
      
      public function HudView(param1:Class, param2:HudSetter)
      {
         super();
         this.mc = new param1();
         this.setter = param2;
      }
      
      public function changeFighter(param1:Fighter) : void
      {
         if(this.stats != null)
         {
            this.stats.onChange.remove(this.refresh);
         }
         if(param1 != null)
         {
            this.stats = param1.stats;
            this.stats.onChange.add(this.refresh);
            this.setter.setNameAndLevel(this.mc,param1);
         }
         else
         {
            this.stats = null;
         }
         this.refresh();
      }
      
      public function initialize(param1:DisplayObjectContainer) : void
      {
         this.mc.x = 0;
         this.mc.y = 0;
         param1.addChild(this.mc);
         this.bar = new BarView(this.mc.bar,main.locale,"health_status");
         this.refresh();
      }
      
      public function refresh() : void
      {
         var health:HealthStat = null;
         Tween.killTweensOf(this.bar);
         if(this.stats != null)
         {
            health = this.getHealth();
            this.bar.total = health.getUpperBound().getValue();
            Tween.to(this.bar,300,{"current":health.getValue()},function():void
            {
               bar.current = health.getValue();
            });
         }
         else
         {
            this.bar.total = 100;
            this.bar.current = 0;
         }
         this.setter.setHud(this.mc,this.stats);
      }
      
      public function clear() : void
      {
         Tween.killTweensOf(this.bar);
         if(this.stats != null)
         {
            this.stats.onChange.remove(this.refresh);
         }
         this.stats = null;
         this.mc = null;
         this.bar.clear();
      }
      
      private function getHealth() : HealthStat
      {
         return this.stats.getStat(StatType.HEALTH) as HealthStat;
      }
   }
}

