/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Series;

import BO.BOUserSeriesList;
import Beans.SessionBeanUser;
import DTO.DTOUserSeriesList;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TranCamTu
 */
public class SeriesCreateServlet extends HttpServlet {

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
        ArrayList<DTOUserSeriesList> seriesList = new ArrayList();

        if (request.getParameter("seriesName") != null && !request.getParameter("seriesName").isEmpty()) {
            if (session.getAttribute("userBean") == null) {
                request.setAttribute("message", "Vui lòng đăng nhập để thực hiện tác vụ này.");
            } else {
                SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
                String seriesName = request.getParameter("seriesName");

                DTOUserSeriesList seriesDTO = new DTOUserSeriesList();
                seriesDTO.setSeriesName(seriesName);
                seriesDTO.setUserId(userBean.getUserId());

                BOUserSeriesList seriesBO = new BOUserSeriesList();
//                if (seriesBO.insertNewUserSeriesList(seriesDTO)) {
//                    seriesList = seriesBO.getUserLists(userBean.getUserId());
//                }
                seriesList = seriesBO.getUserLists(userBean.getUserId());
            }
        }
        
        Gson gson = new Gson();
        String json = gson.toJson(seriesList);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
