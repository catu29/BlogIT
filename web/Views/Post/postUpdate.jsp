<%-- 
    Document   : postDetail
    Created on : Jul 13, 2020, 3:35:31 PM
    Author     : TranCamTu
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="postBean" value="${requestScope.postBean}" />
<c:set var="seriesBean" value="${requestScope.seriesBean}" />
<c:set var="tagsOfPost" value="${requestScope.tagsOfPost}" />

<t:layout>
    <jsp:attribute name="title">${postBean.postTitle}</jsp:attribute>
    <jsp:attribute name="postHeader">
        <!-- PAGE HEADER -->
        <div id="post-header" class="page-header">
            <div class="page-header-bg" style="background-image: url('${pageContext.request.contextPath}/Resources/img/${postBean.image}.jpg');" data-stellar-background-ratio="0.5"></div>
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
                        <h1>TODO: Convert to update page</h1>
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
                        tessr
                        <div class="section-row">
                            <c:if test="${tagsOfPost != null && not empty tagsOfPost}">
                                <div class="post-share">
                                    <c:forEach var="tag" items="${tagsOfPost}">                                    
                                        <c:out value="${tag.tagName}"/>                                                                       
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                        <div class="section-row post-section">
                            ${postBean.postContent}
                        </div>                        
                    </c:when>
                    <c:otherwise>
                        <p>Bài viết không tồn tại</p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>   
    </jsp:body>
</t:layout>