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
                            <input name="tags" type="text" class="form-control" id="tags">
                        </div>
                        <div class="form-group">
                            <label for="series">Series</label>
                            <input name="series" type="text" class="form-control" id="series">
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
