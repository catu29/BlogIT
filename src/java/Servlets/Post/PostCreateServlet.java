/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPost;
import BO.BOPostTag;
import BO.BOTagList;
import BO.BOUserSeriesList;
import Beans.SessionBeanUser;
import DTO.DTOPost;
import DTO.DTOPostTag;
import DTO.DTOTagList;
import DTO.DTOUserSeriesList;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Tin Bui
 */
@MultipartConfig
public class PostCreateServlet extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        
        if (session.getAttribute("userBean") == null) {
            request.setAttribute("message", "Vui lòng đăng nhập");
        } else {
            SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
            BOUserSeriesList seriesBO = new BOUserSeriesList();
            BOTagList tagBO = new BOTagList();
            BOPost postBO = new BOPost();
            
            ArrayList<DTOUserSeriesList> userSeriesList = seriesBO.getUserLists(userBean.getUserId());
            ArrayList<DTOTagList> listTags = tagBO.getAllTags();
            ArrayList<DTOPost> listPosts = postBO.getAllPostsOfUser(userBean.getUserId());
            
            request.setAttribute("userSeriesList", userSeriesList);
            request.setAttribute("listTags", listTags);
            request.setAttribute("listPosts", listPosts);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postCreate.jsp");
        rd.forward(request, response);
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
            SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
            
            String title;
            String tags[];
            String series;
            String seriesOrder;
            String image;
            String description;
            String content;
            
            int count = 0;
                                              
            if (request.getParameter("title") != null && !request.getParameter("title").isEmpty()) {
                title = request.getParameter("title");
                System.out.println("title " + title);
            } else {
                title = "";
                count++;
            }
            
            if (request.getParameterValues("tags") != null && request.getParameterValues("tags").length != 0) {
                tags = request.getParameterValues("tags");  
                System.out.println("tag " + tags[0]);
            } else {
                tags = null;
                count++;
            }   
            
            if (request.getParameter("description") != null && !request.getParameter("description").isEmpty()) {
                description = request.getParameter("description");
                System.out.println("des " + description);
            } else {
                description = "";
                count++;
            }
            
            if (request.getParameter("content") != null && !request.getParameter("content").isEmpty()) {
                content = request.getParameter("content");
                System.out.println("content " + content);
            } else {
                content = "";
                count++;
            }
            
            DTOPost postDTO = new DTOPost();            
            Date createTime = new Date();
            
            postDTO.setPostTitle(title);
            postDTO.setUserId(userBean.getUserId());
            postDTO.setPostSubTitle(description);
            postDTO.setPostContent(content);
            postDTO.setPostTime(createTime);
            
            if (request.getParameter("series") != null && !request.getParameter("series").isEmpty()) {
                series = request.getParameter("series");
                postDTO.setSeriesId(Integer.parseInt(series));
                
                if (request.getParameter("seriesOrder") != null && !request.getParameter("seriesOrder").isEmpty()) {
                    seriesOrder = request.getParameter("seriesOrder");
                    postDTO.setSeriesOrder(Integer.parseInt(seriesOrder));
                } else {
                    seriesOrder = "";
                    postDTO.setSeriesOrder(0);
                }
            } else {
                series = "";
                seriesOrder = "";
                postDTO.setSeriesOrder(0);
                postDTO.setSeriesId(0);
            }
            
            
                                    
            Part filePart = request.getPart("image");
            if (filePart != null) {                
                image = filePart.getSubmittedFileName();
            } else {
                image = "";
                count++;
            }
                        
            if (count == 0) {
                request.setAttribute("isInvalide", false);
                
                DTOUserSeriesList seriesDTO = new DTOUserSeriesList();
                ArrayList<DTOPostTag> postTagDTO = new ArrayList();
                
                BOPost postBO = new BOPost();
                BOPostTag postTagBO = new BOPostTag();
                BOUserSeriesList seriesBO = new BOUserSeriesList();
                                
                String realPath = getServletContext().getRealPath("");
                
                // buildLocation use for displaying immediately when changes had occured, this value is temporary and will change at next build-time
                String buildLocation = realPath + getServletContext().getInitParameter("upload.location") + String.valueOf(userBean.getUserId()) + File.separator;
                File builFileDir = new File(buildLocation);
                
                if (!builFileDir.exists()) {
                    if (builFileDir.mkdirs()) {
                        System.out.println("Make director on build success: " + builFileDir.getAbsolutePath());
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
                Files.copy(fileContent, Paths.get(builFileDir + File.separator + image), StandardCopyOption.REPLACE_EXISTING);
                Files.copy(fileContent, Paths.get(saveFileDir + File.separator + image), StandardCopyOption.REPLACE_EXISTING);
                
                postDTO.setImage(image);
                
                if (postBO.insertNewPost(postDTO)) {
                    if (tags != null) {
                        DTOPost post = postBO.getLatestUserPostInformation(userBean.getUserId());
                        postTagBO.addTagForPost(post.getPostId(), tags);
                    }
                }
                
                response.sendRedirect(getServletContext().getContextPath() + "/user/manage-post");
            } else {
                request.setAttribute("postDTO", postDTO);
                request.setAttribute("isInvalide", true);
                
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postCreate.jsp");
                rd.forward(request, response);
            }
        } else {
            session.setAttribute("message", "Vui lòng đăng nhập");
            
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postCreate.jsp");
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
        return "Create Post Servlet";
    }// </editor-fold>

}
