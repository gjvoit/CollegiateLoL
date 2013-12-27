package  
{
	// Different class for each screen you want to see
	// Database should only store the most basic information it needs to reconstruct everything it needs to know (raw data)
	// Client can do some of the work - Client takes that data and displays it in some interesting way
	// Don't store redundant information
	// Register, Login, Display information - Work piece-wise, test that it absolutely works before moving on to the next feature
	import mx.rpc.remoting.RemoteObject;
	import spark.components.Application;
	import services.Server;
	/**
	 * ...
	 * @author Garet Voit
	 */
	public class CollegiateLoL extends Application
	{
		[Bindable]
		public var remoteObject:RemoteObject;
		
		public function CollegiateLoL() 
		{
			
		}
		
		public function initDone():void {
			trace("Hi");
			Server.instance.initialize(remoteObject);
			Server.instance.call("login", onLoginComplete, "user", "pass");
		}
		private function onLoginComplete(result:Object):void {
			trace(result);
		}
		
	}

}