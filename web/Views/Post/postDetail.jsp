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
<c:set var="authorBean" value="${requestScope.authorBean}" />
<c:set var="postsOfSeries" value="${requestScope.postsOfSeries}" />
<c:set var="postsOfUser" value="${requestScope.postsOfUser}" />
<c:set var="likesOfPost" value="${requestScope.likesOfPost}" />
<c:set var="commentsOfPost" value="${requestScope.commentsOfPost}" />
<c:set var="isLiked" value="${requestScope.isLiked}" />
<c:set var="likedUsers" value="${requestScope.likedUsers}" />
<c:set var="commentUser" value="${requestScope.commentUser}" />

<t:layout>
    <jsp:attribute name="title">${postBean.postTitle}</jsp:attribute>
    <jsp:attribute name="postHeader">
        <!-- PAGE HEADER -->
        <div id="post-header" class="page-header">
            <div class="page-header-bg" style="background-image: url('${pageContext.request.contextPath}/Resources/img/header-1.jpg');" data-stellar-background-ratio="0.5"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-10">
                        <div class="post-category">
                            <c:if test="${seriesBean != null}">
                                <a href="">${seriesBean.seriesName}</a>
                                <!--TODO: Build series of posts page -->
                            </c:if>
                        </div>
                        <h1>${postBean.postTitle}</h1>
                        <ul class="post-meta">
                            <li><a href="">${authorBean.fullname}</a></li>
                            <li>
                                <fmt:formatDate var="postTime" value="${postBean.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                <c:out value="${postTime}"/>
                            </li>
                            <li><i class="fa fa-comments"></i>&nbsp;<c:out value="${fn:length(commentsOfPost)}"/></li>
                            <li><i class="fa fa-eye"></i>&nbsp;<c:out value="${fn:length(likesOfPost)}"/></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /PAGE HEADER -->
    </jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-md-8">
                <c:choose>
                    <c:when test="${postBean != null}">
                        <div class="section-row">
                            <div class="post-share">
                                <a href="" class="primary-background">Tag 1</a>
                                <a href="" class="primary-background">Tag 1</a>
                                <a href="" class="primary-background">Tag 1</a>
                                <!--TODO: Build list posts of tag page -->
                            </div>
                        </div>
                        <div class="section-row post-section">
                            ${postBean.postContent}
                        </div>
                        <div class="section-row">
                            <div class="section-title">
                                <c:url var="profileURL" value="${contextPath}/user/profile">
                                    <c:param name="id" value="${authorBean.userId}"/>
                                </c:url>
                                <h3 class="title">Về tác giả <a href="${profileURL}">${authorBean.fullname}</a></h3>
                            </div>
                            <div class="author media">
                                <div class="media-left">
                                    <c:url var="profileURL" value="${contextPath}/user/profile">
                                        <c:param name="id" value="${authorBean.userId}"/>
                                    </c:url>
                                    <a href="${profileURL}">
                                        <img class="author-img media-object" src="${pageContext.request.contextPath}/Resources/img/${authorBean.avatar}" alt="">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <p>Thêm cột bio cho author</p>
                                    <!-- TODO: Add bio for author -->
                                </div>
                            </div>
                        </div>
                        <!-- post reply -->
                        <div class="section-row">
                            <div class="section-title">
                                <h3 class="title">Gửi bình luận</h3>
                            </div>
                            <form class="post-reply">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <textarea class="input" name="message" placeholder="Nhập bình luận"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <button class="primary-button">Gửi</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                        <!-- /post reply -->
                        <!-- post comments -->
                        <!-- <div id="Các lượt bình luận">
                            <h2>Comments</h2>
                            <c:if test="${commentsOfPost != null && not empty commentsOfPost}">
                                <p>
                                    <c:forEach var="comment" items="${commentsOfPost}">
                                        <c:set var="userId" value="${comment.userId}"/>
                                        <c:url var="profileURL" value="${contextPath}/user/profile">
                                            <c:param name="id" value="${userId}"/>
                                        </c:url>
                                        <a href="${profileURL}"><c:out value="${commentUser[userId]} " /></a>
                                        <c:out value="${comment.content}" /> </br>                                    
                                        <fmt:formatDate var="commentTime" value="${comment.commentTime}" type="date" dateStyle="short" pattern="HH:mm:ss dd/MM/yyyy"/>
                                        <c:out value="${commentTime}" /> </br></br>
                                    </c:forEach>
                                </p>
                            </c:if>
                        </div>
                         -->
                        <!-- TODO: Render comments data-->
                        <div class="section-row">
                            <div class="section-title">
                                <h3 class="title">3 Bình luận</h3>
                            </div>
                            <div class="post-comments">
                                <!-- comment -->
                                <div class="media">
                                    <div class="media-left">
                                        <img class="media-object" src="${pageContext.request.contextPath}/Resources/img/avatar-2.jpg" alt="">
                                    </div>
                                    <div class="media-body">
                                        <div class="media-heading">
                                            <h4>John Doe</h4>
                                            <span class="time">5 min ago</span>
                                        </div>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                        <a href="#" class="reply">Reply</a>
                                        <!-- comment -->
                                        <div class="media media-author">
                                            <div class="media-left">
                                                <img class="media-object" src="${pageContext.request.contextPath}/Resources/img/avatar-1.jpg" alt="">
                                            </div>
                                            <div class="media-body">
                                                <div class="media-heading">
                                                    <h4>John Doe</h4>
                                                    <span class="time">5 min ago</span>
                                                </div>
                                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                                <a href="#" class="reply">Reply</a>
                                            </div>
                                        </div>
                                        <!-- /comment -->
                                    </div>
                                </div>
                                <!-- /comment -->

                                <!-- comment -->
                                <div class="media">
                                    <div class="media-left">
                                        <img class="media-object" src="${pageContext.request.contextPath}/Resources/img/avatar-3.jpg" alt="">
                                    </div>
                                    <div class="media-body">
                                        <div class="media-heading">
                                            <h4>John Doe</h4>
                                            <span class="time">5 min ago</span>
                                        </div>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                        <a href="#" class="reply">Reply</a>
                                    </div>
                                </div>
                                <!-- /comment -->
                            </div>
                        </div>
                        <!-- /post comments -->
                        <p>
                            <c:url var="likePostURL" value="${contextPath}/post/detail/like">
                                <c:param name="postId" value="${postBean.postId}" />
                                <c:param name="userId" value="${userBean.userId}" />
                            </c:url>
                            <a href="${likePostURL}">Like this post</a>
                        </p>
                        <!-- TODO: Style Like button -->
                    </c:when>
                    <c:otherwise>
                        <p>Bài viết không tồn tại</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-4">
                <!-- post widget -->
                <div class="aside-widget">
                    <div class="section-title">
                        <h3 class="title">${seriesBean.seriesName}</h3>
                    </div>
                    <c:forEach var="post" items="${postsOfSeries}">
                        <c:if test="${post.postId != postBean.postId}">
                            <!-- post -->
                            <div class="post post-widget">
                                <c:url var="postURL" value="${contextPath}/post/detail">
                                    <c:param name="name" value="${post.postTitleUnsigned}"/>
                                    <c:param name="%" value="${post.postId}"/>
                                </c:url>
                                <a class="post-img" href="${postURL}">
                                    <img src="${pageContext.request.contextPath}/Resources/img/header-1.jpg" alt="${postURL}">
                                </a>
                                <div class="post-body">
                                    <h4 class="post-title">
                                        <a href="${postURL}"><c:out value="${post.postTitle}"/></a>
                                    </h4>
                                    <br>
                                    <small>
                                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                        <c:out value="${postTime}"/>
                                    </small>
                                </div>
                            </div>
                            <!-- /post -->
                        </c:if>
                    </c:forEach>
                </div>
                <!-- /post widget -->
                <br>
                <!-- author post widget -->
                <div class="aside-widget">
                    <div class="section-title">
                        <h3 class="title">Cùng tác giả</h3>
                    </div>
                    <c:forEach var="post" items="${postsOfUser}">
                        <c:if test="${post.postId != postBean.postId}">
                            <div class="post post-widget">
                                <c:url var="postURL" value="${contextPath}/post/detail">
                                    <c:param name="title" value="${post.postTitleUnsigned}"/>
                                    <c:param name="%" value="${post.postId}"/>
                                </c:url>
                                <a class="post-img" href="${postURL}">
                                    <img src="${pageContext.request.contextPath}/Resources/img/header-1.jpg" alt="${postURL}">
                                </a>
                                <div class="post-body">
                                    <h4 class="post-title">
                                        <a href="${postURL}"><c:out value="${post.postTitle}"/></a>
                                    </h4>
                                    <br>
                                    <small>
                                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="dd/MM/yyyy"/>
                                        <c:out value="${postTime}"/>
                                    </small>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <!-- /author post widget -->
            </div>
        </div>   
    </jsp:body>
</t:layout>