
package Beans;

import java.util.Calendar;

public class PostReportBean {
    int reportId;
    String username;
    int postId;
    int reportReasonId;
    Calendar reportTime;
    
    public PostReportBean() {
    }
    
    public PostReportBean(int reportId, String username, int postId, int reportReasonId, Calendar reportTime) {
        this.reportId = reportId;
        this.username = username;
        this.postId = postId;
        this.reportReasonId = reportReasonId;
        this.reportTime = reportTime;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getReportReasonId() {
        return reportReasonId;
    }

    public void setReportReasonId(int reportReasonId) {
        this.reportReasonId = reportReasonId;
    }

    public Calendar getReportTime() {
        return reportTime;
    }

    public void setReportTime(Calendar reportTime) {
        this.reportTime = reportTime;
    }
}
