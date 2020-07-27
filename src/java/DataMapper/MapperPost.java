/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPost;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperPost extends MapperBase {
    public MapperPost() {
        super();
    }
    
    public DTOPost getPostInformation(int postId) {
        try {
            String query = "Select * from Post where postId = " + postId + " order by postTime desc;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            
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
            
            return post;
        } catch (Exception e) {
            System.out.println("Get post information by id error: " + e.getMessage());
            return null;
        }
    }
    
    public DTOPost getLatestUserPostInformation(int userId) {
        try {
            String query = "Select * from Post where userId = " + userId + " order by postId desc Limit 1;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            
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
            
            return post;
        } catch (Exception e) {
            System.out.println("Get latest post information by user id error: " + e.getMessage());
            return null;
        }
    }
    
    public DTOPost getPostInformation(int postId, String titleUnsigned) {
        try {
            String query = "Select * from Post where postId = " + postId + " and postTitleUnsigned = '" + titleUnsigned + "' order by postTime desc;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            
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
            
            return post;
        } catch (Exception e) {
            System.out.println("Get post information by id and title error: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPosts() {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post order by postTime desc;";
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
            System.out.println("Get all posts error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPostsOfUser(int userId) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where userId = " + userId + " order by postTime desc;";
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
            System.out.println("Get all posts of user error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getPostsOfUser(int userId, int amount) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where userId = " + userId + " order by postTime desc Limit " + amount;
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
            System.out.println("Get n posts of user error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getAllPostsOfSeries(int seriesId) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where seriesId = " + seriesId + " order by seriesOrder asc;";
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
            System.out.println("Get all posts of series error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getTopPostsOfSeries(int seriesId, int number) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post where seriesId = " + seriesId + " order by seriesOrder asc limit " + number;
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
            System.out.println("Get all posts of series error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOPost> getTopLikePosts(int number) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "select post.postId, postTitle, postTitleUnsigned, " +
                            "postSubTitle, postTime, post.userId, seriesId, " +
                            "seriesOrder, image, postContent, count(postLike.userId) as countLike " +
                            "from post inner join postlike on post.postId = postLike.postId " +
                            "group by post.postId " +
                            "order by countLike desc " +
                            "limit " + number;
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
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
            System.out.println("Get top like posts error: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<DTOPost> getTopNewPosts(int number) {
        try {
            ArrayList<DTOPost> result = new ArrayList();
            
            String query = "Select * from Post order by postTime desc limit " + number;
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
            System.out.println("Get all posts error: " + e.getMessage());
            
            return null;
        }
    }
    
    public boolean insertNewPost(DTOPost post) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String postTitleUnsigned = convertToUnsigned(post.getPostTitle().trim());
            
            String query = "Insert into Post (postTitle, postTitleUnsigned, postSubTitle, postTime, userId, seriesId, seriesOrder, image, postContent) values (N'"
                         + post.getPostTitle() + "', '"
                         + postTitleUnsigned + "', N'"
                         + post.getPostSubTitle() + "', '"
                         + formatter.format(post.getPostTime()) + "', "
                         + post.getUserId() + ", "
                         + post.getSeriesId() + ", "
                         + post.getSeriesOrder() + ", '"
                         + post.getImage() + "', N'"
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
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String postTitleUnsigned = convertToUnsigned(post.getPostTitle().trim());
            
            String query = "Update Post Set "
                         + "postTitle = N'" + post.getPostTitle() + "', "
                         + "postTitleUnsigned = '" + postTitleUnsigned + "', "
                         + "postSubTitle = N'" + post.getPostTitleUnsigned() + "', "
                         + "postContent = N'" + post.getPostContent() + "', "
                         + "postTime = '" + formatter.format(post.getPostTime()) + "' "
                         + "seriesId = " + post.getSeriesId()
                         + "seriesOrder = " + post.getSeriesOrder()
                         + "image = '" + post.getImage() + "' "
                         + "where postId = " + post.getPostId() + ";";
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
