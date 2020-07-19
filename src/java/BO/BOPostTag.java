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
    
    public boolean updateTagForPost(int postId, String oldTagId, String newTagId) {
        return mapper.updateTagForPost(postId, oldTagId, newTagId);
    }
    
    public boolean deleteTagForPost(int postId, String tagId) {
        return mapper.deleteTagForPost(postId, tagId);
    }
    
    public ArrayList<DTOTagList> getAllTagsForPost(int postId) {
        return mapper.getAllTagsForPost(postId);
    }
    
    public ArrayList<DTOPost> getAllPostsForTag(String tagId) {
        return mapper.getAllPostsForTag(tagId);
    }
}
