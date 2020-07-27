/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPostTag;
import BO.BOTagList;
import BO.BOUser;
import BO.BOUserSeriesList;
import Beans.SessionBeanTagList;
import DTO.DTOPost;
import DTO.DTOTagList;
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
public class PostsOfTagServlet extends HttpServlet {

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

        if (request.getParameter("id") != null) {
            String tagId = request.getParameter("id");

            BOTagList listBO = new BOTagList();
            BOPostTag tagBO = new BOPostTag();
            BOUser userBO = new BOUser();

            DTOTagList listDTO = listBO.searchTagById(tagId);
            ArrayList<DTOPost> postsOfTag = tagBO.getAllPostsForTag(tagId);

            SessionBeanTagList tagBean = new SessionBeanTagList();

            if (listDTO != null) {
                tagBean.initFromDTO(listDTO);
                request.setAttribute("mainName", tagBean.getTagName());
            } else {
                tagBean = null;
            }

            if (postsOfTag != null && !postsOfTag.isEmpty()) {
                Map<Integer, DTOUser> authorOfPost = new HashMap();
                Map<Integer, DTOUserSeriesList> seriesOfPost = new HashMap();

                BOUserSeriesList seriesBO = new BOUserSeriesList();
                
                for (DTOPost post : postsOfTag) {
                    DTOUser authorDTO = userBO.getUserInformation(post.getUserId());
                    authorOfPost.put(post.getPostId(), authorDTO);
                    
                    DTOUserSeriesList series = seriesBO.getSeriesInformation(post.getSeriesId());
                    seriesOfPost.put(post.getPostId(), series);
                }

                request.setAttribute("authorOfPost", authorOfPost);
                request.setAttribute("seriesOfPost", seriesOfPost);
            }

            request.setAttribute("mainBean", tagBean);
            request.setAttribute("listPosts", postsOfTag);

            RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postsOfTag.jsp");
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
        return "Post of tag servlet";
    }// </editor-fold>

}
