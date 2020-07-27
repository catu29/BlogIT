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

<c:set var="mainBean" value="${requestScope.mainBean}" />
<c:set var="mainName" value="${requestScope.mainName}" />
<c:set var="listPosts" value="${requestScope.listPosts}" />
<c:set var="authorOfPost" value="${requestScope.authorOfPost}" />
<c:set var="seriesOfPost" value="${requestScope.seriesOfPost}" />

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="anotherInfo" fragment="true"%>

<%-- any content can be specified here e.g.: --%>
<c:choose>
    <c:when test="${mainBean == null}">
        Không tồn tại
    </c:when>
    <c:otherwise>
        <h1>${mainName}</h1>
        <c:choose>
            <c:when test="${listPosts == null || empty listPosts}">
                Chưa có bài viết nào
            </c:when>
            <c:otherwise>
                <c:forEach var="post" items="${listPosts}">
                    <c:url var="postURL" value="${contextPath}/post/detail">
                        <c:param name="name" value="${post.postTitleUnsigned}"/>
                        <c:param name="%" value="${post.postId}"/>
                    </c:url>
                    <!-- Post Image -->
                    <div>                        
                        <a href="${postURL}"><img src="${pageContext.request.contextPath}/Resources/img/${post.userId}/${post.image}" alt=""></a>
                    </div>
                    <!-- /Post Image -->
                    <!-- Post Title -->
                    <div>                       
                        <a href="${postURL}">${post.postTitle}</a>
                    </div>
                    <!-- /Post Title -->
                    <!-- Post Author -->
                    <div>
                        <c:set var="authorId" value="${post.userId}"/>
                        <c:url var="authorURL" value="${contextPath}/user/profile">
                            <c:param name="id" value="${authorId}"/>
                        </c:url>
                        <a href="${authorURL}">${authorOfPost[authorId].fullname}</a>
                    </div>
                    <!-- /Post Author -->
                    <!-- Post Series -->
                    <div>
                        <c:set var="seriesId" value="${post.seriesId}"/>
                        <c:url var="seriesURL" value="${contextPath}/series">
                            <c:param name="id" value="${seriesId}"/>
                        </c:url>
                        <a href="${seriesURL}">${seriesOfPost[seriesId].seriesName}</a>
                    </div>
                    <!-- /Post Series -->
                    <!-- Post Time -->
                    <div>
                        <fmt:formatDate var="postTime" value="${post.postTime}" type="date" dateStyle="short" pattern="HH:mm:ss dd/MM/yyyy"/>
                        <c:out value="${postTime}" />
                    </div>
                    <!-- /Post Time -->
                    <!-- Post SubTitle -->
                    <div>
                        <c:out value="${post.postSubTitle}"/>
                    </div>
                    <!-- /Post SubTitle -->
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
<jsp:invoke fragment="anotherInfo"></jsp:invoke>