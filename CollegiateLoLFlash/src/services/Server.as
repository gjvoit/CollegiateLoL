package services
{
	import flash.system.Security;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	/*
	 * class provides the functionality for communicating with the server, specifically making direct calls to
	 * the server's java functions and receiving the results
	*/
	public class Server
	{
		//the singleton instance
		private static var _instance:Server = new Server();
		
		//the remote object that is used to communicate with the server
		private var _remoteObject:RemoteObject;
		
		private var _callbacks:Dictionary;
		private var _operations:Dictionary;
		
		public function Server()
		{
			if(_instance)
				trace("ERROR: cannot re-initialize singleton class: Server");
		}
		
		public function initialize(remoteObject:RemoteObject):void{
			
			Security.allowDomain("*");
			
			//save the remoteObject
			_remoteObject = remoteObject;
			
			_remoteObject.addEventListener(ResultEvent.RESULT, onResult);
			_remoteObject.addEventListener(FaultEvent.FAULT, onFault);			
			
			_callbacks = new Dictionary();
			_operations = new Dictionary();
		}
		
		public function call(methodName:String, callback:Function, ... args):void {
			var operation:Operation = Operation(_remoteObject.getOperation(methodName));
			if(!operation) throw new Error("ERROR: RemoteObject does not have method: " + methodName);
			operation.arguments = args;
			
			trace("Calling: " + methodName);
			
			var token:AsyncToken = operation.send();
			_callbacks[token] = callback;
			_operations[token] = operation;
		}
		
		private function onResult(e:ResultEvent):void{
			var result:Object = e.result;
			var token:AsyncToken = e.token;
			var operation:Operation = _operations[token];
			
			var callback:Function = _callbacks[token];
			delete _callbacks[token];
			
			if(callback != null) {
				switch(callback.length) {
					case 0: callback(); break;
					case 1: callback(result); break;
					case 2: callback(result, operation); break;
					default: 
						throw new Error("[DatabaseService : Error] Callback provided for method " + operation.name + " has invalid number of arguments.");
						trace("[DatabaseService : Error] Callback provided for method " + operation.name + " has invalid number of arguments.");
				}
			}
			
			delete _operations[token];
		}
		
		private function onFault(e:FaultEvent):void {
			trace("FAULT: " + e.message);			
		}
		
		
		//a getter for the instance
		public static function get instance():Server{ return _instance; }
		
		
	}
}