/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOPostTag;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanPostTag implements Serializable {

    int postId;
    int tagId;

    public SessionBeanPostTag() {
    }

    public void initFromDTO(DTOPostTag postTag) {
        this.setPostId(postTag.getPostId());
        this.setTagId(postTag.getTagId());
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getTagId() {
        return tagId;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }
}
