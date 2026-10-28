package bonus
{
   import bonus.events.ParseEvent;
   import flash.utils.Dictionary;
   
   public class ClassLoader
   {
      
      private var classes:Dictionary;
      
      private var parser:LexicalParser;
      
      private var parsingObject:Object;
      
      private var parsingClass:String;
      
      private var references:Dictionary;
      
      private var arrayReferences:Array;
      
      private var parsingsArray:Array = new Array();
      
      private var arrayPos:int = -1;
      
      public function ClassLoader(param1:FileLoader)
      {
         super();
         this.parser = new LexicalParser(param1.name);
         this.classes = new Dictionary();
         this.references = new Dictionary();
         this.arrayReferences = new Array();
         this.parser.addEventListener(LexicalParser.START_PARSING_CLASS,this.startParsingClass,false,0,true);
         this.parser.addEventListener(LexicalParser.END_CLASS,this.endClass,false,0,true);
         this.parser.addEventListener(LexicalParser.END_ATTRIBUTE,this.endAttribute,false,0,true);
         this.parser.addEventListener(LexicalParser.START_ARRAY,this.startArray,false,0,true);
         this.parser.addEventListener(LexicalParser.END_ARRAY,this.endArray,false,0,true);
         this.parser.parse(String(param1.data));
      }
      
      private function startParsingClass(param1:ParseEvent) : void
      {
         this.parsingClass = param1.name;
         this.parsingObject = new Object();
      }
      
      private function endClass(param1:ParseEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         this.classes[this.parsingClass] = this.clone(this.parsingObject);
         var _loc2_:Array = [];
         for each(_loc3_ in this.references)
         {
            if(this.classes[_loc3_.clazz] != undefined)
            {
               this.classes[_loc3_.obj][_loc3_.attr] = this.clone(this.classes[_loc3_.clazz]);
               _loc2_.push(_loc3_.attr);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            delete this.references[_loc4_];
         }
         this.completeArrayReferences();
      }
      
      private function completeArrayReferences() : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = -1;
         for each(_loc3_ in this.arrayReferences)
         {
            _loc2_++;
            if(this.classes[_loc3_.clazz] != undefined)
            {
               this.classes[_loc3_.obj][_loc3_.attr][_loc3_.pos] = this.clone(this.classes[_loc3_.clazz]);
               _loc1_.push(_loc2_);
            }
         }
         for each(_loc4_ in _loc1_)
         {
            this.arrayReferences.splice(_loc2_,1);
         }
      }
      
      private function endAttribute(param1:ParseEvent) : void
      {
         if(param1.valueType == LexicalParser.CLASS)
         {
            this.references[param1.name] = {
               "clazz":param1.value,
               "obj":this.parsingClass,
               "attr":param1.name
            };
            this.parsingObject[param1.name] = new Object();
         }
         else if(param1.valueType == LexicalParser.ARRAY)
         {
            this.parsingsArray[this.arrayPos].push(param1.value);
         }
         else if(param1.valueType == LexicalParser.CLASSARRAY)
         {
            this.arrayReferences.push({
               "clazz":param1.value,
               "attr":param1.name,
               "pos":this.parsingsArray[this.arrayPos].length,
               "obj":this.parsingClass
            });
            this.parsingsArray[this.arrayPos].push(new Object());
         }
         else
         {
            this.parsingObject[param1.name] = param1.value;
         }
      }
      
      private function startArray(param1:ParseEvent) : void
      {
         ++this.arrayPos;
         this.parsingsArray.push(new Array());
      }
      
      private function endArray(param1:ParseEvent) : void
      {
         if(this.arrayPos > 0)
         {
            this.parsingsArray[this.arrayPos - 1].push(this.clone(this.parsingsArray[this.arrayPos]));
         }
         else
         {
            this.parsingObject[param1.name] = this.clone(this.parsingsArray[this.arrayPos]);
         }
         this.parsingsArray.splice(this.arrayPos,1);
         --this.arrayPos;
      }
      
      private function clone(param1:Object) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(param1 is Array)
         {
            _loc2_ = new Array();
         }
         else
         {
            _loc2_ = new Object();
         }
         for(_loc3_ in param1)
         {
            if(typeof param1[_loc3_] == "object")
            {
               _loc2_[_loc3_] = this.clone(param1[_loc3_]);
            }
            else
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
         }
         return _loc2_;
      }
      
      public function get(param1:String) : Object
      {
         return this.classes[param1];
      }
      
      public function getCopy(param1:String) : Object
      {
         return this.clone(this.get(param1));
      }
   }
}

