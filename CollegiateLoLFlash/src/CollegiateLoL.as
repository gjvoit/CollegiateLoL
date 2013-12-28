package  
{
	// Make sure you fix your settings if you move to a new computer. Fresh installation of FlashDevelop
	// won't have the exact settings necessary for communicating with your Java files. Also be sure to
	// fix the necessary config files.
	// Different class for each screen you want to see
	// Database should only store the most basic information it needs to reconstruct everything it needs to know (raw data)
	// Client can do some of the work - Client takes that data and displays it in some interesting way
	// Don't store redundant information
	// Register, Login, Display information - Work piece-wise, test that it absolutely works before moving on to the next feature
	import mx.rpc.remoting.RemoteObject;
	import spark.components.Application;
	import services.Server;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import mx.controls.Button;
	import flash.text.TextFieldType;
	import mx.core.UIComponent;
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
		
		// When the login button is clicked by the user, this happens.
		public function loginButtonClicked(e:MouseEvent):void
		{
			trace("Login button clicked!");
			Server.instance.initialize(remoteObject);
			Server.instance.call("login", onLoginComplete, "user", "pass");
			trace("Server successfully contacted!");
		}
		
		// When the register button is clicked by the user, this happens.
		// A small window should pop up into which the user should enter the following data:
		// password, password confirmation, summoner ID (this will be the username), college email, college email confirmation.
		// Implement some kind of registration verification which is automatically sent to email.
		public function registerButtonClicked(e:MouseEvent):void
		{
			trace("Register button clicked!");
			Server.instance.initialize(remoteObject);
			Server.instance.call("login", onLoginComplete, "user", "pass");
			trace("Server successfully contacted!");
		}		
		
		public function initDone():void {
			// container ( IVisualElement ) for DisplayObjects
			var container:UIComponent = new UIComponent();
			var container2:UIComponent = new UIComponent();
			var container3:UIComponent = new UIComponent();
			addElement( container );

			// displayObject goes to container
			var myScene:Sprite = new Sprite();
			var myScene2:Sprite = new Sprite();
			var myScene3:Sprite = new Sprite();
			//Login Button
			var loginButton:Button = new Button();
			addElement(loginButton);
			loginButton.x = 250;
			loginButton.y = 275;
			loginButton.height = 20;
			loginButton.width = 60;
			loginButton.label = "Login!";
			//loginButton.name = "Login!";
			loginButton.alpha = .5;
			loginButton.addEventListener(MouseEvent.CLICK, loginButtonClicked, false, 0, true);

			//Login Button
			var registerButton:Button = new Button();
			addElement(registerButton);
			registerButton.x = 320;
			registerButton.y = 275;
			registerButton.height = 20;
			registerButton.width = 125;
			registerButton.label = "Register here!";
			//loginButton.name = "Login!";
			registerButton.alpha = .5;
			registerButton.addEventListener(MouseEvent.CLICK, registerButtonClicked, false, 0, true);
			
			//Username
			var usernameTextField:TextField = new TextField();
			usernameTextField.type = TextFieldType.INPUT;
			usernameTextField.border = true;
			usernameTextField.x = 250;
			usernameTextField.y = 220;
			usernameTextField.wordWrap = true;
			usernameTextField.multiline = false;
			usernameTextField.maxChars = 16;
			usernameTextField.width = 125;
			usernameTextField.height = 20;
			usernameTextField.text = "Enter your username here.";
			usernameTextField.name = "Username";
			myScene2.addChild(usernameTextField);
			
			//Password
			var passwordTextField:TextField = new TextField();
			passwordTextField.type = TextFieldType.INPUT;
			passwordTextField.border = true;
			passwordTextField.x = 250;
			passwordTextField.y = 250;
			passwordTextField.wordWrap = true;
			//Change displayAsPassword back to true when launching (*'s out the PW).
			passwordTextField.displayAsPassword = false;
			passwordTextField.multiline = false;
			passwordTextField.maxChars = 16;
			passwordTextField.width = 125;
			passwordTextField.height = 20;
			passwordTextField.text = "Enter your password."
			myScene3.addChild(passwordTextField);
			
			container.addChild( myScene );
			container2.addChild( myScene2 );
			container3.addChild( myScene3 );
			this.addElement(container);
			this.addElement(container2);
			this.addElement(container3);
			// Call to login function to check if the program is communicating with the server
			// and the Java files.
		}
		private function onLoginComplete(result:Object):void {
			trace(result);
		}
		
	}

}