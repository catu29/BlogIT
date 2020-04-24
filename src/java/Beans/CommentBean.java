
package Beans;

import java.util.Calendar;

public class CommentBean {
    String commentId;
    String username;
    String postId;
    String content;
    Calendar commentTime;
    String replyToCommentId;

    public CommentBean() {
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
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

    public String getReplyToCommentId() {
        return replyToCommentId;
    }

    public void setReplyToCommentId(String replyToCommentId) {
        this.replyToCommentId = replyToCommentId;
    }

    public CommentBean(String commentId, String username, String postId, String content, Calendar commentTime, String replyToCommentId) {
        this.commentId = commentId;
        this.username = username;
        this.postId = postId;
        this.content = content;
        this.commentTime = commentTime;
        this.replyToCommentId = replyToCommentId;
    }
}
