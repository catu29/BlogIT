
package Beans;

import java.util.Calendar;

public class PostBean {
    int postId;
    String postTitle;
    Calendar postTime;
    String username;
    int likes;
    String postContent;
    int seriesId;

    public PostBean() {
    }
    
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        if (postId > 0) {
            this.postId = postId;
        }
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public Calendar getPostTime() {
        return postTime;
    }

    public void setPostTime(Calendar postTime) {
        this.postTime = postTime;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        if (likes > 0) {
            this.likes = likes;
        }
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        if (seriesId > 0) {
            this.seriesId = seriesId;
        }
    }
    
    public void initPost(int postId, String postTitle, Calendar postTime, String username, int likes, String postContent, int seriesId) {
        this.setPostId(postId);
        this.setPostTitle(postTitle);
        this.setPostTime(postTime);
        this.setUserName(username);
        this.setLikes(likes);
        this.setPostContent(postContent);
        this.setSeriesId(seriesId);
    }
}
