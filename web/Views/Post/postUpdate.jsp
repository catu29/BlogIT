<%-- 
    Document   : postDetail
    Created on : Jul 13, 2020, 3:35:31 PM
    Author     : TranCamTu
--%>
<%@page import="Beans.SessionBeanUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<c:set var="tagsOfPost" value="${requestScope.tagsOfPost}" />
<c:set var="userProfile" value="${requestScope.userProfile}" />
<c:set var="listPosts" value="${requestScope.listPosts}" />

<t:layout>
    <jsp:attribute name="js">
        <script src="${pageContext.request.contextPath}/Resources/vendors/ckeditor/ckeditor.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Post/postEdit.js"></script>
    </jsp:attribute>
    <jsp:attribute name="title">${userProfile.fullname}</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-md-3">
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
            <div class="col-md-9">
                <div class="row">
                    <form class="col-md-12">
                        <div class="form-group">
                            <label for="title">Tiêu đề</label>
                            <input name="title" type="text" class="form-control" id="title">
                        </div>
                        <div class="form-group">
                            <label for="tags">Tags</label>
                            <select class="select2-multi form-control" multiple="true" name="tags" type="text" id="tags">
                                <option value="1">tag1</option> 
                                <option value="2">tag2</option> 
                                <option value="3">tag3</option> 
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="series">Series</label>
                            <select name="series" type="text" class="select2 form-control" id="series">
                                <option value="">Select an option...</option> 
                                <option value="1">tag1</option> 
                                <option value="2">tag2</option> 
                                <option value="3">tag3</option> 
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea name="description" type="text" class="form-control" id="description"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="content">Nội dung bài viết</label>
                            <textarea name="content" type="text" class="form-control" id="content"></textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn primary-button">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout>



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