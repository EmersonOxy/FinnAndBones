package view.popUp
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class PopUp
   {
      
      private var theMc:MovieClip;
      
      private var positioner:PopUpPositioner;
      
      public function PopUp(param1:MovieClip)
      {
         super();
         this.theMc = param1;
         this.mc.visible = false;
      }
      
      public function get mc() : MovieClip
      {
         return this.theMc;
      }
      
      public function addIn(param1:DisplayObjectContainer) : void
      {
         this.positioner = new PopUpPositioner(param1);
         this.positioner.addMc(this.mc);
      }
      
      public function hide(param1:Function = null) : void
      {
         this.mc.visible = false;
         if(param1 != null)
         {
            param1();
         }
      }
      
      public function show(param1:Function = null) : void
      {
         this.positioner.refreshPos(this.mc);
         this.mc.visible = true;
         if(param1 != null)
         {
            param1();
         }
      }
      
      public function clear() : void
      {
         if(this.mc.parent != null)
         {
            this.mc.parent.removeChild(this.mc);
         }
         this.positioner = null;
      }
   }
}

