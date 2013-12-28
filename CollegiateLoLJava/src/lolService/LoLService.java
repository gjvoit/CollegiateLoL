package lolService;
import java.sql.*;


// Every time you update the server code, you must compile and update the files in the server folder
// "C:\Users\Garet\Downloads\blazeds-turnkey-4.0.0.14931\blazeds-turnkey-4.0.0.14931\tomcat\webapps\samples\WEB-INF\classes"
// Ensure to copy over the .class files (compiled files) not just the .java files

public interface LoLService {

	//List of functions that can be called directly from the server
	
	//Step 1: Login
	public boolean login(String user, String pass);
	
	/*{
		ResultSet search_rs;
		Statement stmt = conn.createStatement();
		search_rs = stmt.executeQuery("SELECT * FROM users WHERE SummonerName = user and Password = pass");
		return true;
	}
	*/
	public boolean register();
	
}