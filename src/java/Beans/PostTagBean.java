
package Beans;

public class PostTagBean {
    String postId;
    String tagId;

    public PostTagBean() {
    }

    public PostTagBean(String postId, String tagId) {
        this.postId = postId;
        this.tagId = tagId;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }
    
    
}
