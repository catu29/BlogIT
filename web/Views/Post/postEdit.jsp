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


<c:set var="seriesBean" value="${requestScope.seriesBean}" />
<c:set var="currentTagsOfPost" value="${requestScope.currentTagsOfPost}" />
<c:set var="currentTagIdsOfPost" value="${requestScope.currentTagIdsOfPost}" />
<c:set var="postBean" value="${requestScope.postBean}" />
<c:set var="listTags" value="${requestScope.listTags}" />
<c:set var="userSeriesList" value="${requestScope.userSeriesList}" />
<c:set var="message" value="${requestScope.message}" />
<c:set var="postDTO" value="${requestScope.postDTO}" />
<c:set var="isInvalid" value="${requestScope.isInvalid}" />
<c:set var="userBean" value="${sessionScope.userBean}" />

<t:layout>
    <jsp:attribute name="js">
        <script src="${pageContext.request.contextPath}/Resources/vendors/ckeditor/ckeditor.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Post/postEdit.js"></script>
    </jsp:attribute>
    <jsp:attribute name="title">Sửa bài viết</jsp:attribute>
    <jsp:body>
        <div class="row">
            <c:choose>
                <c:when test="${userBean == null}">
                    <p style="color: red;">${message}</p>
                </c:when>
                <c:otherwise>
                    <t:userInfo/>
                </c:otherwise>
            </c:choose>
            <div class="col-md-9">
                <div class="row">
                    <c:url var="updateAction" value="${contextPath}/post/detail/update">
                        <c:param name="postId" value="${postBean.postId}"></c:param>
                    </c:url>
                    <form class="col-md-12" method="POST" action="${updateAction}" enctype="multipart/form-data">
                        <input name="userId" value="${userBean.userId}" type="hidden"> 
                        <div class="form-group">
                            <label for="title">Tiêu đề</label>
                            <input name="title" type="text" class="form-control" id="title" required value="${postBean.postTitle}"
                                   oninvalid="this.setCustomValidity('Trường không được để trống.')">
                            <c:if test="${isInvalid && (postDTO.title == null || empty postDTO.title)}">
                                <p style="color: red;">Trường không được để trống.</p>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label for="tags">${currentTagsOfPost.size()}</label>
                            <select name="tags" class="form-control select2-multi" id="tags" required multiple="true">
                                <c:forEach var="tag" items="${listTags}">
                                    <c:choose>
                                        <c:when test="{fn:contains(currentTagIdsOfPost, tag.tagId)}">
                                            <option value="${tag.tagId}" selected>${tag.tagName}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${tag.tagId}">${tag.tagName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="series">
                                <span>Series</span>&nbsp;
                                <button id="addNewSeriesBtn" class="btn btn-sm btn-secondary" title="Thêm mới series" type="button" data-toggle="modal" data-target="#addNewSeriesModal">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </label>
                            <select name="series" class="form-control select2" id="seriesDropdown">
                                <option value="">Select an option...</option>
                                <c:forEach var="series" items="${userSeriesList}">
                                    <c:choose>
                                        <c:when test="${series.seriesId == postBean.seriesId}">
                                            <option value="${series.seriesId}" selected>${series.seriesName}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${series.seriesId}">${series.seriesName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="seriesOrder">Thứ tự bài viết trong series</label>
                            <input name="seriesOrder" type="number" class="form-control" id="seriesOrder" min="1" value="${postBean.seriesOrder}"
                                   oninvalid="this.setCustomValidity('Vui lòng nhập vào số nguyên dương.')">
                        </div>
                        <!-- NOTE: If choose radio existingSeries, this field is required -->
                        <!-- TODO: If variable 'postBean.seriesOrder' has value, show it at 'value' field here -->
                        <div class="custom-file-container" data-upload-id="myUniqueUploadId">
                            <label for="image">Ảnh bài viết <a href="javascript:void(0)" class="custom-file-container__image-clear" title="Clear Image">&times;</a></label>

                            <label class="custom-file-container__custom-file" >
                                <input data-userid="${postBean.userId}" data-imgurl="${postBean.image}" id="image" name="image" type="file" class="custom-file-container__custom-file__custom-file-input" accept="image/png, image/jpeg, image/jpg" aria-label="Choose File" required>
                                <input type="hidden" name="MAX_FILE_SIZE" value="10485760" />
                                <span class="custom-file-container__custom-file__custom-file-control"></span>
                            </label>
                            <div class="custom-file-container__image-preview"></div>
                        </div>
                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea name="description" type="text" class="form-control" id="description" required>
                                ${postBean.postSubTitle}
                            </textarea>
                            <c:if test="${isInvalid && (postDTO.postSubTitle == null || empty postDTO.postSubTitle)}">
                                <p style="color: red;">Trường không được để trống.</p>
                            </c:if>
                            <!-- TODO: If variable 'postBean.postSubTitle' has value, show it here -->
                        </div>
                        <div class="form-group">
                            <label for="content">Nội dung bài viết</label>
                            <textarea name="content" type="text" class="form-control" id="content" required>
                                ${postBean.postContent}
                            </textarea>
                            <c:if test="${isInvalid && (postDTO.postContent == null || empty postDTO.postContent)}">
                                <p style="color: red;">Trường không được để trống.</p>
                            </c:if>
                            <!-- TODO: If variable 'postBean.postContent' has value, show it here -->
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
