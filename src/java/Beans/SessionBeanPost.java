/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOPost;
import java.io.Serializable;
import java.util.Date;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanPost implements Serializable{

    int postId;
    String postTitle;
    String postTitleUnsigned;
    Date postTime;
    int userId;
    int seriesId;
    String postContent;

    public SessionBeanPost() {
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

    public Date getPostTime() {
        return postTime;
    }

    public void setPostTime(Date postTime) {
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
}
