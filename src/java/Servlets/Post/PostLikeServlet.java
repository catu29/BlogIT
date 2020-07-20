/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPostLike;
import Beans.SessionBeanUser;
import DTO.DTOPostLike;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.Instant;
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
public class PostLikeServlet extends HttpServlet {

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
        SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
        
        if (userBean != null & request.getParameter("postId") != null && request.getParameter("userId") != null) {
            String postId = request.getParameter("postId");
            String userId = request.getParameter("userId");                         
            Date date = new Date();
            
            DTOPostLike likeDTO = new DTOPostLike(Integer.parseInt(postId), Integer.parseInt(userId), date);
            BOPostLike likeBO = new BOPostLike();
            
            boolean isLiked = likeBO.isLiked(Integer.parseInt(postId), Integer.parseInt(userId));
            String result;

            if (!isLiked) {
                if (likeBO.insertNewLike(likeDTO)) {
                    System.out.println("Like succeeded");
                    result = "LikeSucceeded";
                } else {
                    System.out.println("Like failed");
                    result = "LikeFailed";
                }
            } else {
                if (likeBO.deleteLike(Integer.parseInt(postId), Integer.parseInt(userId))) {
                    System.out.println("Dislike succeeded");
                    result = "DislikeSucceeded";
                } else {
                    System.out.println("Dislike failed");
                    result = "DislikeFailed";
                }
            }
                        
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(result);
        } else {
            if (userBean == null) {
                System.out.println("User bean null");
            }
            
            if (request.getParameter("postId") == null) {
                System.out.println("Post id null");
            }
            
            if (request.getParameter("userId") == null) {
                System.out.println("User id null");
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
