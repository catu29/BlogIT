
package Data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MySqlConnection {
    public static DataSource dataSource = null;
    public static Connection dataConnection = null;
    
    private void getDataSource() {
        try {          
            InitialContext initContext = new InitialContext();
            dataSource = (DataSource)initContext.lookup("java:comp/env/jdbc/MySqlDatabase");
        } catch (Exception e) {
            System.out.println("Get Data Source Error: " + e.getMessage());
        }
    }
    
    public void getDataConnection() {
        try {
            if (dataConnection == null) {
                if (dataSource == null) {
                    getDataSource();
                }
                
                dataConnection = dataSource.getConnection();
            }
        } catch (Exception e) {
            System.out.println("Get Data Connection Error: " + e.getMessage());
        }
    }
    
    public void closeDataConnection() {
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
