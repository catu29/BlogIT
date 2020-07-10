/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPost;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author TranCamTu
 */
public class MapperPost extends MapperBase {
    public MapperPost() {
        super();
    }
    
    public ArrayList<DTOPost> getAllPosts() {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOPost post = new DTOPost();
                
                Date postDate = rs.getDate("postTime");
                Calendar postCalendar = Calendar.getInstance();
                postCalendar.setTime(postDate);
                
                post.setPostId(rs.getInt("postId"));
                post.setPostTitle(rs.getString("postTitle"));
                post.setPostTitleUnsigned(rs.getString("postTitleUnsigned"));
                post.setPostTime(postCalendar);
                post.setUserId(rs.getInt("userId"));
                post.setSeriesId(rs.getInt("seriesId"));
                post.setPostContent(rs.getString("postContent"));
                
                result.add(post);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all posts error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPostsOfUser(int userId) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where userId = " + userId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOPost post = new DTOPost();
                
                Date postDate = rs.getDate("postTime");
                Calendar postCalendar = Calendar.getInstance();
                postCalendar.setTime(postDate);
                
                post.setPostId(rs.getInt("postId"));
                post.setPostTitle(rs.getString("postTitle"));
                post.setPostTitleUnsigned(rs.getString("postTitleUnsigned"));
                post.setPostTime(postCalendar);
                post.setUserId(rs.getInt("userId"));
                post.setSeriesId(rs.getInt("seriesId"));
                post.setPostContent(rs.getString("postContent"));
                
                result.add(post);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all posts of user error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPostsOfSeries(int seriesId) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where seriesId = " + seriesId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOPost post = new DTOPost();
                
                Date postDate = rs.getDate("postTime");
                Calendar postCalendar = Calendar.getInstance();
                postCalendar.setTime(postDate);
                
                post.setPostId(rs.getInt("postId"));
                post.setPostTitle(rs.getString("postTitle"));
                post.setPostTitleUnsigned(rs.getString("postTitleUnsigned"));
                post.setPostTime(postCalendar);
                post.setUserId(rs.getInt("userId"));
                post.setSeriesId(rs.getInt("seriesId"));
                post.setPostContent(rs.getString("postContent"));
                
                result.add(post);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all posts of series error: " + e.getMessage());
            
            return null;
        }
    }
    
    public boolean insertNewPost(DTOPost post) {
        try {
            Calendar postCalendar = post.getPostTime();
            Date postDate = postCalendar.getTime();
            
            String query = "Insert into Post (postTitle, postTitleUnsigned, postTime, userId, seriesId, postContent) values (N'"
                         + post.getPostTitle() + "', '"
                         + post.getPostTitleUnsigned() + "', '"
                         + postDate + "', "
                         + post.getUserId() + ", "
                         + post.getSeriesId() + "', N'"
                         + post.getPostContent() + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new post error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePost(DTOPost post) {
        try {
            Calendar postCalendar = post.getPostTime();
            Date postDate = postCalendar.getTime();
            
            String query = "Update Post Set "
                         + "postTitle = N'" + post.getPostTitle() + "', "
                         + "postTitleUnsigned = '" + post.getPostTitleUnsigned() + "', "
                         + "postContent = N'" + post.getPostContent() + "', "
                         + "postTime = '" + postDate + "' "
                         + "seriesId = " + post.getSeriesId()
                         + " where postId = " + post.getPostId() + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update post error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deletePost(int postId) {
        try {
            String query = "Delete From Post where postId = " + postId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete post error: " + e.getMessage());
            return false;
        }
    }
}
