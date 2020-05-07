
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
        if (commentId > 0) {
            this.commentId = commentId;
        }
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
        if (postId > 0) {
            this.postId = postId;
        }
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
        if (replyToCommentId > 0) {
            this.replyToCommentId = replyToCommentId;
        }
    }

    public void initPostComment(int commentId, String username, int postId, String content, Calendar commentTime, int replyToCommentId) {
        this.setCommentId(commentId);
        this.setUserName(username);
        this.setPostId(postId);
        this.setContent(content);
        this.setCommentTime(commentTime);
        this.setReplyToCommentId(replyToCommentId);
    }
}
