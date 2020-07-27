<%-- 
    Document   : userEditProfile
    Created on : Jul 27, 2020, 1:27:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="isInvalid" value="${requestScope.isInvalid}" />
<c:set var="message" value="${requestScope.message}" />

<t:layout>
    <jsp:attribute name="title">Thay đổi thông tin cá nhân</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">               
                <h1>Thay đổi thông tin cá nhân</h1>
                <c:if test="${isInvalid == true && message != null}"><p style="color: red;"><c:out value="${message}" /></p></c:if>
                <form class="col-md-12" method="POST" action="${pageContext.request.contextPath}/user/edit-profile" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="avatar">Ảnh đại diện</label>
                        <div class="custom-file">
                            <input name="avatar" class="custom-file-input" type="file" id="avatar" accept="image/png, image/jpeg, image/jpg">
                            <label class="custom-file-label" for="avatar">File sẽ được thay thế</label>
                        </div
                        <br>
                    </div>                    
                    <div class="form-group">
                        <label for="fullname">Họ và tên</label>
                        <input name="fullname" type="text" class="form-control" id="fullname" value="${userBean.fullname}">
                    </div>
                    <div class="form-group">
                        <label for="bio">Giới thiệu</label>
                        <textarea name="bio" type="text" class="form-control" id="bio">${userBean.bio}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu mới</label>
                        <input name="password" type="password" class="form-control" id="password">
                    </div>                                                      
                    <div class="form-group">
                        <button type="submit" class="btn primary-button">Lưu thay đổi</button>
                    </div>
                </form>                
            </div>
        </div>
    </jsp:body>    
</t:layout>