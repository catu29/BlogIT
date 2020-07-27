<%-- 
    Document   : profile
    Created on : Jul 11, 2020, 4:35:38 AM
    Author     : TranCamTu
--%>

<%@page import="Beans.SessionBeanUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="userProfile" value="${requestScope.userProfile}" />
<c:set var="listPosts" value="${requestScope.listPosts}" />
<c:set var="countLike" value="${requestScope.countLike}" />
<c:set var="countComment" value="${requestScope.countComment}" />

<t:layout>
    <jsp:attribute name="title">${userProfile.fullname}</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-md-4">
                <div class="mb-4">
                    <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/${userProfile.avatar}" alt="">
                </div>
                <p>
                <h3><c:out value="${userProfile.fullname}"/></h3>
                </p>
                <div>
                    <c:out value="${userProfile.email}" />
                </div>
                <p>Số bài viết:
                    <c:choose>
                        <c:when test="${listPosts == null || empty listPosts}">
                            0
                        </c:when>
                        <c:when test="${listPosts != null}">
                            <c:out value="${fn:length(listPosts)}"/>
                        </c:when>
                    </c:choose>
                </p>
                <div class="mb-4">
                    <c:if test="${userBean != null && userBean.role == 0 && userBean.userId == userProfile.userId}">
                        <p><a href="${pageContext.request.contextPath}/admin/manage-user">Quản lý người dùng</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-post">Quản lý bài viết</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-series">Quản lý series</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-tag">Quản lý tag</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-comment">Quản lý bình luận</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-like">Quản lý lượt like</a></p>
                        <p><a href="${pageContext.request.contextPath}/admin/manage-report">Quản lý báo cáo</a></p>
                    </c:if>
                </div>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <c:choose>
                        <c:when test="${listPosts == null || empty listPosts}">
                            <p>Chưa có bài viết</p>
                        </c:when>
                        <c:when test="${listPosts != null}">
                            <c:forEach var="post" items="${listPosts}">
                                <div class="post col-md-12">
                                    <c:url var="postURL" value="${contextPath}/post/detail">
                                        <c:param name="name" value="${post.postTitleUnsigned}"/>
                                        <c:param name="%" value="${post.postId}"/>
                                    </c:url>
                                    <a class="post-img" href="${postURL}">
                                        <img src="${pageContext.request.contextPath}/Resources/img/${post.image}" alt="">
                                    </a>
                                    <div class="post-body">
                                        <h3 class="post-title title-sm">
                                            <a href="${postURL}">
                                                <c:out value="${post.postTitle}"/>
                                            </a>
                                        </h3>
                                        <ul class="post-meta">
                                            <li>
                                                <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                                <c:out value="${postTime}" />
                                            </li>
                                            <li><i class="fa fa-comments"></i>&nbsp;${countLike[post.postId]}</li>
                                            <li><i class="fas fa-thumbs-up"></i>&nbsp;${countComment[post.postId]}</li>
                                        </ul>
                                        <p>
                                            ${post.postSubTitle}
                                        </p>
                                        <div>
                                            <c:if test="${userBean != null && userBean.userId == userProfile.userId}">
                                                <c:url var="postUpdateURL" value="${contextPath}/post/detail/update">
                                                    <c:param name="postId" value="${post.postId}"/>
                                                </c:url>
                                                <a href="${postUpdateURL}" class="primary-button">Cập nhật</a>
                                                
                                                <c:url var="postDeleteURL" value="${contextPath}/post/detail/delete">
                                                    <c:param name="postId" value="${post.postId}"/>
                                                </c:url>
                                                <a href="${postDeleteURL}" class="secondary-button">Xóa bài viết</a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                            </c:forEach>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>


    </jsp:body>
</t:layout>
