package cb.data
{
   import cb.media.cbSoundMixer;
   import flash.events.MouseEvent;
   
   public class ButtonGroup
   {
      
      private static var groups:Array = [];
      
      private var soundMixer:cbSoundMixer;
      
      private var clickSound:String;
      
      private var overSound:String;
      
      private var mouseOutFuncs:Array;
      
      private var mouseOverFuncs:Array;
      
      private var clickFuncs:Array;
      
      public function ButtonGroup()
      {
         super();
         this.mouseOutFuncs = [];
         this.mouseOverFuncs = [];
         this.clickFuncs = [];
      }
      
      public static function get(param1:String) : ButtonGroup
      {
         if(groups[param1] == undefined)
         {
            groups[param1] = new ButtonGroup();
         }
         return groups[param1];
      }
      
      public function setSoundMixer(param1:cbSoundMixer) : ButtonGroup
      {
         this.soundMixer = param1;
         return this;
      }
      
      public function setClickSound(param1:String) : ButtonGroup
      {
         this.clickSound = param1;
         return this;
      }
      
      public function setOverSound(param1:String) : ButtonGroup
      {
         this.overSound = param1;
         return this;
      }
      
      public function createButton(param1:Function, param2:* = null, param3:* = null, param4:Boolean = true, param5:String = null) : ButtonInfo
      {
         var _loc6_:Function = null;
         if(param2 is String)
         {
            param2 = ButtonInfo.defaultGoto(param2,param4,param5);
         }
         if(param3 is String)
         {
            param3 = ButtonInfo.defaultGoto(param3,param4,param5);
         }
         _loc6_ = this.createFunc(param1,this.clickSound,this.clickFuncs);
         var _loc7_:Function = this.createFunc(param2,this.overSound,this.mouseOverFuncs);
         var _loc8_:Function = this.createFunc(param3,null,this.mouseOutFuncs);
         return new ButtonInfo(_loc6_,_loc7_,_loc8_,param4,param5);
      }
      
      public function addMouseOver(param1:Function) : ButtonGroup
      {
         this.mouseOverFuncs.push(param1);
         return this;
      }
      
      public function addMouseOut(param1:Function) : ButtonGroup
      {
         this.mouseOutFuncs.push(param1);
         return this;
      }
      
      public function addClick(param1:Function) : ButtonGroup
      {
         this.clickFuncs.push(param1);
         return this;
      }
      
      private function createFunc(param1:Function, param2:String, param3:Array) : Function
      {
         var o:Function;
         var oList:Array = null;
         var cb:Function = param1;
         var sound:String = param2;
         var list:Array = param3;
         oList = [];
         if(cb != null)
         {
            oList.push(cb);
         }
         if(sound)
         {
            oList.push(function(param1:MouseEvent):void
            {
               soundMixer.play(sound);
            });
         }
         oList = list.concat(oList);
         o = function(param1:MouseEvent):void
         {
            var _loc2_:Function = null;
            for each(_loc2_ in oList)
            {
               _loc2_(param1);
            }
         };
         return o;
      }
   }
}

