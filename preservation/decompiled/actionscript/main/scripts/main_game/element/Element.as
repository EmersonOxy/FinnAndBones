package main_game.element
{
   public class Element
   {
      
      private static var fireElement:Element;
      
      private static var iceElement:Element;
      
      private static var normalElement:Element;
      
      public static const FIRE:String = "F";
      
      public static const ICE:String = "I";
      
      public static const NORMAL:String = "N";
      
      public function Element(param1:Lock)
      {
         super();
      }
      
      public static function get fire() : Element
      {
         if(!fireElement)
         {
            fireElement = new Fire();
         }
         return fireElement;
      }
      
      public static function get ice() : Element
      {
         if(!iceElement)
         {
            iceElement = new Ice();
         }
         return iceElement;
      }
      
      public static function get normal() : Element
      {
         if(!normalElement)
         {
            normalElement = new Normal();
         }
         return normalElement;
      }
      
      public static function parseElement(param1:String) : Element
      {
         var _loc2_:String = param1;
         if(_loc2_ == null)
         {
            _loc2_ = NORMAL;
         }
         else if(_loc2_ == "Ice")
         {
            _loc2_ = ICE;
         }
         else if(_loc2_ == "Fire")
         {
            _loc2_ = FIRE;
         }
         switch(_loc2_)
         {
            case FIRE:
               return fire;
            case ICE:
               return ice;
            case NORMAL:
               return normal;
            default:
               throw new Error("Cant parse: " + param1);
         }
      }
      
      public function get isOfFire() : Boolean
      {
         return false;
      }
      
      public function get isOfIce() : Boolean
      {
         return false;
      }
      
      public function get type() : String
      {
         throw new Error("AbstractClass");
      }
      
      public function clear() : void
      {
      }
   }
}

import main_game.element.Element;

class Fire extends Element
{
   
   public function Fire()
   {
      super(new Lock());
   }
   
   override public function get isOfFire() : Boolean
   {
      return true;
   }
   
   override public function get type() : String
   {
      return FIRE;
   }
}

class Ice extends Element
{
   
   public function Ice()
   {
      super(new Lock());
   }
   
   override public function get isOfIce() : Boolean
   {
      return true;
   }
   
   override public function get type() : String
   {
      return ICE;
   }
}

class Normal extends Element
{
   
   public function Normal()
   {
      super(new Lock());
   }
   
   override public function get type() : String
   {
      return NORMAL;
   }
}

class Lock
{
   
   public function Lock()
   {
      super();
   }
}
