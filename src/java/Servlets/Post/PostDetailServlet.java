/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Post;

import BO.BOPost;
import BO.BOPostComment;
import BO.BOPostLike;
import BO.BOPostTag;
import BO.BOUser;
import BO.BOUserSeriesList;
import Beans.SessionBeanPost;
import Beans.SessionBeanUser;
import Beans.SessionBeanUserSeriesList;
import DTO.DTOPost;
import DTO.DTOPostComment;
import DTO.DTOPostLike;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author TranCamTu
 */
public class PostDetailServlet extends HttpServlet {

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
        
        SessionBeanPost postBean = null;
        
        if (request.getParameter("%") != null && request.getParameter("name") != null) {
            String postId = request.getParameter("%"); // postId
            String postTitleUnsigned = request.getParameter("name"); // postTitleUnsigned
            
            BOPost postBO = new BOPost();       

            DTOPost postDTO = postBO.getPostInformation(Integer.parseInt(postId), postTitleUnsigned);
        
            if (postDTO != null) {
                BOUserSeriesList seriesBO = new BOUserSeriesList();
                BOUser userBO = new BOUser();
                BOPostLike likeBO = new BOPostLike();
                BOPostComment commentBO = new BOPostComment();
                BOPostTag tagBO = new BOPostTag();
            
                DTOUserSeriesList seriesDTO = seriesBO.getSeriesInformation(postDTO.getSeriesId());
                DTOUser authorDTO = userBO.getUserInformation(postDTO.getUserId());
                
                ArrayList<DTOPost> postsOfSeries = postBO.getAllPostsOfSeries(postDTO.getSeriesId());
                ArrayList<DTOPost> postsOfUser = postBO.getPostsOfUser(postDTO.getUserId(), 5);
                ArrayList<DTOPostLike> likesOfPost = likeBO.getAllLikesOfPost(postDTO.getPostId());
                ArrayList<DTOPostComment> commentsOfPost = commentBO.getAllCommentsForPost(postDTO.getPostId());
                ArrayList<DTOTagList> tagsOfPost = tagBO.getAllTagsForPost(postDTO.getPostId());
                                                
                HttpSession session = request.getSession();

                SessionBeanUserSeriesList seriesBean = new SessionBeanUserSeriesList();
                SessionBeanUser authorBean = new SessionBeanUser();
                SessionBeanUser userBean = (SessionBeanUser) session.getAttribute("userBean");
                postBean = new SessionBeanPost();
                
                postBean.initFromDTO(postDTO);
                authorBean.initFromDTO(authorDTO);
                
                if (likesOfPost != null && !likesOfPost.isEmpty()) {
                    ArrayList<DTOUser> likedUsers = new ArrayList();
                    request.setAttribute("isLiked", false);
                    
                    for (int i = 0; i < likesOfPost.size(); i++) {
                        if (userBean != null && likesOfPost.get(i).getUserId() == userBean.getUserId()) {
                            request.setAttribute("isLiked", true);
                        }
                        
                        DTOUser userLike = userBO.getUserInformation(likesOfPost.get(i).getUserId());
                        likedUsers.add(userLike);
                    }
                    
                    request.setAttribute("likedUsers", likedUsers);
                }
                
                if (commentsOfPost != null && !commentsOfPost.isEmpty()) {
                    Map<Integer, DTOUser> commentedUsers = new HashMap<>();
                   
                    for (int i = 0; i < commentsOfPost.size(); i++) {
                        DTOUser userComment = userBO.getUserInformation(commentsOfPost.get(i).getUserId());
                        commentedUsers.put(commentsOfPost.get(i).getUserId(), userComment);
                    }
                    
                    request.setAttribute("commentedUsers", commentedUsers);
                }

                if (seriesDTO != null) {
                    seriesBean.initFromDTO(seriesDTO);
                } else {
                    seriesBean = null;
                }

                request.setAttribute("seriesBean", seriesBean);
                request.setAttribute("authorBean", authorBean);
                request.setAttribute("postsOfSeries", postsOfSeries);
                request.setAttribute("postsOfUser", postsOfUser);
                
                request.setAttribute("likesOfPost", likesOfPost);
                request.setAttribute("commentsOfPost", commentsOfPost);
                request.setAttribute("tagsOfPost", tagsOfPost);
            }
        }
        
        request.setAttribute("postBean", postBean);
        
        RequestDispatcher rd = request.getRequestDispatcher("/Views/Post/postDetail.jsp");
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Post detail servlet";
    }// </editor-fold>

}
