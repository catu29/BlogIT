
package Beans;

public class ReportReasonListBean {
    int reasonId;
    String reasonContent;

    public ReportReasonListBean() {
    }

    public void initReportReasonList(int reasonId, String reasonContent) {
        this.setReasonId(reasonId);
        this.setReasonContent(reasonContent);
    }

    public int getReasonId() {
        return reasonId;
    }

    public void setReasonId(int reasonId) {
        if (reasonId > 0) {
            this.reasonId = reasonId;
        }
    }

    public String getReasonContent() {
        return reasonContent;
    }

    public void setReasonContent(String reasonContent) {
        this.reasonContent = reasonContent;
    }
    
}
