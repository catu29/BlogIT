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
    <jsp:attribute name="title">Tạo bài viết</jsp:attribute>
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
                    <form class="col-md-12" method="POST" action="${pageContext.request.contextPath}/post/create" enctype="multipart/form-data">
                        <input name="userId" value="${userBean.userId}" type="hidden"> 
                        <div class="form-group">
                            <label for="title">Tiêu đề</label>
                            <input name="title" type="text" class="form-control" id="title" required value="${postBean.title}"
                                   oninvalid="this.setCustomValidity('Trường không được để trống.')">
                            <c:if test="${isInvalid && (postDTO.title == null || empty postDTO.title)}">
                                <p style="color: red;">Trường không được để trống.</p>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label for="tags">Tags</label>
                            <select name="tags" class="form-control select2-multi" id="tags" required multiple="true">
                                <c:forEach var="tag" items="${listTags}">
                                    <option value="${tag.tagId}">${tag.tagName}</option>
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
                                    <option value="${series.seriesId}">${series.seriesName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="seriesOrder">Thứ tự bài viết trong series</label>
                            <input name="seriesOrder" type="number" class="form-control" id="seriesOrder" min="1" value="1"
                                   oninvalid="this.setCustomValidity('Vui lòng nhập vào số nguyên dương.')">
                        </div>
                        <!-- NOTE: If choose radio existingSeries, this field is required -->
                        <!-- TODO: If variable 'postBean.seriesOrder' has value, show it at 'value' field here -->
                        <div class="custom-file-container" data-upload-id="myUniqueUploadId">
                            <label>Upload File <a href="javascript:void(0)" class="custom-file-container__image-clear" title="Clear Image">&times;</a></label>

                            <label class="custom-file-container__custom-file" >
                                <input type="file" class="custom-file-container__custom-file__custom-file-input" accept="*" multiple aria-label="Choose File">
                                <input type="hidden" name="MAX_FILE_SIZE" value="10485760" />
                                <span class="custom-file-container__custom-file__custom-file-control"></span>
                            </label>
                            <div class="custom-file-container__image-preview"></div>
                        </div>
                        <div class="form-group">
                            <label for="image">Ảnh bài viết</label>
                            <div class="custom-file">
                                <input name="image" class="custom-file-input" type="file" id="image" accept="image/png, image/jpeg, image/jpg" required>
                                <label class="custom-file-label" for="image">File sẽ được thay thế</label>
                            </div
                            <br>
                        </div>
                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea name="description" type="text" class="form-control" id="description" required></textarea>
                            <c:if test="${isInvalid && (postDTO.postSubTitle == null || empty postDTO.postSubTitle)}">
                                <p style="color: red;">Trường không được để trống.</p>
                            </c:if>
                            <!-- TODO: If variable 'postBean.postSubTitle' has value, show it here -->
                        </div>
                        <div class="form-group">
                            <label for="content">Nội dung bài viết</label>
                            <textarea name="content" type="text" class="form-control" id="content" required></textarea>
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
