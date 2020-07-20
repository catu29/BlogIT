/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOTagList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperTagList extends MapperBase {
    public boolean insertNewTag(DTOTagList newTag) {
        try {
            String query = "Insert Into TagList Values ('" + newTag.getTagId() + "', '" + newTag.getTagName() + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
                        
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new tag error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean updateTagName(DTOTagList tag) {
        try {
            String query = "Update TagList Set tagName = '" + tag.getTagName() + "' Where tagId = '" + tag.getTagId() + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
                        
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update tag name error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteTag(DTOTagList tag) {
        try {
            String query = "Delete From TagList Where tagId = '" + tag.getTagId() + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete tag error: " + e.getMessage());
            
            return false;
        }
    }
    
    public ArrayList<DTOTagList> getAllTags() {
        try {
            ArrayList<DTOTagList> result = new ArrayList();
            
            String query = "Select * From TagList;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOTagList tag = new DTOTagList(rs.getString("tagId"), rs.getString("tagName"));
                result.add(tag);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all tags error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOTagList searchTagById(String id) {
        try {
            String query = "Select * From TagList Where tagId = '" + id + "';";
            PreparedStatement stmt = connection.prepareStatement(query);
                        
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            
            return new DTOTagList(rs.getString("tagId"), rs.getString("tagName"));
        } catch (Exception e) {
            System.out.println("Search tags by id error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOTagList> searchTagByName(String name) {
        try {
            ArrayList<DTOTagList> result = new ArrayList();
            
            String query = "Select * From TagList Where tagName = '"
                            + name + "' or tagName like '%" + name + "%';";
            PreparedStatement stmt = connection.prepareStatement(query);
             
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOTagList tag = new DTOTagList(rs.getString("tagId"), rs.getString("tagName"));
                result.add(tag);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Search tags by name error: " + e.getMessage());
            
            return null;
        }
    }
}
