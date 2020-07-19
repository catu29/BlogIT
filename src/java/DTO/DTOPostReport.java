/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.Date;

/**
 *
 * @author TranCamTu
 */
public class DTOPostReport {
    int reportId;
    int userId;
    int postId;
    int reportReasonId;
    Date reportTime;
    
    public DTOPostReport() {
    }
    
    public DTOPostReport(int reportId, int userId, int postId, int reportReasonId, Date reportTime) {
        this.reportId = reportId;
        this.userId = userId;
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

    public Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }
}
