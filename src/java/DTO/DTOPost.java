/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.Date;

/**
 *
 * @author TranCamTu
 */
public class DTOPost {
    int postId;
    String postTitle;
    String postTitleUnsigned;
    String postSubTitle;
    Date postTime;
    int userId;
    int seriesId;
    int seriesOrder;
    String image;
    String postContent;

    public DTOPost() {
    }

    public DTOPost(int postId, 
            String postTitle, String postTitleUnsigned, String postSubTitle, 
            Date postTime, int userId, 
            int seriesId, int seriesOrder, 
            String image, String postContent) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postTitleUnsigned = postTitleUnsigned;
        this.postSubTitle = postSubTitle;
        this.postTime = postTime;
        this.userId = userId;
        this.seriesId = seriesId;
        this.seriesId = seriesId;
        this.image = image;
        this.postContent = postContent;
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

    public String getPostSubTitle() {
        return postSubTitle;
    }

    public void setPostSubTitle(String postSubTitle) {
        this.postSubTitle = postSubTitle;
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

    public int getSeriesOrder() {
        return seriesOrder;
    }

    public void setSeriesOrder(int seriesOrder) {
        this.seriesOrder = seriesOrder;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }
}
