
package Beans;

public class UserSeriesListBean {
    String seriesId;
    String username;
    String seriesName;

    public UserSeriesListBean() {
    }

    public UserSeriesListBean(String seriesId, String username, String seriesName) {
        this.seriesId = seriesId;
        this.username = username;
        this.seriesName = seriesName;
    }

    public String getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(String seriesId) {
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
