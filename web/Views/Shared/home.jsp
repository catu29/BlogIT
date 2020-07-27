<%-- 
    Document   : home
    Created on : Jul 28, 2020, 6:00:41 AM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="top10Tags" value="${requestScope.top10Tags}"/>
<c:set var="top3LikePosts" value="${requestScope.top3LikePosts}"/>
<c:set var="top4NewPosts" value="${requestScope.top4NewPosts}"/>
<c:set var="top6RandomSeriesList" value="${requestScope.top6RandomSeriesList}"/>
<c:set var="top3PostsOfRandomSeries" value="${requestScope.top3PostsOfRandomSeries}"/>
<c:set var="authorOfPost" value="${requestScope.authorOfPost}"/>
<c:set var="countLikeOfPost" value="${requestScope.countLikeOfPost}"/>
<c:set var="countCommentOfPost" value="${requestScope.countCommentOfPost}"/>

<t:layout>
    <jsp:attribute name="title">Home</jsp:attribute>
    <jsp:body>
        <div>
            <h2>List tags</h2>
            <c:if test="${top10Tags != null && not empty top10Tags}">
                <c:forEach var="tag" items="${top10Tags}">
                    <p>TagId: ${tag.tagId}</p>
                    <p>TagName: ${tag.tagName}</p>
                </c:forEach>
            </c:if>
        </div>
        <hr>
        <hr>
        <hr>
        <div>
            <h2>Top 3 post nhiều like nhất</h2>
            <c:if test="${top3LikePosts != null && not empty top3LikePosts}">
                <c:forEach var="post" items="${top3LikePosts}">
                    <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>     
                    <p>postId: ${post.postId}</p>
                    <p>postTitle: ${post.postTitle}</p>
                    <p>postAuthor: ${authorOfPost[post.postId].fullname}</p>
                    <p>postTime: <c:out value="${postTime}"/></p>
                    <p>postCountLike: ${countLikeOfPost[post.postId]}</p>
                    <p>postCountComment: ${countCommentOfPost[post.postId]}</p>
                    <p>postDescription: ${post.postSubTitle}</p>   
                    <hr>
                </c:forEach>
            </c:if>
        </div>
        <hr>
        <hr>
        <hr>
        <div>
            <h2>Top 4 post mới nhất</h2>
            <c:if test="${top4NewPosts != null && not empty top4NewPosts}">
                <c:forEach var="post" items="${top4NewPosts}">
                    <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>                    
                    <p>postId: ${post.postId}</p>
                    <p>postTitle: ${post.postTitle}</p>
                    <p>postAuthor: ${authorOfPost[post.postId].fullname}</p>
                    <p>postTime: <c:out value="${postTime}"/></p>
                    <p>postCountLike: ${countLikeOfPost[post.postId]}</p>
                    <p>postCountComment: ${countCommentOfPost[post.postId]}</p>
                    <p>postDescription: ${post.postSubTitle}</p>
                    <hr>
                </c:forEach>
            </c:if>
        </div>
        <hr>
        <hr>
        <hr>
        <div>
            <h2>6 random series</h2>
            <c:if test="${top6RandomSeriesList != null && not empty top6RandomSeriesList}">
                <c:forEach var="series" items="${top6RandomSeriesList}">
                    <p>seriesId: ${series.seriesId}</p>
                    <p>seriesName: ${series.seriesName}</p>
                    <h3>Top 3 posts của series</h3>
                    <c:forEach var="post" items="${top3PostsOfRandomSeries[series.seriesId]}">
                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>                    
                        <p>postId: ${post.postId}</p>
                        <p>postTitle: ${post.postTitle}</p>
                        <p>postAuthor: ${authorOfPost[post.postId].fullname}</p>
                        <p>postTime: <c:out value="${postTime}"/></p>
                        <p>postCountLike: ${countLikeOfPost[post.postId]}</p>
                        <p>postCountComment: ${countCommentOfPost[post.postId]}</p>
                        <p>postDescription: ${post.postSubTitle}</p>
                        <hr>
                    </c:forEach>
                    <hr>
                    <hr>
                </c:forEach>
            </c:if>
        </div>        
    </jsp:body>
</t:layout>
