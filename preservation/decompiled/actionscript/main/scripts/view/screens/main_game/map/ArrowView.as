package view.screens.main_game.map
{
   import cb.actions.Functor;
   import cb.display.SmartMC;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import sound.GameSounds;
   
   public class ArrowView
   {
      
      private var mc:MovieClip;
      
      private var showing:Boolean;
      
      private var click:Function;
      
      public function ArrowView(param1:MovieClip, param2:Function = null, param3:Boolean = false)
      {
         super();
         this.click = param2;
         this.mc = param1;
         this.showing = false;
         if(param3)
         {
            param1.gotoAndStop("arrowOut");
         }
         else
         {
            param1.gotoAndStop("arrowIn");
         }
         param1.buttonMode = true;
         this.initializeButton(param1);
         this.refreshAsButton();
      }
      
      private function initializeButton(param1:MovieClip) : void
      {
         param1.hitbox.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         param1.hitbox.addEventListener(MouseEvent.ROLL_OVER,this.over,false,0,true);
         param1.hitbox.addEventListener(MouseEvent.ROLL_OUT,this.out,false,0,true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         main.soundManager.playFx(GameSounds.BUTTON_CLICK);
         this.click();
      }
      
      private function over(param1:MouseEvent) : void
      {
         if(this.showing)
         {
            this.mc.gotoAndPlay("mouseOver");
            main.soundManager.playFx(GameSounds.MOUSE_OVER);
         }
      }
      
      private function out(param1:MouseEvent) : void
      {
         if(this.showing)
         {
            this.mc.gotoAndPlay("mouseOut");
            main.soundManager.playFx(GameSounds.MOUSE_OVER);
         }
      }
      
      public function hide() : void
      {
         if(this.showing)
         {
            this.showing = false;
            this.refreshAsButton();
            this.mc.gotoAndPlay("arrowOut");
         }
      }
      
      public function show() : void
      {
         if(!this.showing)
         {
            this.showing = true;
            this.mc.gotoAndPlay("arrowIn");
            new SmartMC(this.mc).trigger(new EndCurrentLabel(this.mc),Functor.wrap(this.refreshAsButton));
         }
      }
      
      private function refreshAsButton() : void
      {
         this.mc.mouseEnabled = this.showing;
         this.mc.mouseChildren = this.showing;
      }
      
      public function clear() : void
      {
         this.mc = null;
         this.click = null;
      }
   }
}

