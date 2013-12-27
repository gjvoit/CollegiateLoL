package lolService;

// Every time you update the server code, you must compile and update the files in the server folder
// "C:\Users\Garet\Downloads\blazeds-turnkey-4.0.0.14931\blazeds-turnkey-4.0.0.14931\tomcat\webapps\samples\WEB-INF\classes"
// Ensure to copy over the .class files (compiled files) not just the .java files

public class LoLService {

	//List of functions that can be called directly from the server
	
	//Step 1: Login
	public boolean login(String user, String pass) {
		//If user is found in database with password "pass", return true, else return false
		//Put a print statement into the login, which will show in the console
		return true;
	}
}