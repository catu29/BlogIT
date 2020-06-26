
package Beans;

import DTO.DTOPostReport;
import java.util.Calendar;

public class BeanPostReport {
    int reportId;
    int userId;
    int postId;
    int reportReasonId;
    Calendar reportTime;
    
    public BeanPostReport() {
    }
    
    public void initFromDTO(DTOPostReport postReport) {
        this.setReportId(postReport.getReportId());
        this.setUserId(postReport.getUserId());
        this.setPostId(postReport.getPostId());
        this.setReportReasonId(postReport.getReportReasonId());
        this.setReportTime(postReport.getReportTime());
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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
