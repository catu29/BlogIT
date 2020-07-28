<%-- 
    Document   : listPost
    Created on : Jul 21, 2020, 12:44:38 AM
    Author     : TranCamTu
--%>

<%@tag description="Use for show list of posts" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>


<c:set var="listPosts" value="${requestScope.listPosts}" />
<c:set var="authorOfPost" value="${requestScope.authorOfPost}" />
<c:set var="seriesOfPost" value="${requestScope.seriesOfPost}" />

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="anotherInfo" fragment="true"%>

<%-- any content can be specified here e.g.: --%>
<div>
    <c:choose>
        <c:when test="${listPosts == null || empty listPosts}">
            Không có bài viết nào
        </c:when>
        <c:otherwise>
            <c:forEach var="post" items="${listPosts}">
                <!-- SECTION -->
                <div class="section">
                    <!-- container -->
                    <div class="container">
                        <!-- row -->
                        <div class="row">
                            <div class="col-md-8">
                                <!-- post -->
                                <c:url var="postURL" value="${contextPath}/post/detail">
                                    <c:param name="name" value="${post.postTitleUnsigned}"/>
                                    <c:param name="%" value="${post.postId}"/>
                                </c:url>
                                <div class="post post-row">
                                    <a class="post-img" href="${postURL}"><img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt=""></a>
                                    <div class="post-body">
                                        <div class="post-category">
                                            <c:set var="seriesId" value="${post.seriesId}"/>
                                            <c:url var="seriesURL" value="${contextPath}/series">
                                                <c:param name="id" value="${seriesId}"/>
                                            </c:url>
                                            <a href="${seriesURL}">${seriesOfPost[seriesId].seriesName}</a>
                                        </div>
                                        <h3 class="post-title"><a href="${postURL}">${post.postTitle}</a></h3>
                                            <c:set var="authorId" value="${post.userId}"/>
                                            <c:url var="authorURL" value="${contextPath}/user/profile">
                                                <c:param name="id" value="${authorId}"/>
                                            </c:url>
                                            <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                        <ul class="post-meta">
                                            <li><a href="${authorURL}">${authorOfPost[authorId].fullname}</a></li>
                                            <li>${postTime}</li>
                                        </ul>
                                        <p>${post.postSubTitle}</p>
                                    </div>
                                </div>
                                <!-- /post -->
                            </div>
                        </div>
                        <!-- /row -->
                    </div>
                    <!-- /container -->
                </div>
                <!-- /SECTION -->
            </c:forEach>
            <div class="section-row loadmore text-center">
                <a href="javascript:void" class="primary-button">Xem thêm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<jsp:invoke fragment="anotherInfo"></jsp:invoke>