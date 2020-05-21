
package Beans;

public class UserSeriesListBean {
    int seriesId;
    String username;
    String seriesName;

    public UserSeriesListBean() {
    }

    public void initUserSeriesList(int seriesId, String username, String seriesName) {
        this.setSeriesId(seriesId);
        this.setUsername(username);
        this.setSeriesName(seriesName);
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        if (seriesId > 0) {
            this.seriesId = seriesId;
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSeriesName() {
        return seriesName;
    }

    public void setSeriesName(String seriesName) {
        this.seriesName = seriesName;
    }
    
    
}
