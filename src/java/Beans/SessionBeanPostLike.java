/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOPostLike;
import java.util.Date;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanPostLike {

    int postId;
    int userId;
    Date likeTime;

    public SessionBeanPostLike() {
    }

    public void initFromDTO(DTOPostLike postLike) {
        this.postId = postLike.getPostId();
        this.userId = postLike.getUserId();
        this.likeTime = postLike.getLikeTime();
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
