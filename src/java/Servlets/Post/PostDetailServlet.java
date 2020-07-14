/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPost;
import BO.BOUser;
import BO.BOUserSeriesList;
import Beans.SessionBeanPost;
import Beans.SessionBeanUser;
import Beans.SessionBeanUserSeriesList;
import DTO.DTOPost;
import DTO.DTOUser;
import DTO.DTOUserSeriesList;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author TranCamTu
 */
public class PostDetailServlet extends HttpServlet {

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
        System.out.println("Do get, post detail, request uri: " + request.getRequestURI());
        System.out.println("Do get, post detail, servlet context path: " + getServletContext().getContextPath());
        System.out.println("Do get, post detail, params: " + request.getQueryString());
        System.out.println("Do get, post detail, request context path: " + request.getContextPath());
        SessionBeanPost postBean = null;
        
        if (request.getParameter("%") != null && request.getParameter("title") != null) {
            String postId = request.getParameter("%");
            String postTitleUnsigned = request.getParameter("title");
            
            BOPost postBO = new BOPost();
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            BOUser userBO = new BOUser();        

            DTOPost postDTO = postBO.getPostInformation(Integer.parseInt(postId), postTitleUnsigned);
        
            if (postDTO != null) {
                DTOUserSeriesList seriesDTO = seriesBO.getSeriesInformation(postDTO.getSeriesId());
                DTOUser userDTO = userBO.getUserInformation(postDTO.getUserId());
                ArrayList<DTOPost> postsOfSeries = postBO.getAllPostsOfSeries(postDTO.getSeriesId());
                ArrayList<DTOPost> postsOfUser = postBO.getPostsOfUser(postDTO.getUserId(), 5);


                SessionBeanUserSeriesList seriesBean = new SessionBeanUserSeriesList();
                SessionBeanUser userBean = new SessionBeanUser();

                postBean = new SessionBeanPost();
                postBean.initFromDTO(postDTO);
                userBean.initFromDTO(userDTO);

                if (seriesDTO != null) {
                    seriesBean.initFromDTO(seriesDTO);
                } else {
                    seriesBean = null;
                }

                request.setAttribute("seriesBean", seriesBean);
                request.setAttribute("userBean", userBean);
                request.setAttribute("postsOfSeries", postsOfSeries);
                request.setAttribute("postsOfUser", postsOfUser);
            }
        }
        
        request.setAttribute("postBean", postBean);
        
        RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postDetail.jsp");
        rd.include(request, response);
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
