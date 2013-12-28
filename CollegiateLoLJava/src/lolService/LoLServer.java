package lolService;

import java.beans.Statement;
import java.sql.ResultSet;

public class LoLServer implements LoLService {
	
//Step 1: Login
public boolean login(String user, String pass) {
    try{
        //query to see if this name is already registered
    	// Eventually apply an MD5 hash
        String testQuery = "SELECT * FROM " + mydb.users + " WHERE SummonerName = \'" + user + "\' AND password = (\'" + pass + "\');";

        System.out.println("Testing if username and password are correct: " + testQuery);

        ResultSet rs = DatabaseService.instance.executeResultQuery(testQuery);

        if(rs.first()){
            //something was returned, login successful
            return true;
        }

        //return false otherwise, login was unsuccessful
        return false;

    }
    catch(Exception e){
        e.printStackTrace();
        return false;
    }
}
    /*
    * THIS SECTION OF CODE IMPLEMENTS THE SERVICE METHODS
    * DEFINED IN THE INTERFACE KRGService
    * */

    //adds a new registered user to the database
    //returns true iff the registration is successful
    public boolean registerUser( String username, String password ) {

        try{
            //query to see if this name is already registered
            String testQuery = "SELECT * FROM " + mydb.users + " WHERE username = \'" + username + "\';";

            System.out.println("Testing if username exists: " + testQuery);

            ResultSet rs = DatabaseService.instance.executeResultQuery(testQuery);

            if(rs.first()){
                //somebody already has that name
                return false;
            }

            //else we insert the new user and return whether or not the insertion was successful
            String registerQuery = "INSERT INTO " + mydb.users + " (username, password) VALUES (\'" + username + "\', MD5(\'" + password + "\'));";

            System.out.println("Running query: " + registerQuery);

            boolean result = DatabaseService.instance.execute(registerQuery);

            //enter a default score of 0
            String initScoreQuery = "INSERT INTO " + DBTables.SCORES + " (userId, score) values ((SELECT id FROM users u WHERE u.username = \"" + username +  "\"), 0);";

            boolean result2 = DatabaseService.instance.execute(initScoreQuery);

            //return true iff both queries are successful
            return result && result2;

        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

public boolean register() {
	return true;
}
}