
package Beans;

import DTO.DTOPost;
import java.util.Calendar;

public class BeanPost {
    int postId;
    String postTitle;
    String postTitleUnsigned;
    Calendar postTime;
    int userId;
    int seriesId;
    String postContent;

    public BeanPost() {
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

    public String getPostTitleUnsigned() {
        return postTitleUnsigned;
    }

    public void setPostTitleUnsigned(String postTitleUnsigned) {
        this.postTitleUnsigned = postTitleUnsigned;
    }

    public Calendar getPostTime() {
        return postTime;
    }

    public void setPostTime(Calendar postTime) {
        this.postTime = postTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }    
    
    public void initFromDTO(DTOPost post) {        
        this.setPostId(post.getPostId());
        this.setPostTitle(post.getPostTitle());
        this.setPostTitleUnsigned(post.getPostTitleUnsigned());
        this.setPostTime(post.getPostTime());
        this.setUserId(post.getUserId());
        this.setSeriesId(post.getSeriesId());
        this.setPostContent(post.getPostContent());
    }
}
