
package Beans;

import java.util.Calendar;

public class PostCommentBean {
    int commentId;
    String username;
    int postId;
    String content;
    Calendar commentTime;
    int replyToCommentId;

    public PostCommentBean() {
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
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

    public int getReplyToCommentId() {
        return replyToCommentId;
    }

    public void setReplyToCommentId(int replyToCommentId) {
        this.replyToCommentId = replyToCommentId;
    }

    public PostCommentBean(int commentId, String username, int postId, String content, Calendar commentTime, int replyToCommentId) {
        this.commentId = commentId;
        this.username = username;
        this.postId = postId;
        this.content = content;
        this.commentTime = commentTime;
        this.replyToCommentId = replyToCommentId;
    }
}
