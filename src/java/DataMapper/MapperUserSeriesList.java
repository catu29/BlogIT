/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOUserSeriesList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperUserSeriesList extends MapperBase {
    public MapperUserSeriesList() {
        super();
    }
    
    /***
     * Get all series lists of all users
     * @return - ArrayList of UserSeriesList if have data.
     *         - null if nothing found.
     */
    public ArrayList<DTOUserSeriesList> getAllLists() {
        try {
            ArrayList<DTOUserSeriesList> result = new ArrayList();
            
            String query = "Select * From UserSeriesList;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOUserSeriesList list = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));
                result.add(list);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all series lists error: " + e.getMessage());
            
            return null;
        }
    }
    
    /***
     * Get all of series lists of a particular user
     * @param userId - int, the particular Id of user want to search
     * @return - ArrayList of UserSeriesList if have data.
     *         - null if nothing found.
     */
    public ArrayList<DTOUserSeriesList> getAllLists(int userId) {
        try {
            ArrayList<DTOUserSeriesList> result = new ArrayList();
            
            String query = "Select * From UserSeriesList Where 'userId' = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOUserSeriesList list = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));
                result.add(list);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all series lists error: " + e.getMessage());
            
            return null;
        }
    }
    
    /***
     * Create new series list of a particular user and insert it into db
     * @param list - DTOUserSeriesList, list data which wanted to be inserted
     * @return - true - if insert succeed.
     *         - false - if insert fail
     */
    public boolean insertNewUserSeriesList(DTOUserSeriesList list) {
        try {
            String query = "Insert Into UserSeriesList(userId, seriesName, seriesNameUnsigned) values (?, ?, ?);";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setInt(1, list.getUserId());
            stmt.setString(2, list.getSeriesName());
            stmt.setString(3, list.getSeriesNameUnsigned());
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert New user series list error: " + e.getMessage());
            
            return false;
        }
    }
    
    /***
     * Remove a series list from db
     * @param list - DTOUserSeriesList, list data which wanted to be removed
     * @return - true - if remove succeed.
     *         - false - if remove fail
     */
    public boolean deleteUserSeriesList(DTOUserSeriesList list) {
        try {
            String query = "Delete From UserSeriesList Where 'seriesId' = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setInt(1, list.getSeriesId());
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete user series list error: " + e.getMessage());
            
            return false;
        }
    }
    
    /***
     * Update a series list information by a particular condition
     * @param list - particular list which need to be updated
     * @param column - which field you want to update
     * @param condition - which information will be updated into column
     * @return 
     */
    public boolean updateUserSeriesByCondition(DTOUserSeriesList list, String column, String condition) {
        try {
            String query = "Update UserSeriesList Set ? = ? Where 'seriesId' = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, column);
            stmt.setString(2, condition);
            stmt.setInt(3, list.getSeriesId());
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update user series list error: " + e.getMessage());
            
            return false;
        }
    }
    
    /***
     * Search all series lists match condition
     * @param condition - which info will be searched
     * @return - An ArrayList of user series if have result
     *         - null if nothing found
     */
    public ArrayList<DTOUserSeriesList> searchSeriesList(String condition) {
        try {
            ArrayList<DTOUserSeriesList> result = new ArrayList();
            
            StringBuffer query = new StringBuffer("Select * From UserSeriesList Inner Join User on UserSeriesList.userId = User.userId ");
            query.append("Where 'UserSeriesList.seriesName' = ? or 'UserSeriesList.seriesNameUnsigned' = ? ");
            query.append("or 'UserSeriesList.seriesName' like '%?%' or 'UserSeriesList.seriesNameUnsigned' like '%?%' ");
            query.append("or 'User.fullName' like '%?%' or 'User.email' like '%?%';");
            
            PreparedStatement stmt = connection.prepareStatement(query.toString());
            
            stmt.setString(1, condition);
            stmt.setString(2, condition);
            stmt.setString(3, condition);
            stmt.setString(4, condition);
            stmt.setString(5, condition);
            stmt.setString(6, condition);
            
            ResultSet rs = stmt.executeQuery(query.toString());
            
            while(rs.next()) {
                DTOUserSeriesList list = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));
                result.add(list);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Search user series list error: " + e.getMessage());
            
            return null;
        }
    }
}
