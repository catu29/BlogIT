/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Series;

import BO.BOUserSeriesList;
import DTO.DTOUserSeriesList;
import java.io.IOException;
import java.io.PrintWriter;
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
public class SeriesUpdateServlet extends HttpServlet {

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
        
        if (session.getAttribute("userBean") != null && request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            int seriesId = Integer.parseInt(request.getParameter("id"));
            
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            DTOUserSeriesList seriesDTO = seriesBO.getSeriesInformation(seriesId);
            
            request.setAttribute("seriesDTO", seriesDTO);
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Series/seriesUpdate.jsp");
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
        
        HttpSession session = request.getSession(true);
        
        if (session.getAttribute("userBean") != null) {
            int seriesId = -1;
            String seriesName;
            
            if (request.getParameter("seriesId") != null && !request.getParameter("seriesId").trim().isEmpty()) {
                Integer.parseInt(request.getParameter("seriesId"));
            } else {
                return;
            }
            
            if (request.getParameter("seriesName") != null && !request.getParameter("seriesName").trim().isEmpty()) {
                seriesName = request.getParameter("seriesName");
            } else {
                return;
            }
            
            DTOUserSeriesList series = new DTOUserSeriesList();
            series.setSeriesId(seriesId);
            series.setSeriesName(seriesName);
            
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            
            seriesBO.updateUserSeriesListName(series);
            
            response.sendRedirect(getServletContext().getContextPath() + "/user/manage-series");
        }
            
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
