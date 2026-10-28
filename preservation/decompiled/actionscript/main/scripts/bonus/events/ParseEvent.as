package bonus.events
{
   import flash.events.Event;
   
   public class ParseEvent extends Event
   {
      
      public var name:String;
      
      public var value:Object;
      
      public var valueType:int;
      
      public function ParseEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ParseEvent = new ParseEvent(type);
         _loc1_.name = this.name;
         _loc1_.value = this.value;
         _loc1_.valueType = this.valueType;
         return _loc1_;
      }
   }
}

