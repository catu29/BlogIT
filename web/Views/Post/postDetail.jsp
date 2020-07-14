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
<c:set var="userBean" value="${requestScope.userBean}" />
<c:set var="postsOfSeries" value="${requestScope.postsOfSeries}" />
<c:set var="postsOfUser" value="${requestScope.postsOfUser}" />

<t:layout>
    <jsp:attribute name="title">${postBean.postTitle}</jsp:attribute>
    <jsp:body>
        <h1>Bài viết</h1>
        <div>
            <c:choose>
                <c:when test="${postBean != null}">
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
                    <p>Nội dung: ${postBean.postContent}</p>
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