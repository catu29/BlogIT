<%-- 
    Document   : login
    Created on : Jun 2, 2020, 5:01:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<c:set var="userDTO" value="${requestScope.userDTO}" />
<c:set var="isInvalid" value="${requestScope.isInvalid}" />
<c:set var="message" value="${requestScope.message}" />


<t:layout>
    <jsp:attribute name="title">Create new account</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">               
                <h1>Đăng nhập</h1>
                <p style="color: red;">
                    <c:if test="${isInvalid}"><c:out value="${message}" /></c:if>
                </p>
                <form id="loginForm" action="" method="POST">                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="${userDTO.email}">
                        <p style="color: red;">
                            <c:if test="${isInvalid && empty userDTO.email}" >
                                <c:out value="Trường không được để trống" />
                            </c:if>
                        </p>
                    </div>                    
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" class="form-control" id="password" name="password" value="${userDTO.password}">
                        <p style="color: red;">
                            <c:if test="${isInvalid && empty userDTO.password}" >
                                <c:out value="Trường không được để trống" />
                            </c:if>
                        </p>
                    </div>
                             
                    <button type="submit" class="primary-button">Đăng nhập</button>
                </form>
            </div>
        </div>
    </jsp:body>    
</t:layout>
