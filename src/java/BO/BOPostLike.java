/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOPostLike;
import DataMapper.MapperPostLike;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOPostLike {
    MapperPostLike mapper = new MapperPostLike();
    
    public ArrayList<DTOPostLike> getAllLikes() {
        return mapper.getAllLikes();
    }
    
    public ArrayList<DTOPostLike> getAllLikesOfPost(int postId) {
        return mapper.getAllLikesOfPost(postId);
    }
    
    public ArrayList<DTOPostLike> getAllLikesOfUser(int userId) {
        return mapper.getAllLikesOfUser(userId);
    }
    
    public boolean isLiked(int postId, int userId) {
        return mapper.isLiked(postId, userId);
    }
    
    public boolean insertNewLike(DTOPostLike like) {
        return mapper.insertNewLike(like);
    }
    
    public boolean deleteLike(int postId, int userId) {
        return mapper.deleteLike(postId, userId);
    }
}
