
package Beans;

import DTO.DTOPostComment;
import java.util.Calendar;

public class BeanPostComment {
    int commentId;
    int userId;
    int postId;
    String content;
    Calendar commentTime;
    int parentId;

    public BeanPostComment() {
    }

    public void initFromDTO(DTOPostComment postComment) {
        this.setCommentId(postComment.getCommentId());
        this.setUserId(postComment.getUserId());
        this.setPostId(postComment.getPostId());
        this.setContent(postComment.getContent());
        this.setCommentTime(postComment.getCommentTime());
        this.setParentId(postComment.getParentId());
    }
    
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Calendar getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Calendar commentTime) {
        this.commentTime = commentTime;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
}
