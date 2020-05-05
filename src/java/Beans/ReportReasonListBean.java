
package Beans;

public class ReportReasonListBean {
    int reasonId;
    String reasonContent;

    public ReportReasonListBean() {
    }

    public ReportReasonListBean(int reasonId, String reasonContent) {
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
