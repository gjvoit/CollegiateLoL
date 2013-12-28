package lolService;
import java.sql.*;

/**
 * 
 * User: Garet Voit
 * Date: Dec 28, 2013
 * Time: 2:43:49 AM
 * To change this template use File | Settings | File Templates.
 */
public class DatabaseService {

    //Singleton class, so this is the instance
    public static DatabaseService instance = new DatabaseService();

    private Connection conn = null;

    private String url = "jdbc:mysql://localhost:3306";

    private String dbName = "mydb";

    private String driver = "com.mysql.jdbc.Driver";

    private String userName = "root";

    private String password = "";


    public DatabaseService(){

        if(instance != null){
            System.out.println("ERROR: cannot reinitialize singleton class DatabaseService");
        }
    }


    public ResultSet executeResultQuery(String queryString){

        try{

            openDBConnection();

            Statement statement = conn.createStatement();

            ResultSet rs = statement.executeQuery(queryString);

            //closeDBConnection();

            return rs;

        }
        catch(Exception e){
            
            e.printStackTrace();

            return null;
        }
    }

    public boolean execute(String queryString){

        try{

            openDBConnection();

            Statement statement = conn.createStatement();

            boolean rs = statement.execute(queryString);

            //closeDBConnection();

            return true;

        }
        catch(Exception e){

            e.printStackTrace();

            return false;
        }
    }


    private Connection openDBConnection() throws Exception{

        //if we already have a connection then return it
        if(conn != null)
            return conn;
        else{


            Class.forName(driver).newInstance();

            conn = DriverManager.getConnection(url+dbName,userName,password);

            System.out.println("Connected to the database");

            return conn;
        }

    }

    private void closeDBConnection() throws Exception{

        if(conn != null){
            conn.close();
            conn = null;
    
            System.out.println("Disconnected from database");
        }
    }
}
