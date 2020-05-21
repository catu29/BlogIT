
package DatabaseConnection;

import java.sql.Connection;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MySqlConnection {
    private static DataSource dataSource = null;
    private static Connection dataConnection = null;
    
    private static void getDataSource() {
        try {  
            if (dataSource == null) {
                InitialContext initContext = new InitialContext();
                dataSource = (DataSource)initContext.lookup("java:comp/env/jdbc/MySqlDatabase");
            }
        } catch (Exception e) {
            System.out.println("Get Data Source Error: " + e.getMessage());
        }
    }
    
    public static Connection getDataConnection() {
        try {
            if (dataConnection == null) {
                getDataSource();
                dataConnection = dataSource.getConnection();
            }
        } catch (Exception e) {
            System.out.println("Get Data Connection Error: " + e.getMessage());
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
