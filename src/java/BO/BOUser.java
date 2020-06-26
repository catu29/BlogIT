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
    public boolean login(String email, String password) {
        MapperUser mapper = new MapperUser();
        
        return mapper.login(email, password);
    }
    
    public boolean insertNewUser(DTOUser user) {
        MapperUser mapper = new MapperUser();
        
        return mapper.isExisting(user.getEmail()) ? false : mapper.insertNewUser(user);
    }
    
    public boolean updateUserByCondition(DTOUser user, String column, String condition) {
        MapperUser mapper = new MapperUser();
        
        if (column.equals("email") && mapper.isExisting(condition)) {
            return false;
        } else {
            return mapper.updateUserByCondition(user, column, condition);
        }
    }
    
    public boolean deleteUser(DTOUser user) {
        MapperUser mapper = new MapperUser();
        
        return mapper.isExisting(user.getEmail()) ? false : mapper.deleteUser(user);
    }
    
    public ArrayList<DTOUser> getAllUsers() {
        MapperUser mapper = new MapperUser();
        
        return mapper.getAllUsers();
    }
    
    // Use for get the unique user by their email
    public DTOUser getUserInformation(String email) {
        MapperUser mapper = new MapperUser();
        
        if (searchUser("email", email).size() == 1) {
            return searchUser("email", email).get(0);
        } else {
            return null;
        }
    }
    
    // Use for get the unique user by their Id
    public DTOUser getUserInformation(int Id) {
        MapperUser mapper = new MapperUser();
        
        if (searchUser("email", Id).size() == 1) {
            return searchUser("email", Id).get(0);
        } else {
            return null;
        }
    }
    
    public ArrayList<DTOUser> searchUser(String column, String condition) {
        MapperUser mapper = new MapperUser();
        
        return mapper.searchUser(column, condition);
    }
    
    public ArrayList<DTOUser> searchUser(String column, int condition) {
        MapperUser mapper = new MapperUser();
        
        return mapper.searchUser(column, condition);
    }
    
    public ArrayList<DTOUser> searchUser(String condition) {
        MapperUser mapper = new MapperUser();
        
        return mapper.searchUser(condition);
    }
}
