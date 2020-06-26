
package Beans;

import DTO.DTOReportReasonList;

public class BeanReportReasonList {
    int reasonId;
    String reasonContent;

    public BeanReportReasonList() {
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
