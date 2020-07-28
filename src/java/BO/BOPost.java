/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOPost;
import DataMapper.MapperPost;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOPost {
    MapperPost mapper = new MapperPost();
    
    public DTOPost getPostInformation(int postId) {
        return mapper.getPostInformation(postId);
    }
    
    public DTOPost getLatestUserPostInformation(int userId) {
        return mapper.getLatestUserPostInformation(userId);
    }
    
    public DTOPost getPostInformation(int postId, String titleUnsigned) {
        return mapper.getPostInformation(postId, titleUnsigned);
    }
    
    public ArrayList<DTOPost> getAllPosts() {
        return mapper.getAllPosts();
    }
    
    public ArrayList<DTOPost> getAllPostsOfUser(int userId) {
        return mapper.getAllPostsOfUser(userId);
    }
    
    public ArrayList<DTOPost> getPostsOfUser(int userId, int amount) {
        return mapper.getPostsOfUser(userId, amount);
    }
    
    public ArrayList<DTOPost> getAllPostsOfSeries(int seriesId) {
        return mapper.getAllPostsOfSeries(seriesId);
    }
    
    public ArrayList<DTOPost> getTopPostsOfSeries(int seriesId, int number) {
        return mapper.getTopPostsOfSeries(seriesId, number);
    }
    
    public ArrayList<DTOPost> getTopLikePosts(int number) {
        return mapper.getTopLikePosts(number);
    }
    
    public ArrayList<DTOPost> getTopNewPosts(int number) {
        return mapper.getTopNewPosts(number);
    }
    
    public boolean insertNewPost(DTOPost post) {
        return mapper.insertNewPost(post);
    }
    
    public boolean updatePost(DTOPost post) {
        return mapper.updatePost(post);
    }
    
    public boolean deletePost(int postId) {
        return mapper.deletePost(postId);
    }
    
    public ArrayList<DTOPost> search(String condition) {
        return mapper.search(condition);
    }
}
