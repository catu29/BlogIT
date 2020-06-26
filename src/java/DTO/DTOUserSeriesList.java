/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author TranCamTu
 */
public class DTOUserSeriesList {
    int seriesId;
    int userId;
    String seriesName;
    String seriesNameUnsigned;

    public DTOUserSeriesList() {
    }

    public DTOUserSeriesList(int seriesId, int userId, String seriesName, String seriesNameUnsigned) {
        this.seriesId = seriesId;
        this.userId = userId;
        this.seriesName = seriesName;
        this.seriesNameUnsigned = seriesNameUnsigned;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
    }
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getSeriesName() {
        return seriesName;
    }

    public void setSeriesName(String seriesName) {
        this.seriesName = seriesName;
    }

    public String getSeriesNameUnsigned() {
        return seriesNameUnsigned;
    }

    public void setSeriesNameUnsigned(String seriesNameUnsigned) {
        this.seriesNameUnsigned = seriesNameUnsigned;
    }   
}
