/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DataAccess.MySqlConnection;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author TranCamTu
 */
public class MapperBase {
    protected Connection connection = null;
    
    public MapperBase () {
        connection = getConnection();
    }
    
    protected Connection getConnection() {
        if (connection == null) {
            connection = MySqlConnection.getDataConnection();
        }
        
        return connection;
    }
    
    protected void closeConnection() throws SQLException {
        if (!connection.isClosed()) {
            connection.close();
        }
    }
}
