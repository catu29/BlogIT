/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPost;
import BO.BOPostComment;
import BO.BOPostLike;
import BO.BOPostReport;
import BO.BOPostTag;
import Beans.SessionBeanUser;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TranCamTu
 */
public class PostDeleteServlet extends HttpServlet {

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
        
        HttpSession session = request.getSession(true);
        
        if (session.getAttribute("userBean") != null && request.getParameter("postId") != null && !request.getParameter("postId").isEmpty()) {
            SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            BOPost postBO = new BOPost();
            BOPostTag tagBO = new BOPostTag();
            BOPostLike likeBO = new BOPostLike();
            BOPostComment commentBO = new BOPostComment();
            BOPostReport reportBO = new BOPostReport();
            
            if (postBO.deletePost(postId)) {
                System.out.println("Delete post " + postId + " succeed");
                
                if (tagBO.deleteTagForPost(postId)) {
                    System.out.println("Delete tag for post " + postId + " succeed");
                }
                
                if (likeBO.deleteLike(postId, userBean.getUserId())) {
                    System.out.println("Delete like for post " + postId + " succeed");
                }
                
                if (commentBO.deleteAllCommentsOfPost(postId)) {
                    System.out.println("Delete all comments for post " + postId + " succeed");
                }
                
                // TODO: delete all reports of post
            } else {
                System.out.println("Delete post " + postId + " fail");
            }
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
        return "Short description";
    }// </editor-fold>

}
