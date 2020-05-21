
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

    public PostBean(int postId, String postTitle, Calendar postTime, String username, int likes, String postContent, int seriesId) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postTime = postTime;
        this.username = username;
        this.likes = likes;
        this.postContent = postContent;
        this.seriesId = seriesId;
    }

    public PostBean() {
    }
    
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
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
        this.likes = likes;
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
        this.seriesId = seriesId;
    }
}
