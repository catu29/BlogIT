
package Beans;

import java.util.Calendar;

public class PostReportBean {
    String reportId;
    String username;
    String postId;
    String reportReasonId;
    Calendar reportTime;
    
    public PostReportBean() {
    }
    
    public PostReportBean(String reportId, String username, String postId, String reportReasonId, Calendar reportTime) {
        this.reportId = reportId;
        this.username = username;
        this.postId = postId;
        this.reportReasonId = reportReasonId;
        this.reportTime = reportTime;
    }

    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getReportReasonId() {
        return reportReasonId;
    }

    public void setReportReasonId(String reportReasonId) {
        this.reportReasonId = reportReasonId;
    }

    public Calendar getReportTime() {
        return reportTime;
    }

    public void setReportTime(Calendar reportTime) {
        this.reportTime = reportTime;
    }
}
