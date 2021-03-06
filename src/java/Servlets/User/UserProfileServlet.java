/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.User;

import BO.BOPost;
import BO.BOPostComment;
import BO.BOPostLike;
import BO.BOUser;
import Beans.SessionBeanUser;
import DTO.DTOPost;
import DTO.DTOPostComment;
import DTO.DTOPostLike;
import DTO.DTOUser;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TranCamTu
 */
public class UserProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding(getServletContext().getInitParameter("PARAMETER_ENCODING"));
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        HttpSession session = request.getSession(true);
        
        if (request.getParameter("id") != null) {
            String userId = request.getParameter("id"); // userId
              
            BOUser userBO = new BOUser();
            DTOUser userDTO = userBO.getUserInformation(Integer.parseInt(userId));
            request.setAttribute("userProfile", userDTO);

            BOPost boPost = new BOPost();
            BOPostLike likeBO = new BOPostLike();
            BOPostComment commentBO = new BOPostComment();
            
            ArrayList<DTOPost> listPosts = boPost.getAllPostsOfUser(Integer.parseInt(userId));
            
            if (listPosts != null && !listPosts.isEmpty()) {
                Map<Integer, Integer> countLike = new HashMap<>();
                Map<Integer, Integer> countComment = new HashMap<>();
                
                for (DTOPost post : listPosts) {
                    ArrayList<DTOPostLike> likesOfPost = likeBO.getAllLikesOfPost(post.getPostId());
                    ArrayList<DTOPostComment> commentsOfPost = commentBO.getAllCommentsForPost(post.getPostId());
                    
                    countLike.put(post.getPostId(), likesOfPost.size());
                    countComment.put(post.getPostId(), commentsOfPost.size());
                }
                
                request.setAttribute("countLike", countLike);
                request.setAttribute("countComment", countComment);
            }                        
            
            request.setAttribute("listPosts", listPosts);
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/User/userProfile.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Profile Servlet";
    }// </editor-fold>

}
