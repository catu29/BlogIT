/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.User;

import BO.BOUser;
import Beans.SessionBeanUser;
import DTO.DTOUser;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tin Bui
 */
public class RegisterServlet extends HttpServlet {
    
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
        HttpSession session = request.getSession(true);
        
        RequestDispatcher rd = request.getRequestDispatcher("/Views/User/register.jsp");
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
        HttpSession session = request.getSession(true);        
        
        String email;
        String fullname;
        String password;
        String confirmPassword;
        
        int count = 0;
        
        if (request.getParameter("email") != null && !request.getParameter("email").isEmpty()) {
            email = request.getParameter("email");
        } else {
            email = "";
            count++;
        }
        
        if (request.getParameter("fullname") != null && !request.getParameter("fullname").isEmpty()) {
            fullname = request.getParameter("fullname");
        } else {
            fullname = "";
            count++;
        }
        
        if (request.getParameter("password") != null && !request.getParameter("password").isEmpty()) {
            password = request.getParameter("password");
        } else {
            password = "";
            count++;
        }
        
        if (request.getParameter("confirmPassword") != null && !request.getParameter("confirmPassword").isEmpty()) {
            confirmPassword = request.getParameter("confirmPassword");
        } else {
            confirmPassword = "";
            count++;
        }
        
        DTOUser userDTO = new DTOUser();
                
        userDTO.setEmail(email);
        userDTO.setFullname(fullname);
        userDTO.setPassword(password);
        userDTO.setRole(0);
            
        if (count == 0) {            
            BOUser userBO = new BOUser();
                        
            if (userBO.isExisting(email)) {
                request.setAttribute("isExisting", true);                        
                request.setAttribute("userDTO", userDTO);
                request.setAttribute("confirmPassword", confirmPassword);
                request.setAttribute("isInvalid", true);
                
                RequestDispatcher rd = request.getRequestDispatcher("/Views/User/register.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("isExisting", false);                
                
                if (userBO.insertNewUser(userDTO)) {
                    SessionBeanUser userBean = new SessionBeanUser();
                    userDTO = userBO.getUserInformation(email);                    
                    userBean.initFromDTO(userDTO);
                    
                    session.setAttribute("userBean", userBean);
                    
                    response.sendRedirect(getServletContext().getContextPath() + "/user/profile?id=" + userBean.getUserId());
                    
                } else {
                    request.setAttribute("message", "Đã có lỗi xảy ra.");             
                    request.setAttribute("userDTO", userDTO);
                    request.setAttribute("confirmPassword", confirmPassword);
                    request.setAttribute("isInvalid", true);
                            
                    RequestDispatcher rd = request.getRequestDispatcher("/Views/User/register.jsp");
                    rd.forward(request, response);
                }
            }
        } else {
            request.setAttribute("isExisting", false);                        
            request.setAttribute("userDTO", userDTO);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("isInvalid", true);
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/User/register.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Register Servlet";
    }// </editor-fold>

    private SessionBeanUser lookupSessionBeanUserBean() {
        try {
            Context c = new InitialContext();
            return (SessionBeanUser) c.lookup("java:global/BlogIT/SessionBeanUser!Beans.SessionBeanUser");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

}
