/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author TranCamTu
 */
public class DTOUser {
    int userId;
    String password;
    String email;
    String fullName;
    String avatar;
    int role;
    
    public DTOUser() { }
    
    public DTOUser(int userId, String password, String email, String fullName, String avatar, int role) {
        this.userId = userId;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.avatar = avatar;
        this.role = role;
    }
    
    public DTOUser(String password, String email, String fullName, String avatar, int role) {
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.avatar = avatar;
        this.role = role;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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
