/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Home;

import BO.BOPost;
import BO.BOPostComment;
import BO.BOPostLike;
import BO.BOTagList;
import BO.BOUser;
import BO.BOUserSeriesList;
import DTO.DTOPost;
import DTO.DTOTagList;
import DTO.DTOUser;
import DTO.DTOUserSeriesList;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
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
 * @author Tin Bui
 */
public class HomeServlet extends HttpServlet {

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
        
        BOTagList tagBO = new BOTagList();
        BOPost postBO = new BOPost();
        BOUser userBO = new BOUser();
        BOPostLike likeBO = new BOPostLike();
        BOPostComment commentBO = new BOPostComment();
        BOUserSeriesList seriesBO = new BOUserSeriesList();
        
        ArrayList<DTOTagList> top10Tags = tagBO.getTopNumberOfTags(10);
        ArrayList<DTOPost> top3LikePosts = postBO.getTopLikePosts(3);
        ArrayList<DTOPost> top4NewPosts = postBO.getTopNewPosts(4);
        ArrayList<DTOUserSeriesList> top6RandomSeriesList = seriesBO.getTopRandomList(6);
                
        Map<Integer, ArrayList<DTOPost>> top3PostsOfRandomSeries = new HashMap();
        
        for (DTOUserSeriesList series : top6RandomSeriesList) {
            ArrayList<DTOPost> top3Posts = postBO.getTopPostsOfSeries(series.getSeriesId(), 3);
            top3PostsOfRandomSeries.put(series.getSeriesId(), top3Posts);
        }
        
        ArrayList<DTOPost> allPosts = postBO.getAllPosts();
        Map<Integer, DTOUser> authorOfPost = new HashMap();
        Map<Integer, Integer> countLikeOfPost = new HashMap();
        Map<Integer, Integer> countCommentOfPost = new HashMap();
        
        for (DTOPost post : allPosts) {
            DTOUser author = userBO.getUserInformation(post.getUserId());
            int postId = post.getPostId();
            
            authorOfPost.put(postId, author);
            countLikeOfPost.put(postId, likeBO.getAllLikesOfPost(postId).size());
            countCommentOfPost.put(postId, commentBO.getAllCommentsForPost(postId).size());
        }
        
        request.setAttribute("top10Tags", top10Tags);
        request.setAttribute("top3LikePosts", top3LikePosts);
        request.setAttribute("top4NewPosts", top4NewPosts);
        request.setAttribute("top6RandomSeriesList", top6RandomSeriesList);
        request.setAttribute("top3PostsOfRandomSeries", top3PostsOfRandomSeries);
        request.setAttribute("authorOfPost", authorOfPost);
        request.setAttribute("countLikeOfPost", countLikeOfPost);
        request.setAttribute("countCommentOfPost", countCommentOfPost);
        
        RequestDispatcher rd = request.getRequestDispatcher("/Views/Shared/home.jsp");
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
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Homepage Servlet";
    }// </editor-fold>

}
