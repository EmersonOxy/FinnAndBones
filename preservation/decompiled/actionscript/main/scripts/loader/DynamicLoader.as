package loader
{
   import cb.signals.Signal;
   
   public interface DynamicLoader
   {
      
      function isLoaded(param1:String) : Boolean;
      
      function get onLoad() : Signal;
   }
}

