/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Series;

import BO.BOPost;
import BO.BOUser;
import BO.BOUserSeriesList;
import Beans.SessionBeanUserSeriesList;
import DTO.DTOPost;
import DTO.DTOUser;
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

/**
 *
 * @author TranCamTu
 */
public class SeriesListPostServlet extends HttpServlet {

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
                    
        if (request.getParameter("id") != null) {
            String seriesId = request.getParameter("id");
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            DTOUserSeriesList seriesDTO = seriesBO.getSeriesInformation(Integer.parseInt(seriesId));
            
            if (seriesDTO != null) {
                SessionBeanUserSeriesList seriesBean = new SessionBeanUserSeriesList();
                seriesBean.initFromDTO(seriesDTO);
                
                request.setAttribute("seriesBean", seriesBean);
            } else {
                request.setAttribute("seriesBean", null);
            }
            
            BOPost postBO = new BOPost();
            ArrayList<DTOPost> postList = postBO.getAllPostsOfSeries(Integer.parseInt(seriesId));
            
            if (postList != null && !postList.isEmpty()) {
                Map<Integer, DTOUser> authorOfPost = new HashMap();
                Map<Integer, DTOUserSeriesList> seriesOfPost = new HashMap();
                BOUser userBO = new BOUser();
                
                for (DTOPost post : postList) {
                    DTOUser authorDTO = userBO.getUserInformation(post.getUserId());
                    DTOUserSeriesList series = seriesBO.getSeriesInformation(post.getSeriesId());
                    
                    authorOfPost.put(post.getPostId(), authorDTO);
                    seriesOfPost.put(post.getPostId(), series);
                }

                request.setAttribute("authorOfPost", authorOfPost);
                request.setAttribute("seriesOfPost", seriesOfPost);
            }
            
            request.setAttribute("listPosts", postList);
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Series/seriesListPost.jsp");
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
        return "Posts of series servlet";
    }// </editor-fold>

}
