/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.User;

import BO.BOUser;
import Beans.SessionBeanUser;
import DTO.DTOUser;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author TranCamTu
 */
public class UserEditProfileServlet extends HttpServlet {

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
        
        if (session.getAttribute("userBean") != null) {
            RequestDispatcher rd = request.getRequestDispatcher("/Views/User/userEditProfile.jsp");
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
        SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");

        if (userBean != null) {
            String fullname;
            String password;
            String confirmPassword;
            String avatar;
            String bio;
           
            int count = 0;
                        
            if (request.getParameter("fullname") != null && !request.getParameter("fullname").isEmpty()) {
                fullname = request.getParameter("fullname");
            } else {
                fullname = userBean.getFullname();
            }

            if (request.getParameter("bio") != null && !request.getParameter("bio").isEmpty()) {
                bio = request.getParameter("bio");
            } else {
                bio = userBean.getBio();
            }

            if (request.getParameter("password") != null && !request.getParameter("password").isEmpty()) {
                password = request.getParameter("password");
            } else {
                password = userBean.getPassword();
            }
            
            if (request.getParameter("confirmPassword") != null && !request.getParameter("confirmPassword").isEmpty()) {
                confirmPassword = request.getParameter("confirmPassword");
            } else {
                confirmPassword = "";
                count++;
            }

            DTOUser userDTO = new DTOUser();

            userDTO.setFullname(fullname);
            userDTO.setPassword(password);
            userDTO.setRole(1);
            userDTO.setBio(bio);
            userDTO.setUserId(userBean.getUserId());

            Part filePart = request.getPart("avatar");

            if (filePart != null) {
                avatar = filePart.getSubmittedFileName();
                
                String uploadPath = getServletContext().getRealPath("/Resources/img") + File.separator + String.valueOf(userBean.getUserId());
                File fileDir = new File(uploadPath);
                System.out.println("upload path " + uploadPath);
                System.out.println("file dir " + fileDir.getAbsolutePath());
                if (!fileDir.exists()) {
                    System.out.println("fileDir not exists");
                    if (fileDir.mkdirs()) {
                        System.out.println("Make director success: " + fileDir.getAbsolutePath());
                    } else {
                        System.out.println("Make director fail");
                    }
                } else {
                    System.out.println("fileDir exists");
                }

                InputStream fileContent = filePart.getInputStream();
                Files.copy(fileContent, Paths.get(fileDir + File.separator + avatar), StandardCopyOption.REPLACE_EXISTING);

            } else {
                avatar = userBean.getAvatar();
            }            
            
            userDTO.setAvatar(avatar);

            if (count == 0) {
                BOUser userBO = new BOUser();

                if (userBO.updateUserInfo(userDTO)) {
                    userDTO = userBO.getUserInformation(userBean.getUserId());
                    userBean.initFromDTO(userDTO);

                    session.setAttribute("userBean", userBean);

                    response.sendRedirect(getServletContext().getContextPath() + "/user/profile?id=" + userBean.getUserId());
                } else {
                    request.setAttribute("message", "Đã có lỗi xảy ra.");
                    request.setAttribute("userDTO", userDTO);
                    request.setAttribute("confirmPassword", confirmPassword);
                    request.setAttribute("isInvalid", true);

                    RequestDispatcher rd = request.getRequestDispatcher("/Views/User/userEditProfile.jsp");
                    rd.forward(request, response);
                }
            } else {
                request.setAttribute("isExisting", false);
                request.setAttribute("userDTO", userDTO);
                request.setAttribute("confirmPassword", confirmPassword);
                request.setAttribute("isInvalid", true);

                RequestDispatcher rd = request.getRequestDispatcher("/Views/User/userEditProfile.jsp");
                rd.forward(request, response);
            }
        } else {
            response.sendRedirect(getServletContext().getContextPath() + "/user/login");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "User edit profile servlet";
    }// </editor-fold>

}
