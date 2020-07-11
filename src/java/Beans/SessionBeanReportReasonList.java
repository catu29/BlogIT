/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOReportReasonList;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanReportReasonList implements Serializable {

    int reasonId;
    String reasonContent;

    public SessionBeanReportReasonList() {
    }

    public void initFromDTO(DTOReportReasonList reportReason) {
        this.setReasonId(reportReason.getReasonId());
        this.setReasonContent(reportReason.getReasonContent());
    }

    public int getReasonId() {
        return reasonId;
    }

    public void setReasonId(int reasonId) {
        this.reasonId = reasonId;
    }

    public String getReasonContent() {
        return reasonContent;
    }

    public void setReasonContent(String reasonContent) {
        this.reasonContent = reasonContent;
    }
}
