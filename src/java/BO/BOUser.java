package BO;

import DTO.DTOUser;
import DataMapper.MapperUser;
import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author TranCamTu
 */
public class BOUser {
    MapperUser mapper = new MapperUser();
        
    public boolean login(String email, String password) {
        return mapper.login(email, password);
    }
    
    public boolean isExisting (String email) {
        return mapper.isExisting(email);
    }
    
    public boolean insertNewUser(DTOUser user) {
        return mapper.isExisting(user.getEmail()) ? false : mapper.insertNewUser(user);
    }
    
    public boolean updateUserEmail(DTOUser user, String email) {
        if (mapper.isExisting(email)) {
            return false;
        }
        
        return mapper.updateUserEmail(user, email);
    }
    
    public boolean updateUserFullName(DTOUser user, String fullname) {
        return mapper.updateUserFullName(user, fullname);
    }
    
    public boolean updateUserPassword(DTOUser user, String password) {
        return mapper.updateUserPassword(user, password);
    }
    
    public boolean updateUserAvatar(DTOUser user, String avatar) {
        return mapper.updateUserAvatar(user, avatar);
    }
    
    public boolean updateUserBio(DTOUser user, String bio) {
        return mapper.updateUserBio(user, bio);
    }
    
    public boolean updateUserRole(DTOUser user, int role) {
        return mapper.updateUserRole(user, role);
    }
    
    public boolean deleteUser(DTOUser user) {
        return mapper.isExisting(user.getEmail()) ? mapper.deleteUser(user) : false;
    }
    
    public ArrayList<DTOUser> getAllUsers() {
        return mapper.getAllUsers();
    }
    
    // Use for get the unique user by their email
    public DTOUser getUserInformation(String email) {
       return mapper.getUserInformation(email);
    }
    
    // Use for get the unique user by their Id
    public DTOUser getUserInformation(int id) {
        return mapper.getUserInformation(id);
    }
    
    public DTOUser getUserInformation(int id, String name) {
        return mapper.getUserInformation(id, name);
    }
    
    public ArrayList<DTOUser> searchUser(String column, String condition) {
        return mapper.searchUser(column, condition);
    }
    
    public ArrayList<DTOUser> searchUser(String column, int condition) {
        return mapper.searchUser(column, condition);
    }
    
    public ArrayList<DTOUser> searchUser(String condition) {
        return mapper.searchUser(condition);
    }
}
