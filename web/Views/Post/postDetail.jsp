<%-- 
    Document   : postDetail
    Created on : Jul 13, 2020, 3:35:31 PM
    Author     : TranCamTu
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="postBean" value="${requestScope.postBean}" />
<c:set var="seriesBean" value="${requestScope.seriesBean}" />
<c:set var="authorBean" value="${requestScope.authorBean}" />
<c:set var="postsOfSeries" value="${requestScope.postsOfSeries}" />
<c:set var="likesOfPost" value="${requestScope.likesOfPost}" />
<c:set var="isLiked" value="${requestScope.isLiked}" />
<c:set var="likedUsers" value="${requestScope.likedUsers}" />
<c:set var="commentsOfPost" value="${requestScope.commentsOfPost}" />
<c:set var="commentedUsers" value="${requestScope.commentedUsers}" />
<c:set var="tagsOfPost" value="${requestScope.tagsOfPost}" />

<t:layout>
    <jsp:attribute name="js">
        <script src="${pageContext.request.contextPath}/Resources/Post/postDetail.js"></script>
    </jsp:attribute>
    <jsp:attribute name="title">${postBean.postTitle}</jsp:attribute>
    <jsp:attribute name="postHeader">
        <!-- PAGE HEADER -->
        <div id="post-header" class="page-header">
            <div class="page-header-bg" 
                 style="background-image: url('${pageContext.request.contextPath}/Resources/img/${postBean.userId}/${postBean.image}');
                        background-repeat: no-repeat;
                        width: 100%;
                        height: 100%;" 
                 data-stellar-background-ratio="0.5">
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-10">
                        <div class="post-category">
                            <c:if test="${seriesBean != null}">
                                <c:url var="seriesURL" value="${contextPath}/series">
                                    <c:param name="id" value="${seriesBean.seriesId}"/>
                                </c:url>
                                <a href="${seriesURL}">${seriesBean.seriesName}</a>
                            </c:if>
                        </div>
                        <h1>${postBean.postTitle}</h1>
                        <ul class="post-meta">
                            <c:url var="authorURL" value="${contextPath}/user/profile">
                                <c:param name="id" value="${authorBean.userId}"/>
                            </c:url>
                            <li><a href="authorURL">${authorBean.fullname}</a></li>
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
                            <c:if test="${tagsOfPost != null && not empty tagsOfPost}">
                                <div class="post-share">
                                    <c:forEach var="tag" items="${tagsOfPost}">                                    
                                        <c:url var="tagURL" value="${contextPath}/tag">
                                            <c:param name="id" value="${tag.tagId}"/>
                                        </c:url>
                                        <a href="${tagURL}" class="primary-background"><c:out value="${tag.tagName}"/></a>                                                                       
                                    </c:forEach>
                                </div>
                            </c:if>
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
                                        <img class="author-img media-object" src="${pageContext.request.contextPath}/Resources/img/${authorBean.userId}/${authorBean.avatar}" alt="">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <p>${authorBean.bio}</p>                               
                                </div>
                            </div>
                        </div>
                        <!-- post comments -->                        
                        <div class="section-row">
                            <div class="section-title">
                                <h3 class="title"><c:out value="${fn:length(commentsOfPost)} bình luận"/></h3>
                            </div>
                            <div class="post-comments">                                
                                <c:if test="${commentsOfPost != null && not empty commentsOfPost}">
                                    <c:forEach var="comment" items="${commentsOfPost}">
                                        <c:set var="userId" value="${comment.userId}"/>
                                        <c:url var="profileURL" value="${contextPath}/user/profile">
                                            <c:param name="id" value="${userId}"/>
                                        </c:url>
                                        <!-- comment -->
                                        <c:if test="${comment.parentId == 0}">
                                            <div class="media">
                                                <div class="media-left">
                                                    <a href="${profileURL}"><img class="media-object" src="${pageContext.request.contextPath}/Resources/img/${commentedUsers[userId].userId}/${commentedUsers[userId].avatar}" alt=""></a>
                                                </div>
                                                <div class="media-body">
                                                    <div class="comment">
                                                        <div class="media-heading">
                                                            <h4>
                                                                <a href="${profileURL}" class="username" data-username=" ${commentedUsers[userId].fullname}">
                                                                    ${commentedUsers[userId].fullname}
                                                                </a>
                                                            </h4>
                                                            <span class="time">
                                                                <fmt:formatDate var="commentTime" value="${comment.commentTime}" type="date" dateStyle="short" pattern="HH:mm:ss dd/MM/yyyy"/>
                                                                <c:out value="${commentTime}" />
                                                            </span>
                                                        </div>
                                                        <p><c:out value="${comment.content}" /></p>
                                                        <a data-toggle="collapse" href="#formReplyTo_${comment.commentId}" role="button" aria-expanded="false" aria-controls="formReplyTo_${comment.commentId}">Trả lời</a>

                                                    </div>

                                                    <!-- comment -->
                                                    <c:forEach var="childComment" items="${commentsOfPost}">
                                                        <c:set var="childUserId" value="${childComment.userId}"/>
                                                        <c:url var="childPofileURL" value="${contextPath}/user/profile">
                                                            <c:param name="id" value="${childUserId}"/>
                                                        </c:url>
                                                        <c:if test="${childComment.parentId == comment.commentId}">
                                                            <div class="media media-author">
                                                                <div class="media-left">
                                                                    <a href="${childPofileURL}"><img class="media-object" src="${pageContext.request.contextPath}/Resources/img/${commentedUsers[childUserId].userId}/${commentedUsers[childUserId].avatar}" alt=""></a>
                                                                </div>
                                                                <div class="media-body">
                                                                    <div class="comment">
                                                                        <div class="media-heading">
                                                                            <h4>
                                                                                <a href="${childPofileURL}" class="username" data-username=" ${commentedUsers[childUserId].fullname}">
                                                                                    ${commentedUsers[childUserId].fullname}
                                                                                </a>
                                                                            </h4>
                                                                            <span class="time">
                                                                                <fmt:formatDate var="childCommentTime" value="${childComment.commentTime}" type="date" dateStyle="short" pattern="HH:mm:ss dd/MM/yyyy"/>
                                                                                <c:out value="${childCommentTime}" />
                                                                            </span>
                                                                        </div>
                                                                        <p><c:out value="${childComment.content}" /></p>
                                                                        <a data-toggle="collapse" href="#formReplyTo_${comment.commentId}" role="button" aria-expanded="false" aria-controls="formReplyTo_${childComment.commentId}">Trả lời</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                    <div class="collapse" id="formReplyTo_${comment.commentId}">
                                                        <br>
                                                        <form class="post-reply" action="${pageContext.request.contextPath}/post/detail/comment" method="POST">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <input name="postId" value="${postBean.postId}" type="hidden">
                                                                    <input name="parentId" value="${comment.commentId}" type="hidden">
                                                                    <div class="form-group">
                                                                        <textarea class="input" name="message" placeholder="Nhập bình luận" required="true"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <button class="primary-button">Gửi</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <!-- /comment -->
                                                </div>
                                            </div>
                                        </c:if>
                                        <!-- /comment -->
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <!-- /post comments -->
                        <c:choose>
                            <c:when test="${sessionScope.userBean != null}">
                                <!-- post reply -->
                                <div class="section-row">
                                    <form class="post-reply" action="${pageContext.request.contextPath}/post/detail/comment" method="POST">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <input name="postId" value="${postBean.postId}" type="hidden">
                                                <input name="parentId" value="0" type="hidden">
                                                <div class="form-group">
                                                    <textarea class="input" name="message" placeholder="Nhập bình luận" required="true"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <button class="primary-button">Gửi</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- /post reply -->
                            </c:when>    
                            <c:otherwise>
                                <em>Bạn cần phải đăng nhập để gửi bình luận</em>
                                &nbsp;
                                <b>
                                    <a class="dropdown-toggle" href="javascript:void" data-toggle="modal" data-target="#authenticationModal">
                                        Đăng nhập
                                    </a>
                                </b>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <p>Bài viết không tồn tại</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-4">
                <div class="sticky-top-mt-8">
                    <div class="aside-widget">
                        <c:url var="likePostURL" value="${contextPath}/post/detail/like">
                            <c:param name="postId" value="${postBean.postId}" />
                        </c:url>
                        <button id="likePostBtn" class="btn btn-primary" data-postId="${postBean.postId}" data-action="${likePostURL}" data-isLiked="${isLiked}">
                            <c:choose>
                                <c:when test="${!isLiked}">
                                    <i class="far fa-heart"></i>
                                    &nbsp;
                                    Like
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-heart"></i>
                                    &nbsp;
                                    Liked
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </div>
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
                                        <img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt="${postURL}">
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
                                        <c:param name="name" value="${post.postTitleUnsigned}"/>
                                        <c:param name="%" value="${post.postId}"/>
                                    </c:url>
                                    <a class="post-img" href="${postURL}">
                                        <img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt="${postURL}">
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
        </div>   
    </jsp:body>
</t:layout>