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
<c:set var="confirmPassword" value="${requestScope.confirmPassword}" />

<t:layout>
    <jsp:attribute name="title">Thay đổi thông tin cá nhân</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">               
                <h1>Thay đổi thông tin cá nhân</h1>
                <p style="color: red;"><c:out value="${message}" /></p>
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
                        <input name="fullname" type="text" class="form-control" id="fullname" required value="${userBean.fullname}">
                    </div>
                    <div class="form-group">
                        <label for="bio">Giới thiệu</label>
                        <textarea name="bio" type="text" class="form-control" id="bio" required>${userBean.bio}</textarea>
                        <c:if test="${isInvalid && (userBean.bio == null || empty userBean.bio)}">
                            <p style="color: red;">Trường không được để trống.</p>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input name="password" type="password" class="form-control" id="password" required>
                        <p style="color: red;">
                            <c:if test="${empty userBean.password && isInvalid}">
                                <c:out value="Trường không được để trống"/>
                            </c:if>
                        </p>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Nhập lại mật khẩu</label>
                        <input name="confirmPassword" type="password" class="form-control" id="confirmPassword" required>
                        <p style="color: red;">
                            <c:choose>
                                <c:when test="${empty confirmPassword && isInvalid}">
                                    <c:out value="Trường không được để trống"/>  
                                </c:when>
                                <c:when test="${userBean.password != confirmPassword && isInvalid}">
                                    <c:out value="Mật khẩu xác nhận chưa đúng"/>
                                </c:when>
                            </c:choose>
                        </p>
                    </div>                                       
                    <div class="form-group">
                        <button type="submit" class="btn primary-button">Lưu thay đổi</button>
                    </div>
                </form>                
            </div>
        </div>
    </jsp:body>    
</t:layout>