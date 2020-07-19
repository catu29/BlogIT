/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author TranCamTu
 */
public class DTOReportReasonList {
    int reasonId;
    String reasonContent;

    public DTOReportReasonList() {
    }

    public DTOReportReasonList(int reasonId, String reasonContent) {
        this.reasonId = reasonId;
        this.reasonContent = reasonContent;
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
