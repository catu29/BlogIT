<%-- 
    Document   : userInfo
    Created on : Jul 27, 2020, 7:04:15 AM
    Author     : TranCamTu
--%>

<%@tag description="Use to show avatar, fullname, email and number of posts of user" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<c:set var="userProfile" value="${requestScope.userProfile}" />
<c:set var="listPosts" value="${requestScope.listPosts}" />

<%-- any content can be specified here e.g.: --%>
<div class="col-md-3">
    <c:choose>
        <c:when test="${userBean.userId == userProfile.userId || userProfile == null}">
            <div class="mb-4">
                <c:choose>
                    <c:when test="${userBean.avatar != 'null' && userBean.avatar != null && not empty userBean.avatar}">
                        <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/${userBean.userId}/${userBean.avatar}" alt="">
                    </c:when>
                    <c:otherwise>
                        <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/default-user.png" alt="">
                    </c:otherwise>
                </c:choose>
            </div>
            <h3><c:out value="${userBean.fullname}"/></h3>
            <div>
                <c:out value="${userBean.email}" />
            </div>
            <p>Số bài viết:
                <c:choose>
                    <c:when test="${listPosts == null || empty listPosts}"> 0 </c:when>
                <c:when test="${listPosts != null}">
                    <c:out value="${fn:length(listPosts)}"/>
                </c:when>
            </c:choose>
            </p>
            <div class="mb-4">
                <c:if test="${userBean != null && userBean.userId == userProfile.userId}">
                    <c:choose>
                        <c:when test="${userBean.role == 0}">
                            <p><a href="${pageContext.request.contextPath}/admin/manage-user">Quản lý người dùng</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-post">Quản lý bài viết</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-series">Quản lý series</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-tag">Quản lý tag</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-comment">Quản lý bình luận</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-like">Quản lý lượt like</a></p>
                            <p><a href="${pageContext.request.contextPath}/admin/manage-report">Quản lý báo cáo</a></p>
                        </c:when>
                        <c:when test="${userBean.role != 0}">
                            <p><a href="${pageContext.request.contextPath}/user/edit-profile">Thay đổi thông tin cá nhân</a></p>
                            <p><a href="${pageContext.request.contextPath}/user/manage-post">Các bài viết của tôi</a></p>
                            <p><a href="${pageContext.request.contextPath}/user/manage-series">Các series của tôi</a></p>
                        </c:when>
                    </c:choose>                        
                </c:if>
            </div>
        </c:when>
        <c:when test="${userBean.userId != userProfile.userId || (userBean == null && userProfile != null)}">
            <div class="mb-4">
                <c:choose>
                    <c:when test="${userProfile.avatar != 'null' && userProfile.avatar != null && not empty userProfile.avatar}">
                        <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/${userProfile.userId}/${userProfile.avatar}" alt="">
                    </c:when>
                    <c:otherwise>
                        <img class="user-avt" src="${pageContext.request.contextPath}/Resources/img/default-user.png" alt="">
                    </c:otherwise>
                </c:choose>
            </div>
            <h3><c:out value="${userProfile.fullname}"/></h3>
            <div>
                <c:out value="${userProfile.email}" />
            </div>
            <p>Số bài viết:
                <c:choose>
                    <c:when test="${listPosts == null || empty listPosts}"> 0 </c:when>
                <c:when test="${listPosts != null}">
                    <c:out value="${fn:length(listPosts)}"/>
                </c:when>
            </c:choose>
            </p>
        </c:when>
    </c:choose>    
</div>