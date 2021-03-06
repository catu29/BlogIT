/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DataAccess.MySqlConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;

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
    
    protected String convertToUnsigned(String src) {        
        String dest = Normalizer.normalize(src, Normalizer.Form.NFD);
        dest = dest.replaceAll("[^\\p{ASCII}]", "").toLowerCase();
        
        String splits[] = dest.split(" ");
        ArrayList<String> result = new ArrayList();
        
        for(int i = 0; i < splits.length; i++) {
            splits[i].trim();
            
            if (!splits[i].isEmpty()) {
                result.add(splits[i]);
            }
        }
        
        return String.join("-", result);
    }
}
