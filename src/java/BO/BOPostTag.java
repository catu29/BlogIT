/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOPost;
import DTO.DTOTagList;
import DataMapper.MapperPostTag;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOPostTag {
    MapperPostTag mapper = new MapperPostTag();
    
    public boolean addTagForPost(int postId, String tagId) {        
        return mapper.addTagForPost(postId, tagId);
    }
    
    public boolean addTagForPost(int postId, String[] tags) {        
        return mapper.addTagForPost(postId, tags);
    }
    
    public boolean updateTagForPost(int postId, String oldTagId, String newTagId) {
        return mapper.updateTagForPost(postId, oldTagId, newTagId);
    }
    
    public boolean deleteTagForPost(int postId, String tagId) {
        return mapper.deleteTagForPost(postId, tagId);
    }
    
    public boolean deleteTagForPost(int postId) {
        return mapper.deleteTagForPost(postId);
    }
    
    public ArrayList<DTOTagList> getAllTagsForPost(int postId) {
        return mapper.getAllTagsForPost(postId);
    }
    
    public ArrayList<DTOPost> getAllPostsForTag(String tagId) {
        return mapper.getAllPostsForTag(tagId);
    }
    
    public ArrayList<Integer> getAllTagIdsForPost(int postId) {
        return mapper.getAllTagIdsForPost(postId);
    }
}
