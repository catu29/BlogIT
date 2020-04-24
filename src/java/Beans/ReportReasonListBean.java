
package Beans;

public class ReportReasonListBean {
    String reasonId;
    String reasonContent;

    public ReportReasonListBean() {
    }

    public ReportReasonListBean(String reasonId, String reasonContent) {
        this.reasonId = reasonId;
        this.reasonContent = reasonContent;
    }

    public String getReasonId() {
        return reasonId;
    }

    public void setReasonId(String reasonId) {
        this.reasonId = reasonId;
    }

    public String getReasonContent() {
        return reasonContent;
    }

    public void setReasonContent(String reasonContent) {
        this.reasonContent = reasonContent;
    }
    
}
