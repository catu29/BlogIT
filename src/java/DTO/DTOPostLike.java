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
public class DTOPostLike {

    int postId;
    int userId;
    Date likeTime;

    public DTOPostLike() {
    }

    public DTOPostLike(int postId, int userId, Date likeTime) {
        this.postId = postId;
        this.userId = userId;
        this.likeTime = likeTime;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getLikeTime() {
        return likeTime;
    }

    public void setLikeTime(Date likeTime) {
        this.likeTime = likeTime;
    }
}
