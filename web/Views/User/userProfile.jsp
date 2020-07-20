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

<t:layout>
    <jsp:attribute name="title">${userProfile.fullname}</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-md-4">
                <div class="mb-4">
                    <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/avatar-2.jpg" alt="">
                </div>
                <p>
                <h3><c:out value="${userBean.fullname}"/></h3>
                </p>
                <div>
                    <c:out value="${userBean.email}" />
                </div>
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
                                        <c:param name="title" value="${post.postTitleUnsigned}"/>
                                        <c:param name="%" value="${post.postId}"/>
                                    </c:url>
                                    <a class="post-img" href="${postURL}">
                                        <img src="${pageContext.request.contextPath}/Resources/img/header-1.jpg" alt="">
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
                                            <li><i class="fa fa-comments"></i>&nbsp;3</li>
                                            <li><i class="fas fa-thumbs-up"></i>&nbsp;<c:out value="${fn:length(likedUsers)}"/></li>
                                        </ul>
                                        <p>
                                            Hê lô bà con cô bác họ hàng gần xa bà con khối phố. Lại là mình đây, Minh Monmen trong những chia sẻ vụn vặt về quá trình làm những sản phẩm siêu to khổng lồ (tự huyễn hoặc bản thân vậy cho có động lực). Hôm nay mình xin hân hạnh gửi đến các bạn phần tiếp theo của series Nghệ thuật xử lý background job mà mình vừa mới nghĩ được ra thêm.
                                        </p>
                                        <div>
                                            <button class="primary-button">Cập nhật</button>
                                            <button class="secondary-button">Xóa bài viết</button>
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
