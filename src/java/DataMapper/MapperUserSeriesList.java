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
    
    public DTOUserSeriesList getSeriesInformation(int seriesId) {
        try {
            String query = "Select * from UserSeriesList where seriesId = " + seriesId;
            System.out.println(query);
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
                        
            rs.next();
                
            DTOUserSeriesList seriesDTO = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));

            return seriesDTO;
        } catch (Exception e) {
            System.out.println("Get series list information error: " + e.getMessage());
            return null;
        }
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
    public ArrayList<DTOUserSeriesList> getUserLists(int userId) {
        try {
            ArrayList<DTOUserSeriesList> result = new ArrayList();
            
            String query = "Select * From UserSeriesList Where userId = " + userId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOUserSeriesList list = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));
                result.add(list);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all series lists by userId error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOUserSeriesList getLatestUserSeries(int userId) {
        try {
            String query = "Select * from UserSeriesList Where userId = " + userId + " Order by seriesId DESC Limit 1";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            rs.next();
                
            DTOUserSeriesList seriesDTO = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));

            return seriesDTO;
        } catch (Exception e) {
            System.out.println("Get latest series list information error: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<DTOUserSeriesList> getTopRandomList(int number) {
        try {
            ArrayList<DTOUserSeriesList> result = new ArrayList();
            String query = "Select * from UserSeriesList inner join " +
                           "(Select seriesId from UserSeriesList order by rand() limit " + number + ") as subList " +
                           "on UserSeriesList.seriesId = subList.seriesId";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOUserSeriesList list = new DTOUserSeriesList(rs.getInt("seriesId"), rs.getInt("userId"), rs.getString("seriesName"), rs.getString("seriesNameUnsigned"));
                result.add(list);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get top random series list error: " + e.getMessage());
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
            String seriesNameUnsigned = convertToUnsigned(list.getSeriesName().trim());
            
            String query = "Insert Into UserSeriesList(userId, seriesName, seriesNameUnsigned) values ("
                    + list.getUserId() + ", N'"
                    + list.getSeriesName().trim() + "', '"
                    + seriesNameUnsigned + "');";
            
            PreparedStatement stmt = connection.prepareStatement(query);
            
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
    public boolean deleteUserSeriesList(int seriesId) {
        try {
            String query = "Delete From UserSeriesList Where seriesId = " + seriesId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete user series list error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean updateUserSeriesListName(DTOUserSeriesList list) {
        try {
            String nameUnsigned = convertToUnsigned(list.getSeriesName());
            String query = "Update UserSeriesList Set "
                         + "seriesName = N'" + list.getSeriesName() + "', "
                         + "seriesNameUnsigned = '" + nameUnsigned + "' "
                         + "where seriesId = " + list.getSeriesId();
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update user series list name error: " + e.getMessage());
            
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
            String query = "Update UserSeriesList Set " + column + " = N'" + condition 
                         + "' Where seriesId = " + list.getSeriesId();
            PreparedStatement stmt = connection.prepareStatement(query);
            
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
            query.append("Where UserSeriesList.seriesName = '");
            query.append(condition);
            query.append("' or UserSeriesList.seriesNameUnsigned = '");
            query.append(condition);
            query.append("' or UserSeriesList.seriesName like '%");
            query.append(condition);
            query.append("%' or UserSeriesList.seriesNameUnsigned like '%");
            query.append(condition);
            query.append("%' or User.fullName like '%");
            query.append(condition);
            query.append("%' or User.email like '%");
            query.append(condition);
            query.append("%';");
            
            PreparedStatement stmt = connection.prepareStatement(query.toString());
            
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
