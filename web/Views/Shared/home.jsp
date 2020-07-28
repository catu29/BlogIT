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
    <jsp:attribute name="js"></jsp:attribute>
    <jsp:attribute name="title">Trang chủ</jsp:attribute>
    <jsp:body>
        <c:if test="${top3LikePosts != null && not empty top3LikePosts}">
            <!--HOT POST SECTION -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div id="hot-post" class="row hot-post">
                        <div class="col-md-8 hot-post-left">
                            <!-- post -->
                            <div class="post post-thumb">
                                <c:url var="postURL_0" value="${contextPath}/post/detail">
                                    <c:param name="name" value="${top3LikePosts[0].postTitleUnsigned}"/>
                                    <c:param name="%" value="${top3LikePosts[0].postId}"/>
                                </c:url>
                                <a class="post-img" href="${postURL_0}"><img src="${pageContext.request.contextPath}/Resources/img/${top3LikePosts[0].userId}/${top3LikePosts[0].image}" alt=""></a>
                                <div class="post-body">
                                    <h3 class="post-title title-lg">
                                        <a href="${postURL_0}">
                                            ${top3LikePosts[0].postTitle}
                                        </a>
                                    </h3>
                                    <p style="color: #fff;">${top3LikePosts[0].postSubTitle}</p>
                                    <fmt:formatDate var="postTime_0" value="${top3LikePosts[0].postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>     
                                    <ul class="post-meta">
                                        <c:url var="authorURL" value="${contextPath}/user/profile">
                                            <c:param name="id" value="${authorOfPost[top3LikePosts[0].postId].userId}"/>
                                        </c:url>
                                        <li><a href="${authorURL}">${authorOfPost[top3LikePosts[0].postId].fullname}</a></li>
                                        <li><c:out value="${postTime_0}"/></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /post -->
                        </div>

                        <div class="col-md-4 hot-post-right">
                            <!-- post -->
                            <div class="post post-thumb">
                                <c:url var="postURL_1" value="${contextPath}/post/detail">
                                    <c:param name="name" value="${top3LikePosts[1].postTitleUnsigned}"/>
                                    <c:param name="%" value="${top3LikePosts[1].postId}"/>
                                </c:url>
                                <a class="post-img" href="${postURL_1}"><img src="${pageContext.request.contextPath}/Resources/img/${top3LikePosts[1].userId}/${top3LikePosts[1].image}" alt=""></a>
                                <div class="post-body">
                                    <h3 class="post-title">
                                        <a href="${postURL_1}">
                                            ${top3LikePosts[1].postTitle}
                                        </a>
                                    </h3>
                                    <fmt:formatDate var="postTime_1" value="${top3LikePosts[1].postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>     
                                    <ul class="post-meta">
                                        <c:url var="authorURL" value="${contextPath}/user/profile">
                                            <c:param name="id" value="${authorOfPost[top3LikePosts[1].postId].userId}"/>
                                        </c:url>
                                        <li><a href="${authorURL}">${authorOfPost[top3LikePosts[1].postId].fullname}</a></li>
                                        <li><c:out value="${postTime_1}"/></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /post -->

                            <!-- post -->
                            <div class="post post-thumb">
                                <c:url var="postURL_2" value="${contextPath}/post/detail">
                                    <c:param name="name" value="${top3LikePosts[2].postTitleUnsigned}"/>
                                    <c:param name="%" value="${top3LikePosts[2].postId}"/>
                                </c:url>
                                <a class="post-img" href="${postURL_2}"><img src="${pageContext.request.contextPath}/Resources/img/${top3LikePosts[2].userId}/${top3LikePosts[2].image}" alt=""></a>
                                <div class="post-body">
                                    <h3 class="post-title">
                                        <a href="${postURL_2}">
                                            ${top3LikePosts[2].postTitle}
                                        </a>
                                    </h3>
                                    <fmt:formatDate var="postTime_2" value="${top3LikePosts[2].postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>     
                                    <ul class="post-meta">
                                        <c:url var="authorURL" value="${contextPath}/user/profile">
                                            <c:param name="id" value="${authorOfPost[top3LikePosts[2].postId].userId}"/>
                                        </c:url>
                                        <li><a href="${authorURL}">${authorOfPost[top3LikePosts[2].postId].fullname}</a></li>
                                        <li><c:out value="${postTime_2}"/></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /post -->
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /HOT POST SECTION -->
        </c:if>

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-8">
                        <!-- row -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="section-title">
                                    <h2 class="title">Bài viết mới</h2>
                                </div>
                            </div>
                            <c:if test="${top4NewPosts != null && not empty top4NewPosts}">
                                <c:forEach var="post" items="${top4NewPosts}">
                                    <!-- post -->
                                    <c:url var="postURL" value="${contextPath}/post/detail">
                                        <c:param name="name" value="${post.postTitleUnsigned}"/>
                                        <c:param name="%" value="${post.postId}"/>
                                    </c:url>
                                    <div class="col-md-6">
                                        <div class="post" style="min-height: 380px;">
                                            <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/> 
                                            <a class="post-img" href="${postURL}"><img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt=""></a>
                                            <div class="post-body">
                                                <h3 class="post-title"><a href="${postURL}">${post.postTitle}</a></h3>
                                                <p><small>${post.postSubTitle}</small></p>
                                                <ul class="post-meta">
                                                    <c:url var="authorURL" value="${contextPath}/user/profile">
                                                        <c:param name="id" value="${authorOfPost[post.postId].userId}"/>
                                                    </c:url>
                                                    <li><a href="${authorURL}">${authorOfPost[post.postId].fullname}</a></li>
                                                    <li>${postTime}</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /post -->
                                </c:forEach>
                            </c:if>
                            <div class="clearfix visible-md visible-lg"></div>
                        </div>
                        <!-- /row -->

                        <c:if test="${top6RandomSeriesList != null && not empty top6RandomSeriesList}">
                            <c:forEach var="series" items="${top6RandomSeriesList}">
                                <c:if test="${top3PostsOfRandomSeries[series.seriesId].size() > 0}">
                                    <!-- row -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="section-title">
                                                <h2 class="title">${series.seriesName}</h2>
                                            </div>
                                        </div>
                                        <c:forEach var="post" items="${top3PostsOfRandomSeries[series.seriesId]}">
                                            <!-- post -->
                                            <c:url var="postURL" value="${contextPath}/post/detail">
                                                <c:param name="name" value="${post.postTitleUnsigned}"/>
                                                <c:param name="%" value="${post.postId}"/>
                                            </c:url>
                                            <div class="col-md-4">
                                                <div class="post post-sm">
                                                    <a class="post-img" href="${postURL}"><img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt=""></a>
                                                    <div class="post-body">
                                                        <h3 class="post-title title-sm">
                                                            <a href="${postURL}">${post.postTitle}</a>
                                                        </h3>
                                                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/> 
                                                        <ul class="post-meta">
                                                            <c:url var="authorURL" value="${contextPath}/user/profile">
                                                                <c:param name="id" value="${authorOfPost[post.postId].userId}"/>
                                                            </c:url>
                                                            <li><a href="${authorURL}">${authorOfPost[post.postId].fullname}</a></li>
                                                            <li>${postTime}</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /post -->
                                        </c:forEach>
                                    </div>
                                    <!-- /row -->
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>

                    <div class="col-md-4">
                        <c:if test="${top10Tags != null && not empty top10Tags}">
                            <!-- category widget -->
                            <div class="aside-widget">
                                <div class="section-title">
                                    <h2 class="title">Tags</h2>
                                </div>
                                <div class="tags-widget">
                                    <ul>
                                        <c:forEach var="tag" items="${top10Tags}">
                                            <li><a href="">${tag.tagName} ${tag.tagId}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <!-- /category widget -->
                        </c:if>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->
    </jsp:body>
</t:layout>
