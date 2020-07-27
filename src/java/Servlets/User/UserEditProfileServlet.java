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
            String avatar;
            String bio;
            
            if (request.getParameter("fullname") != null && !request.getParameter("fullname").isEmpty() && !request.getParameter("fullname").trim().isEmpty()) {
                fullname = request.getParameter("fullname");
            } else {
                fullname = userBean.getFullname();
            }

            if (request.getParameter("bio") != null && !request.getParameter("bio").isEmpty() && !request.getParameter("bio").trim().isEmpty()) {
                bio = request.getParameter("bio");
            } else {
                bio = userBean.getBio();
            }
            
            Part filePart = request.getPart("avatar");

            if (filePart != null) {
                avatar = filePart.getSubmittedFileName();
                
                if (!avatar.trim().isEmpty()) {
                    String realPath = getServletContext().getRealPath("");
                
                    // buildLocation use for displaying immediately when changes had occured, this value is temporary and will change at next build-time
                    String buildLocation = realPath + getServletContext().getInitParameter("upload.location") + String.valueOf(userBean.getUserId()) + File.separator;
                    File buildFileDir = new File(buildLocation);

                    if (!buildFileDir.exists()) {
                        if (buildFileDir.mkdirs()) {
                            System.out.println("Make director on build success: " + buildFileDir.getAbsolutePath());
                        } else {
                            System.out.println("Make director on build fail");
                        }
                    }

                    String savePath = realPath.replace("\\build\\web\\", "\\web");

                    // saveLocation use for save permanently data in application context
                    String saveLocation = savePath + getServletContext().getInitParameter("upload.location") + String.valueOf(userBean.getUserId()) + File.separatorChar;
                    File saveFileDir = new File(saveLocation);

                    if (!saveFileDir.exists()) {
                        if (saveFileDir.mkdirs()) {
                            System.out.println("Make wep application director success: " + saveFileDir.getAbsolutePath());
                        } else {
                            System.out.println("Make wep application director fail");
                        }
                    }

                    InputStream fileContent = filePart.getInputStream();
                    Files.copy(fileContent, Paths.get(buildFileDir + File.separator + avatar), StandardCopyOption.REPLACE_EXISTING);
                    Files.copy(fileContent, Paths.get(saveFileDir + File.separator + avatar), StandardCopyOption.REPLACE_EXISTING);
                } else {
                    avatar = userBean.getAvatar();
                }
            } else {
                avatar = userBean.getAvatar();
            }
            
            DTOUser userDTO = new DTOUser();

            userDTO.setFullname(fullname);
            userDTO.setBio(bio);
            userDTO.setAvatar(avatar);
            userDTO.setUserId(userBean.getUserId());

            BOUser userBO = new BOUser();
            System.out.println(userBean.getUserId());
            if (userBO.updateUserInfo(userDTO)) {
                request.setAttribute("isInvalid", false);
                
                userDTO = userBO.getUserInformation(userBean.getUserId());
                userBean.initFromDTO(userDTO);

                session.setAttribute("userBean", userBean);

                response.sendRedirect(getServletContext().getContextPath() + "/user/profile?id=" + userBean.getUserId());
            } else {
                request.setAttribute("message", "Đã có lỗi xảy ra.");
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
