
package Beans;

public class UserBean {
    String username;
    String password;
    String email;
    String fullName;
    int postAmount;
    String avatar;
    
    public UserBean() { }
    
    public UserBean(String username, String password, String email, String fullName, int postAmount, String avatar) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.postAmount = postAmount;
        this.avatar = avatar;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
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

    public int getPostAmount() {
        return postAmount;
    }

    public void setPostAmount(int postAmount) {
        this.postAmount = postAmount;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
