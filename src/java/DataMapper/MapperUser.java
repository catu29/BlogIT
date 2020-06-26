/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOUser;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperUser extends MapperBase {
    public MapperUser () {
        super();
    }
    
    /***
     * Check if login info is correct or not
     * @param email
     * @param password
     * @return - true if login succeed.
     *         - false if there is no such login info
     */
    public boolean login (String email, String password) {
        try {
            String query = "Select * From User Where 'email' = ? and 'password' = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            if (stmt.executeUpdate(query) == 1) {
                stmt.close();
                return true;
            } else {
                stmt.close();
                return false;
            }
        } catch (Exception e) {
            System.out.println("Login connect db error: " + e.getMessage());
            
            return false;
        }
    }
    
    /***
     * Check whether a particular user email having been existing.
     * @param email - the email want to check
     * @return - true if exist
     *         - false if nothing found
     */
    public boolean isExisting (String email) {
        try {
            String query = "Select * From User Where 'email' = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, email);
            
            if (stmt.executeUpdate(query) > 0) {
                stmt.close();
                return true;
            } else {
                stmt.close();
                return false;
            }
        } catch (Exception e) {
            System.out.println("Login connect db error: " + e.getMessage());
            
            return false;
        }
    }
        
    public boolean insertNewUser(DTOUser newUser) {
        boolean result = false;
        
        try {
            String query = "Insert Into User (password, email, fullName, avatar, role) Values(?, ?, ?, ?, ?, ?);";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, newUser.getPassword());
            stmt.setString(2, newUser.getEmail());
            stmt.setString(3, newUser.getFullName());
            stmt.setString(4, newUser.getAvatar());
            stmt.setInt(5, newUser.getRole());
            
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Insert new user error: " + e.getMessage());
        }        
    
        return result;
    }
    
    /***
     * Update a particular user info by specific condition
     * @param user - the one want to update
     * @param column - the field need update
     * @param condition - the value of field need update
     * @return 
     */
    public boolean updateUserByCondition(DTOUser user, String column, String condition) {
        boolean result = false;
        
        try {
            String query = "Update User Set ? = ? Where userId = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, column);
            stmt.setString(2, condition);
            stmt.setInt(3, user.getUserId());
            
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean deleteUser(DTOUser user) {
        boolean result = false;
        
        try {
            String query = "Delete From User Where userId = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setInt(1, user.getUserId());
            
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Delete user error: " + e.getMessage());
        }        
    
        return result;
    }
    
    public ArrayList<DTOUser> getAllUsers() {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            String query = "Select * From User;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Select all users error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOUser> searchUser(String column, String condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            String query = "Select * From User Where ? like '%?%';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, column);
            stmt.setString(2, condition);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOUser> searchUser(String column, int condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            String query = "Select * From User Where ? = ?;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            stmt.setString(1, column);
            stmt.setInt(2, condition);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users error: " + e.getMessage());
            
            return null;
        }
    }
    public ArrayList<DTOUser> searchUser(String condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            StringBuffer query = new StringBuffer("Select * From User Where ");
            query.append("'email' like '%");
            query.append(condition);
            query.append("%' or 'fullName' like '%");
            query.append(condition);
            
            query.append("%';");

            PreparedStatement stmt = connection.prepareStatement(query.toString());
                                    
            ResultSet rs = stmt.executeQuery(query.toString());
            
            stmt.close();
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getInt("role"));
                result.add(user);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users error: " + e.getMessage());
            
            return null;
        }
    }
    
}
