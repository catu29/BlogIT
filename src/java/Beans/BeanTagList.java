
package Beans;

import DTO.DTOTagList;

public class BeanTagList {
    String tagId;
    String tagName;

    public BeanTagList() {
    }

    public void initFromDTO(DTOTagList tagList) {
        this.setTagId(tagList.getTagId());
        this.setTagName(tagList.getTagName());
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
