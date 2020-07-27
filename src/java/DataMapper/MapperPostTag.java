/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPost;
import DTO.DTOTagList;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

/**
 *
 * @author TranCamTu
 */
public class MapperPostTag extends MapperBase {
    public boolean addTagForPost(int postId, String tagId) {
        try {
            String query = "Insert Into PostTag Values(" + postId + ", '" + tagId + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Add tag for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean addTagForPost(int postId, String[] tags) {
        try {
            //String query = "Insert Into PostTag Values";
            StringBuffer query = new StringBuffer("Insert Into PostTag Values");
            for (String tag: tags) {
                query.append("(").append(postId).append(", '").append(tag).append("'),");
            }
            
            query.substring(query.lastIndexOf(","));
            query.append(";");
            PreparedStatement stmt = connection.prepareStatement(query.toString());
            
            return stmt.executeUpdate(query.toString()) > 0;
        } catch (Exception e) {
            System.out.println("Add tag for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean updateTagForPost(int postId, String oldTagId, String newTagId) {
        try {
            String query = "Update PostTag Set tagId = '" + newTagId 
                            + "' Where postId = " + postId + " and tagId = '" + oldTagId + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
                        
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update tag for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteTagForPost(int postId, String tagId) {
        try {
            String query = "Delete From PostTag Where tagId = '" + tagId + "' and postId = " + postId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete tag for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteTagForPost(int postId) {
        try {
            String query = "Delete From PostTag Where postId = " + postId;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete all tag for post error: " + e.getMessage());
            
            return false;
        }
    }
    
    public ArrayList<DTOTagList> getAllTagsForPost(int postId) {
        try {
            ArrayList<DTOTagList> result = new ArrayList();
            
            String query = "select TagList.tagId, TagList.tagName from "
                    + "TagList inner join PostTag On TagList.tagId = PostTag.tagId "
                    + "Where PostTag.postId = " + postId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOTagList list = new DTOTagList(rs.getString("tagId"), rs.getString("tagName"));
                result.add(list);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all tags for post error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPostsForTag(String tagId) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "select Post.postId, postTitle, postTitleUnsigned, postSubTitle, postTime, userId, seriesId, seriesOrder, image, postContent"
                    + " from Post inner join PostTag On Post.postId = PostTag.postId "
                    + "Where PostTag.tagId = '" + tagId + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                DTOPost post = new DTOPost();
                
                post.setPostId(rs.getInt("postId"));
                post.setPostTitle(rs.getString("postTitle"));
                post.setPostTitleUnsigned(rs.getString("postTitleUnsigned"));
                post.setPostSubTitle(rs.getString("postSubTitle"));
                post.setPostTime(rs.getDate("postTime"));
                post.setUserId(rs.getInt("userId"));
                post.setSeriesId(rs.getInt("seriesId"));
                post.setSeriesOrder(rs.getInt("seriesOrder"));
                post.setImage(rs.getString("image"));
                post.setPostContent(rs.getString("postContent"));
                
                result.add(post);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all posts for tag error: " + e.getMessage());
            
            return null;
        }
    }
}
