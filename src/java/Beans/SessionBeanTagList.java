/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOTagList;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author TranCamTu
 */
@Stateless
public class SessionBeanTagList implements Serializable {

    String tagId;
    String tagName;

    public SessionBeanTagList() {
    }

    public void initFromDTO(DTOTagList tagList) {
        this.setTagId(tagList.getTagId());
        this.setTagName(tagList.getTagName());
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }
}
