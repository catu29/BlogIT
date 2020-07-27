/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOTagList;
import DataMapper.MapperTagList;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOTagList {
    
    MapperTagList mapper = new MapperTagList();
        
    public boolean insertNewTag(DTOTagList newTag) {
        return mapper.insertNewTag(newTag);
    }
    
    public boolean updateTagName(DTOTagList tag) {
        return mapper.updateTagName(tag);
    }
    
    public boolean deleteTag(DTOTagList tag) {
        return mapper.deleteTag(tag);
    }
    
    public ArrayList<DTOTagList> getAllTags() {
        return mapper.getAllTags();
    }
    
    public ArrayList<DTOTagList> getTopNumberOfTags(int number) {
        return mapper.getTopNumberOfTags(number);
    }
    
    public DTOTagList searchTagById(String id) {
        return mapper.searchTagById(id);
    }
    
    public ArrayList<DTOTagList> searchTagByName(String name) {
        return mapper.searchTagByName(name);
    }
}
