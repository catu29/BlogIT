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
    
    public ArrayList<DTOUserSeriesList> getUserLists(int userId) {
        return mapper.getUserLists(userId);
    }
    
    public DTOUserSeriesList getLatestUserSeries(int userId) {
        return mapper.getLatestUserSeries(userId);
    }
    
    public boolean insertNewUserSeriesList(DTOUserSeriesList list) {
        return mapper.insertNewUserSeriesList(list);
    }
    
    public boolean deleteUserSeriesList(int seriesId) {
        return mapper.deleteUserSeriesList(seriesId);
    }
    
    public boolean updateUserSeriesListName(DTOUserSeriesList list) {
        return mapper.updateUserSeriesListName(list);
    }
    
    public boolean updateUserSeriesByCondition(DTOUserSeriesList list, String column, String condition) {
        return mapper.updateUserSeriesByCondition(list, column, condition);
    }
        
    public ArrayList<DTOUserSeriesList> searchSeriesList(String condition) {
        return mapper.searchSeriesList(condition);
    }
}
