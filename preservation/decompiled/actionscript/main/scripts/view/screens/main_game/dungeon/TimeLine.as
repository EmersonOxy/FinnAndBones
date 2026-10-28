package view.screens.main_game.dungeon
{
   import cb.utils.Tween;
   import flash.display.MovieClip;
   import main_game.character.Enemy;
   import main_game.dungeon.Dungeon;
   import main_game.dungeon.IFight;
   import main_game.element.Element;
   import main_game.map.LegendaryLevel;
   import main_game.map.Level;
   import util.Util;
   
   public class TimeLine extends MovieClip
   {
      
      private static const finnStart:Number = 74;
      
      private var dungeonView:DungeonView;
      
      private var finn:MovieClip;
      
      private var scale:Number;
      
      private var fight:Number;
      
      private var distance:Number;
      
      private var skulls:Array;
      
      private var alphalize:Boolean = false;
      
      public function TimeLine(param1:DungeonView)
      {
         super();
         this.skulls = new Array();
         this.dungeonView = param1;
         this.fight = 0;
         this.distance = 0;
         this.finn = main.swfLoader.getObject("assets.TimeLineFinn") as MovieClip;
         this.initialize();
      }
      
      private static function get positionX() : Number
      {
         return main.config.get("TimelineConfig")["x"];
      }
      
      private static function get positionY() : Number
      {
         return main.config.get("TimelineConfig")["y"];
      }
      
      public function initialize() : void
      {
         var _loc7_:MovieClip = null;
         var _loc1_:Dungeon = this.dungeonView.dungeon.getDungeon();
         _loc1_.onFight.add(this.nextFight);
         var _loc2_:Vector.<Enemy> = _loc1_.enemies;
         this.y = positionY;
         var _loc3_:MovieClip = main.swfLoader.getObject("assets.TimeLine") as MovieClip;
         this.setLevel(_loc3_,_loc1_.getLevel());
         this.x = positionX - _loc3_.width / 2;
         _loc3_.x = _loc3_.width / 2;
         addChild(_loc3_);
         var _loc4_:Number = _loc3_.width - 80;
         this.dungeonView.background.onMove.add(this.move);
         this.distance = _loc4_ / _loc2_.length;
         var _loc5_:Number = Dungeon.DungeonConfig["lenght_step"] * Dungeon.DungeonConfig["steps_to_find_enemy"];
         this.scale = this.distance / _loc5_;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc7_ = this.newStep(_loc2_[_loc6_]);
            _loc7_.x = this.positionOfFight(_loc6_ + 1);
            addChild(_loc7_);
            this.skulls.push(_loc7_);
            _loc6_++;
         }
         addChild(this.finn);
         this.finn.x = finnStart;
         _loc1_.onWin.add(Util.l(this.removeSkull,this.skulls[this.skulls.length - 1]));
      }
      
      private function setLevel(param1:MovieClip, param2:Level) : void
      {
         if(param2.isLegendary())
         {
            param1.level.gotoAndStop((param2 as LegendaryLevel).element.type);
         }
         else if(param2.isSpecial())
         {
            param1.level.gotoAndStop("special");
         }
         else
         {
            param1.level.gotoAndStop("level");
            param1.level.text.text = param2.getDungeonId();
         }
      }
      
      private function nextFight(param1:IFight) : void
      {
         this.alphalize = true;
         if(this.fight != 0)
         {
            this.finn.x = this.positionOfFight(this.fight);
         }
         this.fight += 1;
      }
      
      private function positionOfFight(param1:uint) : Number
      {
         return param1 * this.distance + 40;
      }
      
      private function move(param1:Number) : void
      {
         if(this.alphalize && this.fight > 1)
         {
            this.removeSkull(this.skulls[this.fight - 2]);
            this.alphalize = false;
         }
         this.finn.x = Math.min(this.finn.x + param1 * this.scale,this.positionOfFight(this.fight));
      }
      
      private function removeSkull(param1:MovieClip) : void
      {
         Tween.to(param1,800,{
            "rotation":1080,
            "y":108
         },Util.l(removeChild,param1));
      }
      
      private function newStep(param1:Enemy) : MovieClip
      {
         var _loc3_:Class = null;
         var _loc2_:Element = param1.getElement();
         if(_loc2_.isOfFire)
         {
            _loc3_ = main.swfLoader.getClass("assets.MapSkullFire");
         }
         else if(_loc2_.isOfIce)
         {
            _loc3_ = main.swfLoader.getClass("assets.MapSkullIce");
         }
         else
         {
            _loc3_ = main.swfLoader.getClass("assets.MapSkullNormal");
         }
         return new _loc3_();
      }
      
      public function clear() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.skulls)
         {
            Tween.killTweensOf(_loc1_);
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

