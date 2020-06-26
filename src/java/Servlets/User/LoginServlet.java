/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.User;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DataAccess.MySqlConnection;
import Beans.BeanUser;
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
    private BeanUser user;
    private boolean isLogined = false;
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        user = new BeanUser();
        
        if (request.getParameter("email") != null) {
            user.setEmail(request.getParameter("email"));
        }
        
        if (request.getParameter("password") != null) {
            user.setPassword(request.getParameter("password"));
        }
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
        
        int count = 0;
        String query = "Select * From UserInfo Where email='" + user.getEmail() + "' and pass='" + user.getPassword() +"';";
        MySqlConnection mySql = new MySqlConnection();
        Connection connection = mySql.getDataConnection();
        Statement stmt = null;
        
        try {
            stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                count++;
            }
                        
            stmt.close();
            stmt = null;
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
            count = -1;
        }
        
        if (count == 1)
        {
            isLogined = true;
        } else { 
            isLogined = false;
        }
        
        HttpSession session = request.getSession(true);
        session.setAttribute("isLogined", isLogined);
        
        RequestDispatcher rd = request.getRequestDispatcher("Views/User/login.jsp");
        rd.forward(request, response);
        
        // System.out.println("Login Servlet");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
