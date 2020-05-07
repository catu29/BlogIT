
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
    
    public void initPostReport(int reportId, String username, int postId, int reportReasonId, Calendar reportTime) {
        this.setReportId(reportId);
        this.setUserName(username);
        this.setPostId(postId);
        this.setReportReasonId(reportReasonId);
        this.setReportTime(reportTime);
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        if (reportId > 0) {
            this.reportId = reportId;
        }
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
        if (postId > 0) {
            this.postId = postId;
        }
    }

    public int getReportReasonId() {
        return reportReasonId;
    }

    public void setReportReasonId(int reportReasonId) {
        if (reportReasonId > 0) {
            this.reportReasonId = reportReasonId;
        }
    }

    public Calendar getReportTime() {
        return reportTime;
    }

    public void setReportTime(Calendar reportTime) {
        this.reportTime = reportTime;
    }
}
