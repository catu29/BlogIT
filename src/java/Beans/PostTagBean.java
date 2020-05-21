
package Beans;

public class PostTagBean {
    int postId;
    String tagId;

    public PostTagBean() {
    }

    public void initPostTag(int postId, String tagId) {
        this.setPostId(postId);       
        this.setTagId(tagId);
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        if (postId > 0) {
            this.postId = postId;
        }
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }
}
