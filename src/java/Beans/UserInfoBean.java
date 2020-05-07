
package Beans;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserInfoBean {
    String username;
    String password;
    String email;
    String fullName;
    int postAmount;
    String avatar;
    
    public UserInfoBean() { }
    
    public void initUserInfo(String username, String password, String email, String fullName, int postAmount, String avatar) {
        this.setUserName(username);
        this.setPassword(password);
        this.setEmail(email);
        this.setFullName(fullName);
        this.setPostAmount(postAmount);
        this.setAvatar(avatar);
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
        if (this.validateEmail(email)) {
            this.email = email;
        }
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
        if (postAmount >= 0) {
            this.postAmount = postAmount;
        }
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public boolean validateEmail(String emailStr) {
        Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
        Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(emailStr);
        return matcher.find();
    }
}
