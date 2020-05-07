
package Beans;

public class TagListBean {
    String tagId;
    String tagName;

    public TagListBean() {
    }

    public void initTagList(String tagId, String tagName) {
        this.setTagId(tagId);
        this.setTagName(tagName);
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }
    
    
}
