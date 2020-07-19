/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPostComment;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

/**
 *
 * @author TranCamTu
 */
public class MapperPostComment extends MapperBase {
    public MapperPostComment() {
        super();
    }
    
    public ArrayList<DTOPostComment> getAllCommentsForPost(int postId) {
        try {
            ArrayList<DTOPostComment> result = new ArrayList();
            
            String query = "Select * from PostComment where postId = " + postId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOPostComment comment = new DTOPostComment();
                                
                comment.setCommentId(rs.getInt("commentId"));
                comment.setPostId(rs.getInt("postId"));
                comment.setUserId(rs.getInt("userId"));
                comment.setContent(rs.getString("content"));
                comment.setParentId(rs.getInt("parentId"));
                comment.setCommentTime(rs.getDate("commentTime"));
                
                result.add(comment);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all post comments for post error: " + e.getMessage());
            
            return null;
        }
    }
    
    public boolean insertCommentForPost(DTOPostComment comment) {
        try {
            String query = "Insert into PostComment (userId, postId, content, commentTime, parentId) values ("
                           + comment.getUserId() + ", " 
                           + comment.getPostId() + ", N'" 
                           + comment.getContent() + "', '"
                           + comment.getCommentTime() + "', "
                           + comment.getParentId() + ");";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new comment for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean updateCommentForPost(DTOPostComment comment) {
        try {
            
            String query = "Update PostComment Set "
                         + "content = N'" + comment.getContent() + "', "
                         + "commentTime = " + comment.getCommentTime()
                         + " Where commentId = " + comment.getCommentId() + ";";
            
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update Comment error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteCommentForPost(DTOPostComment comment) {
        try {            
            String query = "Delete From PostComment Where commentId = " + comment.getCommentId() + ";";
            
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update Comment error: " + e.getMessage());
            
            return false;
        }
    }
}