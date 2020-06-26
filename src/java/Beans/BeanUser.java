
package Beans;

import DTO.DTOUser;

public class BeanUser {
    int userId;
    String password;
    String email;
    String fullName;
    String avatar;
    int role;
    
    public BeanUser() { }
    
    public void initFromDTO(DTOUser user) {
        this.setUserId(user.getUserId());
        this.setPassword(user.getPassword());
        this.setEmail(user.getEmail());
        this.setFullName(user.getFullName());
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
