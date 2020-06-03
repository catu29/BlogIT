
package Beans;

public class UserSeriesListBean {
    int seriesId;
    String username;
    String seriesName;

    public UserSeriesListBean() {
    }

    public UserSeriesListBean(int seriesId, String username, String seriesName) {
        this.seriesId = seriesId;
        this.username = username;
        this.seriesName = seriesName;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
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
