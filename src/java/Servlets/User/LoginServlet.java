/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.User;

import BO.BOUser;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DataAccess.MySqlConnection;
import Beans.SessionBeanUser;
import DTO.DTOUser;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
/**
 *
 * @author TranCamTu
 */

public class LoginServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        RequestDispatcher rd = request.getRequestDispatcher("/Views/User/login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        if (request.getParameter("email") == null || request.getParameter("password") == null) {
            RequestDispatcher rd = request.getRequestDispatcher("/Views/User/login.jsp");
            rd.forward(request, response);
        } else {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            DTOUser userDTO = new DTOUser();
            
            userDTO.setEmail(email);
            userDTO.setPassword(password);
            
            if (email.isEmpty() || password.isEmpty()) {
                request.setAttribute("isInvalid", true);
                request.setAttribute("userDTO", userDTO);
                
                RequestDispatcher rd = request.getRequestDispatcher("/Views/User/login.jsp");
                rd.forward(request, response);
            } else {
                BOUser userBO = new BOUser();
                
                if (userBO.login(email, password)) {
                    request.setAttribute("isInvalid", false);
                    
                    SessionBeanUser userBean = new SessionBeanUser();
                    
                    userDTO = userBO.getUserInformation(email);
                    userBean.initFromDTO(userDTO);
                           
                    HttpSession session = request.getSession(true);
                    
                    session.setAttribute("userBean", userBean);
                    
                    response.sendRedirect(getServletContext().getContextPath() + "/user/profile?id=" + userBean.getUserId());
                } else {
                    request.setAttribute("isInvalid", true);
                    request.setAttribute("userDTO", userDTO);
                    request.setAttribute("message", "Email hoặc mật khẩu sai");

                    RequestDispatcher rd = request.getRequestDispatcher("/Views/User/login.jsp");
                    rd.forward(request, response);
                }
            }
        }         
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }// </editor-fold>

}
