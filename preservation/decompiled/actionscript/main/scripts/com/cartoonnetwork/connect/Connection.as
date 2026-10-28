package com.cartoonnetwork.connect
{
   import flash.events.StatusEvent;
   import flash.events.TimerEvent;
   import flash.net.LocalConnection;
   import flash.utils.Timer;
   
   public class Connection
   {
      
      public var _rLC:LocalConnection = new LocalConnection();
      
      public var _sLC:LocalConnection = new LocalConnection();
      
      public var _rConnection:String;
      
      public var _sConnection:String;
      
      public var _connected:Boolean;
      
      private var _connectTimer:Timer;
      
      private var _unique:*;
      
      private var _uniqueClient:*;
      
      private var _master:Boolean;
      
      public function Connection(param1:String, param2:String, param3:*, param4:Boolean)
      {
         super();
         this._rConnection = param1;
         this._sConnection = param2;
         this._uniqueClient = param3;
         this._master = param4;
         if(this._master)
         {
            this._unique = Math.floor(Math.random() * 10000);
            this._rConnection += this._unique;
            this.initConnection();
            this._rLC.connect(this._rConnection);
            this._rLC.client = this;
         }
         else
         {
            this._rLC.connect(this._rConnection);
            this._rLC.client = this;
         }
      }
      
      public function initConnection() : void
      {
         this._connectTimer = new Timer(2000);
         this._connectTimer.addEventListener("timer",this.AttemptConnection);
         this._sLC.addEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         this.AttemptConnection(null);
         this._connectTimer.start();
      }
      
      public function AttemptConnection(param1:TimerEvent) : void
      {
         this._sLC.send(this._sConnection,"setUnique",this._unique);
      }
      
      public function setUnique(param1:int) : void
      {
         this._unique = param1;
         this._rConnection += this._unique;
         this._sConnection += this._unique;
         this._sLC.send(this._sConnection,"slaveReceivedUnique");
         this._sLC.addEventListener(StatusEvent.STATUS,this.onStatus);
         this._rLC.close();
         this._rLC.connect(this._rConnection);
         this._rLC.client = this._uniqueClient;
         this._connected = true;
      }
      
      public function slaveReceivedUnique() : void
      {
         this._sLC.removeEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         this._sLC.addEventListener(StatusEvent.STATUS,this.onStatus);
         this._connected = true;
         this._sConnection += this._unique;
         this._connectTimer.stop();
         this._connectTimer.removeEventListener("timer",this.AttemptConnection);
         this._rLC.close();
         this._rLC.connect(this._rConnection);
         this._rLC.client = this._uniqueClient;
      }
      
      public function send(param1:String, ... rest) : void
      {
         if(rest.length > 0)
         {
            this._sLC.send(this._sConnection,param1,rest);
         }
         else
         {
            this._sLC.send(this._sConnection,param1);
         }
      }
      
      private function onConnectionStatus(param1:StatusEvent) : void
      {
         switch(param1.level)
         {
            case "status":
               this.slaveReceivedUnique();
               break;
            case "error":
         }
      }
      
      private function onStatus(param1:StatusEvent) : void
      {
         switch(param1.level)
         {
            case "status":
            case "error":
         }
      }
   }
}

