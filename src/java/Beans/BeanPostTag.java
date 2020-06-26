
package Beans;

import DTO.DTOPostTag;

public class BeanPostTag {
    int postId;
    int tagId;

    public BeanPostTag() {
    }

    public void initFromDTO(DTOPostTag postTag) {
        this.setPostId(postTag.getPostId());
        this.setTagId(postTag.getTagId());
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getTagId() {
        return tagId;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }
    
    
}
