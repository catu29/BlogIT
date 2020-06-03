/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author TranCamTu
 */
package Filters.Register;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class RegisterFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("egister Filter inited !");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String username;
        String password;
        
        if (request.getParameter("username") != null) {
            username = request.getParameter("username");
        } else {
            username = "";
        }
        
        if (request.getParameter("password") != null) {
            password = request.getParameter("password");
        } else {
            password = "";
        }
        
        if (username.equals("user") && password.equals("password")) {
            RequestDispatcher view = request.getRequestDispatcher("Views/User/testFilter.jsp");
            view.forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        
    }
    
}
