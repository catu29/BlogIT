/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOUserSeriesList;
import DataMapper.MapperUserSeriesList;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOUserSeriesList {
    public ArrayList<DTOUserSeriesList> getAllLists() {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.getAllLists();
    }
    
    public ArrayList<DTOUserSeriesList> getAllLists(int userId) {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.getAllLists(userId);
    }
    
    public boolean insertNewUserSeriesList(DTOUserSeriesList list) {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.insertNewUserSeriesList(list);
    }
    
    public boolean deleteUserSeriesList(DTOUserSeriesList list) {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.deleteUserSeriesList(list);
    }
    
    public boolean updateUserSeriesByCondition(DTOUserSeriesList list, String column, String condition) {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.updateUserSeriesByCondition(list, column, condition);
    }
    
    public ArrayList<DTOUserSeriesList> searchSeriesList(String condition) {
        MapperUserSeriesList mapper = new MapperUserSeriesList();
        
        return mapper.searchSeriesList(condition);
    }
}
