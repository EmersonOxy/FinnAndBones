package view.screens.main_game.cookBook
{
   import cb.actions.Functor;
   import cb.data.ButtonGroup;
   import cb.display.SmartMC;
   import conditions.EndCurrentLabel;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import util.Buttons;
   import util.Util;
   import view.screens.AnimatedScreen;
   import view.screens.main_game.map.ArrowView;
   
   public class CookBook extends AnimatedScreen
   {
      
      private const NEXT_ANIMATION:String = "toLeft";
      
      private const PREVIOUS_ANIMATION:String = "toRight";
      
      private var actualPage:CookBookPage;
      
      private var nextPage:CookBookPage;
      
      private var nextButton:ArrowView;
      
      private var previousButton:ArrowView;
      
      private var actualIndex:uint;
      
      public function CookBook(param1:Function)
      {
         super(main.swfLoader.getClass("assets.Recipes"),this.getButtonInfo(param1));
         this.container = "container";
         this.initialize();
         this.initializeArrows();
         this.refreshArrows();
      }
      
      public function get recipes() : Array
      {
         return main.saveSystem.recipes;
      }
      
      private function get initPageContainer() : MovieClip
      {
         return this.pagesContainer.recipesInit;
      }
      
      private function get nextPageContainer() : MovieClip
      {
         return this.pagesContainer.recipes_6_all;
      }
      
      private function get pagesContainer() : MovieClip
      {
         return bg.container;
      }
      
      private function getButtonInfo(param1:Function) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["cancel"] = ButtonGroup.get("gui").createButton(param1,"mouseOver","mouseOut");
         return _loc2_;
      }
      
      private function initialize() : void
      {
         Buttons.setButtons(bg.container,["cancel"],false);
         this.gotoIdle();
         this.actualIndex = 0;
         this.actualPage = this.makePage(this.actualIndex);
         this.initPageContainer.addChild(this.actualPage.getMc());
      }
      
      private function makePage(param1:uint) : CookBookPage
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = param1 * 6;
         while(_loc3_ < this.recipes.length && _loc3_ < (param1 + 1) * 6)
         {
            _loc2_.push(this.recipes[_loc3_]);
            _loc3_++;
         }
         return new CookBookPage(_loc2_);
      }
      
      private function initializeArrows() : void
      {
         this.nextButton = new ArrowView(bg.container.arrow_right,this.toNextPage);
         this.previousButton = new ArrowView(bg.container.arrow_left,this.toPreviousPage);
      }
      
      private function refreshArrows() : void
      {
         if(this.actualIndex > 0)
         {
            this.previousButton.show();
         }
         else
         {
            this.previousButton.hide();
         }
         if(this.recipes.length >= (this.actualIndex + 1) * 6)
         {
            this.nextButton.show();
         }
         else
         {
            this.nextButton.hide();
         }
      }
      
      private function toNextPage() : void
      {
         this.actualIndex += 1;
         this.toActualPage(this.NEXT_ANIMATION);
      }
      
      private function toPreviousPage() : void
      {
         --this.actualIndex;
         this.toActualPage(this.PREVIOUS_ANIMATION);
      }
      
      private function toActualPage(param1:String) : void
      {
         this.nextPage = this.makePage(this.actualIndex);
         this.nextPageContainer.addChild(this.nextPage.getMc());
         this.pagesContainer.gotoAndPlay(param1);
         new SmartMC(this.pagesContainer).trigger(new EndCurrentLabel(this.pagesContainer),Functor.wrap(this.updatePage));
         this.previousButton.hide();
         this.nextButton.hide();
      }
      
      private function updatePage() : void
      {
         this.actualPage.pop();
         this.actualPage = this.nextPage;
         this.nextPage = null;
         this.nextPageContainer.removeChild(this.actualPage.getMc());
         this.initPageContainer.addChild(this.actualPage.getMc());
         this.gotoIdle();
         this.refreshArrows();
      }
      
      override public function enter(param1:Function = null) : void
      {
         super.enter(Util.concatenate(param1,Util.l(Buttons.setButtons,bg.container,["cancel"],true)));
      }
      
      override public function leave(param1:Function = null) : void
      {
         Buttons.setButtons(bg.container,["cancel"],false);
         this.pagesContainer.stop();
         super.leave(param1);
      }
      
      private function gotoIdle() : void
      {
         this.pagesContainer.gotoAndStop(this.NEXT_ANIMATION);
      }
      
      override public function clear() : void
      {
         this.pagesContainer.stop();
         super.clear();
         this.actualPage.clear();
         this.actualPage = null;
         if(this.nextPage != null)
         {
            this.nextPage.clear();
         }
         this.nextPage = null;
         this.nextButton.clear();
         this.previousButton.clear();
      }
   }
}

