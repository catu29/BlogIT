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
            String query = "Select * From User Where email = '" + email + "' and password = '" + password + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            return rs.next();
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
            String query = "Select * From User Where email = '" + email + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return true;
            }
            
            return false;
        } catch (Exception e) {
            System.out.println("Check is existing user error: " + e.getMessage());
            
            return false;
        }
    }
        
    public boolean insertNewUser(DTOUser newUser) {
        boolean result = false;
        
        try {            
            String query = "Insert Into User (password, email, fullName, avatar, bio, role) Values ('"
                    + newUser.getPassword() + "', '"
                    + newUser.getEmail() + "', N'"
                    + newUser.getFullname() + "', '"
                    + newUser.getAvatar() + "', N'"
                    + newUser.getBio() + "', "
                    + newUser.getRole() + ")";
            
            PreparedStatement stmt = connection.prepareStatement(query);            
            
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
     * @param email - the value of email need update
     * @return 
     */
    public boolean updateUserEmail(DTOUser user, String email) {
        boolean result = false;      
        
        try {
            String query = "Update User Set email = '" + email + "' Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user email error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserPassword(DTOUser user, String password) {
        boolean result = false;      
        
        try {
            String query = "Update User Set password = '" + password + "' Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user password error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserFullName(DTOUser user, String fullname) {
        boolean result = false;      
        
        try {
            String query = "Update User Set fullName = N'" + fullname + "' Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user full name error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserAvatar(DTOUser user, String avatar) {
        boolean result = false;      
        
        try {
            String query = "Update User Set avatar = '" + avatar + "' Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user avatar error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserBio(DTOUser user, String bio) {
        boolean result = false;      
        
        try {
            String query = "Update User Set bio = N'" + bio + "' Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user avatar error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserRole(DTOUser user, int role) {
        boolean result = false;      
        
        try {
            String query = "Update User Set role = " + role + " Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            result = stmt.executeUpdate(query) > 0;
            
            stmt.close();
        } catch (Exception e) {
            result = false;
            
            System.out.println("Update user role error: " + e.getMessage());
        }
        
        return result;
    }
    
    public boolean updateUserInfo(DTOUser user) {
        try {
            String query = "Update User Set "
                    + "fullname = N'" + user.getFullname() + "', "
                    + "avatar = '" + user.getAvatar() + "', "
                    + "bio = N'" + user.getBio() + "', "
                    + "password = '" + user.getPassword() + "' "
                    + "where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
        
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update user infor error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteUser(DTOUser user) {
        boolean result = false;
        
        try {
            String query = "Delete From User Where userId = " + user.getUserId();
            PreparedStatement stmt = connection.prepareStatement(query);
                        
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
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Select all users error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOUser getUserInformation(String email) {
        try {           
            String query = "Select * From User Where email = '" + email + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            rs.next();
            DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
            
            stmt.close();
            
            return user;
        } catch (Exception e) {
            System.out.println("Get users info by email error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOUser getUserInformation(int id) {
        try {           
            String query = "Select * From User Where userId = " + id;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            rs.next();
            DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
            
            stmt.close();
            
            return user;
        } catch (Exception e) {
            System.out.println("Get users info by id error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOUser getUserInformation(int id, String name) {
        try {           
            String query = "Select * From User Where userId = " + id + " and fullname = '" + name + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            rs.next();
            DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
            
            stmt.close();
            
            return user;
        } catch (Exception e) {
            System.out.println("Get users info by id and name error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOUser> searchUser(String column, String condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            String query = "Select * From User Where " + column + " like '%" + condition + "%';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users by particular string column error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOUser> searchUser(String column, int condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            String query = "Select * From User Where " + column + " = " + condition + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"), rs.getString("bio"), rs.getInt("role"));
                result.add(user);
            }
            
            stmt.close();
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users by particular int column error: " + e.getMessage());
            
            return null;
        }
    }
    public ArrayList<DTOUser> searchUser(String condition) {
        try {
            ArrayList<DTOUser> result = new ArrayList<DTOUser>();
                        
            StringBuffer query = new StringBuffer("Select * From User Where ");
            query.append("email like '%");
            query.append(condition);
            query.append("%' or fullName like '%");
            query.append(condition);            
            query.append("%';");

            PreparedStatement stmt = connection.prepareStatement(query.toString());
                                    
            ResultSet rs = stmt.executeQuery(query.toString());
            
            stmt.close();
            
            while (rs.next()) {
                DTOUser user = new DTOUser(rs.getInt("userId"), rs.getString("password"), rs.getString("email"), rs.getString("fullName"), rs.getString("avatar"),rs.getString("bio"), rs.getInt("role"));
                result.add(user);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Search users by any condition error: " + e.getMessage());
            
            return null;
        }
    }
    
}
