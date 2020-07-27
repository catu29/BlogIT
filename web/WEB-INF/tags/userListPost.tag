<%-- 
    Document   : userListPost
    Created on : Jul 27, 2020, 7:25:43 AM
    Author     : TranCamTu
--%>

<%@tag description="Use for manage posts of user" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<c:set var="listPosts" value="${requestScope.listPosts}" />
<c:set var="countLike" value="${requestScope.countLike}" />
<c:set var="countComment" value="${requestScope.countComment}" />

<%-- any content can be specified here e.g.: --%>
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
                            <img src="${pageContext.request.contextPath}/Resources/img/${userBean.userId}/${post.image}" alt="">
                        </a>
                        <div class="post-body">
                            <h3 class="post-title title-sm">
                                <a href="${postURL}">
                                    <c:out value="${post.postTitle}"/>
                                </a>
                            </h3>
                            <ul class="post-umeta">
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
                                <c:if test="${userBean != null && (userBean.userId == userProfile.userId || userProfile == null)}">
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