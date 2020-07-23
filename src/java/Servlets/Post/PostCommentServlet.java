/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPostComment;
import BO.BOPostLike;
import Beans.SessionBeanUser;
import DTO.DTOPostComment;
import DTO.DTOPostLike;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TranCamTu
 */
public class PostCommentServlet extends HttpServlet {

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
        
        HttpSession session = request.getSession(true);
        SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
        
        String result;
        
        if (request.getParameter("message") == null|| request.getParameter("message").trim().isEmpty()){
            result = "failed";
        } 
        else if (userBean != null && request.getParameter("postId") != null) {
            String postId = request.getParameter("postId");
            String message = request.getParameter("message");
            Date date = new Date();
            int parentId;
            
            if (request.getParameter("parentId") == null) {
                parentId = 0;
            } else {
                parentId = Integer.parseInt(request.getParameter("parentId"));
            }
            
            DTOPostComment commentDTO = new DTOPostComment();
            commentDTO.setPostId(Integer.parseInt(postId));
            commentDTO.setUserId(userBean.getUserId());
            commentDTO.setContent(message);
            commentDTO.setCommentTime(date);
            commentDTO.setParentId(parentId);
            
            BOPostComment commentBO = new BOPostComment();
            
            if (commentBO.insertCommentForPost(commentDTO)) {
                result = "succeeded";
            } else {
                result = "failed";
            }
        } else {
            if (userBean == null) {
                System.out.println("User bean null");
            }
            
            if (request.getParameter("postId") == null) {
                System.out.println("Post id null");
            }
                        
            result = "failed";
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Post comment servlet";
    }// </editor-fold>

}