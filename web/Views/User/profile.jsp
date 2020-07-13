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

<c:set var="userBean" value="${sessionScope.userBean}" />
<c:set var="listPosts" value="${sessionScope.listPosts}" />

<c:url var="url" value="${pageContext.request.requestURL}">
    <c:param name="id" value="${userBean.userId}"/>
</c:url>

<t:layout>
    <jsp:attribute name="title">Profile</jsp:attribute>
    <jsp:body>
        <h1>Trang cá nhân</h1>
        <div> Profile info
            <p>Avatar: <c:out value="${userBean.avatar}" /></p>
            <p>Full name: <c:out value="${userBean.fullname}" /></p>
            <p>Email: <c:out value="${userBean.email}" /></p>
            <p>Số bài viết:
                <c:choose>
                    <c:when test="${listPosts == null || empty listPosts}">
                    <p>0</p>
                    </c:when>
                    <c:when test="${listPosts != null}">
                        <c:out value="${fn:length(listPosts)}"/>
                    </c:when>
                </c:choose>
            </p>
        </div>
        <div> Danh sách bài viết
            <c:choose>
                <c:when test="${listPosts == null || empty listPosts}">
                <p>Chưa có bài viết</p>
                </c:when>
                <c:when test="${listPosts != null}">
                    <c:forEach var="post" items="${listPosts}">
                        <div> Nội dung bài viết
                            <p>Tiêu đề: <c:out value="${post.postTitle}"/></p>
                            <p>Tiêu đề không dấu: <c:out value="${post.postTitleUnsigned}"/></p>
                            <p>Thời gian: 
                                <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                <c:out value="${postTime}" />
                            </p>
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </jsp:body>
</t:layout>
