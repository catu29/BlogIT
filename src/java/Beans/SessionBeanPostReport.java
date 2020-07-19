/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOPostReport;
import java.io.Serializable;
import java.util.Date;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanPostReport implements Serializable {

    int reportId;
    int userId;
    int postId;
    int reportReasonId;
    Date reportTime;
    
    
    
    public SessionBeanPostReport() {
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

    public Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }
}
