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
    MapperUserSeriesList mapper = new MapperUserSeriesList();
    
    public DTOUserSeriesList getSeriesInformation(int seriesId) {
        return mapper.getSeriesInformation(seriesId);
    }
    
    public ArrayList<DTOUserSeriesList> getAllLists() {        
        return mapper.getAllLists();
    }
    
    public ArrayList<DTOUserSeriesList> getAllLists(int userId) {
        return mapper.getAllLists(userId);
    }
    
    public boolean insertNewUserSeriesList(DTOUserSeriesList list) {
        return mapper.insertNewUserSeriesList(list);
    }
    
    public boolean deleteUserSeriesList(DTOUserSeriesList list) {
        return mapper.deleteUserSeriesList(list);
    }
    
    public boolean updateUserSeriesByCondition(DTOUserSeriesList list, String column, String condition) {
        return mapper.updateUserSeriesByCondition(list, column, condition);
    }
    
    public ArrayList<DTOUserSeriesList> searchSeriesList(int userId) {
        return mapper.searchSeriesList(userId);
    }
    
    public ArrayList<DTOUserSeriesList> searchSeriesList(String condition) {
        return mapper.searchSeriesList(condition);
    }
}