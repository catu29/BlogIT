
package Beans;

import DTO.DTOUserSeriesList;

public class BeanUserSeriesList {
    int seriesId;
    int userId;
    String seriesName;
    String seriesNameUnsigned;

    public BeanUserSeriesList() {
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
