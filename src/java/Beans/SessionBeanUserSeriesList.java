/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOUserSeriesList;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanUserSeriesList implements Serializable {

    int seriesId;
    int userId;
    String seriesName;
    String seriesNameUnsigned;

    public SessionBeanUserSeriesList() {
    }

    public void initFromDTO(DTOUserSeriesList userSeries) {
        this.setSeriesId(userSeries.getSeriesId());
        this.setUserId(userSeries.getUserId());
        this.setSeriesName(userSeries.getSeriesName());
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
