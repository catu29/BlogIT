/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPostLike;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperPostLike extends MapperBase {
    public MapperPostLike() {
        super();
    }
    
    public ArrayList<DTOPostLike> getAllLikes() {
        try {
            ArrayList<DTOPostLike> result = new ArrayList();
            
            String query = "Select * From PostLike;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOPostLike like = new DTOPostLike(rs.getInt("postId"), rs.getInt("userId"), rs.getDate("likeTime"));
                result.add(like);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all likes error: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<DTOPostLike> getAllLikesOfPost(int postId) {
        try {
            ArrayList<DTOPostLike> result = new ArrayList();
            
            String query = "Select * From PostLike Where postId = " + postId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOPostLike like = new DTOPostLike(rs.getInt("postId"), rs.getInt("userId"), rs.getDate("likeTime"));
                result.add(like);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all likes of post error: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<DTOPostLike> getAllLikesOfUser(int userId) {
        try {
            ArrayList<DTOPostLike> result = new ArrayList();
            
            String query = "Select * From PostLike Where userId = " + userId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOPostLike like = new DTOPostLike(rs.getInt("postId"), rs.getInt("userId"), rs.getDate("likeTime"));
                result.add(like);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all likes of user error: " + e.getMessage());
            return null;
        }
    }
    
    public boolean isLiked(int postId, int userId) {
        try {
            String query = "Select * From PostLike where postId = " + postId + " and userId = " + userId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            return rs.next();
        } catch (Exception e) {
            System.out.println("Check isLiked error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean insertNewLike(DTOPostLike like) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); 
            
            String query = "Insert into PostLike values ("
                           + like.getPostId() + ", "
                           + like.getUserId() + ", '" 
                           + formatter.format(like.getLikeTime()) + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new like error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteLike(int postId, int userId) {
        try {
            String query = "Delete from PostLike where postId = " + postId + " and userId = " + userId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete like error: " + e.getMessage());
            return false;
        }
    }
}
