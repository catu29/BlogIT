/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import DTO.DTOUser;
import java.io.Serializable;
import javax.ejb.Stateful;

/**
 *
 * @author TranCamTu
 */
@Stateful
public class SessionBeanUser implements Serializable {

    int userId;
    String password;
    String email;
    String fullname;
    String avatar;
    int role;
    
    public SessionBeanUser() { }
    
    public void initFromDTO(DTOUser user) {
        this.setUserId(user.getUserId());
        this.setPassword(user.getPassword());
        this.setEmail(user.getEmail());
        this.setFullname(user.getFullname());
        this.setAvatar(user.getAvatar());
        this.setRole(user.getRole());
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
