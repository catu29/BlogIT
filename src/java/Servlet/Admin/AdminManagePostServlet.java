/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet.Admin;

import BO.BOPost;
import BO.BOPostComment;
import BO.BOPostLike;
import BO.BOUser;
import BO.BOUserSeriesList;
import Beans.SessionBeanUser;
import DTO.DTOPost;
import DTO.DTOPostComment;
import DTO.DTOUser;
import DTO.DTOPostLike;
import DTO.DTOUserSeriesList;
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

public class AdminManagePostServlet extends HttpServlet {

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
        
        if (session.getAttribute("userBean") != null) {
            SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
              
            BOPost boPost = new BOPost();
            BOPostLike likeBO = new BOPostLike();
            BOPostComment commentBO = new BOPostComment();
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            BOUser userBO = new BOUser();
            
            ArrayList<DTOPost> listPosts = boPost.getAllPosts();
            
            if (listPosts != null && !listPosts.isEmpty()) {
                Map<Integer, Integer> countLike = new HashMap();
                Map<Integer, Integer> countComment = new HashMap();
                Map<Integer, DTOUserSeriesList> seriesList = new HashMap();
                Map<Integer, DTOUser> authorList = new HashMap();
                
                for (DTOPost post : listPosts) {
                    ArrayList<DTOPostLike> likesOfPost = likeBO.getAllLikesOfPost(post.getPostId());
                    ArrayList<DTOPostComment> commentsOfPost = commentBO.getAllCommentsForPost(post.getPostId());
                    DTOUserSeriesList seriesDTO = seriesBO.getSeriesInformation(post.getSeriesId());
                    DTOUser userDTO = userBO.getUserInformation(post.getUserId());
                    
                    countLike.put(post.getPostId(), likesOfPost.size());
                    countComment.put(post.getPostId(), commentsOfPost.size());
                    seriesList.put(post.getPostId(), seriesDTO);
                    authorList.put(post.getPostId(), userDTO);
                }
                
                request.setAttribute("countLike", countLike);
                request.setAttribute("countComment", countComment);
                request.setAttribute("seriesList", seriesList);
                request.setAttribute("authorList", authorList);
            }                        
            
            request.setAttribute("listPosts", listPosts);
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Admin/adminManagePosts.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect(getServletContext().getContextPath() + "/user/login");
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
