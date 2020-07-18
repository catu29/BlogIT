<%-- 
    Document   : postDetail
    Created on : Jul 13, 2020, 3:35:31 PM
    Author     : TranCamTu
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="postBean" value="${requestScope.postBean}" />
<c:set var="seriesBean" value="${requestScope.seriesBean}" />
<c:set var="authorBean" value="${requestScope.userBean}" />
<c:set var="postsOfSeries" value="${requestScope.postsOfSeries}" />
<c:set var="postsOfUser" value="${requestScope.postsOfUser}" />
<c:set var="likesOfPost" value="${requestScope.likesOfPost}" />
<c:set var="commentsOfPost" value="${requestScope.commentsOfPost}" />
<c:set var="isLiked" value="${sessionScope.isLiked}" />
<c:set var="likedUsers" value="${requestScope.likedUsers}" />

<t:layout>
    <jsp:attribute name="title">${postBean.postTitle}</jsp:attribute>
    <jsp:body>
        <h1>Bài viết</h1>
        <div>
            <c:choose>
                <c:when test="${postBean != null}">
                    
                    <div id="Thông tin bài viết">
                        <p>Tiêu đề: <c:out value="${postBean.postTitle}" /></p>
                        <p>Series:
                            <c:choose>
                                <c:when test="${seriesBean != null}">
                                    <c:out value="${seriesBean.seriesName}" />
                                </c:when>
                                <c:otherwise>
                                    <c:out value="Chưa có series"/>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <p>Tác giả: <c:out value="${userBean.fullname}" /></p>
                        <p>Thời gian: 
                            <fmt:formatDate var="postTime" value="${postBean.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                            <c:out value="${postTime}" />
                        </p>
                    </div>
                        
                    <div id="Nội dung bài viết">
                        <h2>Nội dung: </h2>
                        ${postBean.postContent}
                    </div>
                    
                    <div id="Các lượt like">
                        <h2>Likes</h2>
                        <c:if test="${likedUsers != null}">
                            <p>Tổng số lượt like: <c:out value="${fn:length(likedUsers)}"/></p>
                            <c:if test="${not empty likedUsers}">
                                <p>Tên những người like: 
                                    <c:forEach var="like" items="${likedUsers}">
                                        <c:out value="${like.fullname}"/>
                                    </c:forEach>
                                </p>
                            </c:if>
                        </c:if>
                    </div>
                    
                </c:when>
                <c:otherwise>
                    <p>Bài viết không tồn tại</p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${postsOfSeries != null}">
            <h1>Bài viết cùng series</h1>
            <div>
                <c:forEach var="post" items="${postsOfSeries}">
                    <c:if test="${post.postId != postBean.postId}">
                        <p>Tiêu đề:
                            <c:url var="postURL" value="${contextPath}/post/detail">
                                <c:param name="title" value="${post.postTitleUnsigned}"/>
                                <c:param name="%" value="${post.postId}"/>
                            </c:url>
                            <a href="${postURL}">
                                <c:out value="${post.postTitle}"/>
                            </a>
                        </p>
                        <p>Thời gian: 
                            <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                            <c:out value="${postTime}" />
                        </p>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>
        
        <h1>Bài viết cùng tác giả</h1>
        <div>
            <c:forEach var="post" items="${postsOfUser}">
                <c:if test="${post.postId != postBean.postId}">
                    <p>Tiêu đề:
                        <c:url var="postURL" value="${contextPath}/post/detail">
                            <c:param name="title" value="${post.postTitleUnsigned}"/>
                            <c:param name="%" value="${post.postId}"/>
                        </c:url>
                        <a href="${postURL}">
                            <c:out value="${post.postTitle}"/>
                        </a>
                    </p>
                    <p>Thời gian: 
                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                        <c:out value="${postTime}" />
                    </p>
                </c:if>
            </c:forEach>
        </div>
    </jsp:body>
</t:layout>