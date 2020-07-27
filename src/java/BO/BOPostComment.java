/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOPostComment;
import DataMapper.MapperPostComment;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOPostComment {
    MapperPostComment mapper = new MapperPostComment();
    
    public ArrayList<DTOPostComment> getAllCommentsForPost(int postId) {
        return mapper.getAllCommentsForPost(postId);
    }
    
    public DTOPostComment getLatestCommentForPost(int postId) {
        return mapper.getLatestCommentForPost(postId);
    }
    
    public boolean insertCommentForPost(DTOPostComment comment) {
        return mapper.insertCommentForPost(comment);
    }
    
    public boolean updateCommentForPost(DTOPostComment comment) {
        return mapper.updateCommentForPost(comment);
    }
    
    public boolean deleteCommentForPost(int commentId) {
        return mapper.deleteCommentForPost(commentId);
    }
}
