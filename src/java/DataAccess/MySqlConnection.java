
package DataAccess;

import java.sql.Connection;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MySqlConnection {
    public static DataSource dataSource = null;
    public static Connection dataConnection = null;
    
    public static DataSource getDataSource() {
        if (dataSource == null) {
            try {          
                InitialContext initContext = new InitialContext();
                dataSource = (DataSource)initContext.lookup("java:comp/env/jdbc/MySqlDatabase");
            } catch (Exception e) {
                System.out.println("Get Data Source Error: " + e.getMessage());
            }
        }
        
        return dataSource;
    }
    
    public static Connection getDataConnection() {
        if (dataConnection == null) {
            try {            
                if (dataSource == null) {
                    getDataSource();
                }

                    dataConnection = dataSource.getConnection();
            } catch (Exception e) {
                System.out.println("Get Data Connection Error: " + e.getMessage());
            }
        }
        
        return dataConnection;
    }
    
    public static void closeDataConnection() {
        try {
            if (dataConnection != null) {
                if (!dataConnection.isClosed()) {
                    dataConnection.close();
                }
                
                dataConnection = null;
            }
        } catch (Exception e) {
            System.out.println("Close Connection Error: " + e.getMessage());
        }
    }
}
