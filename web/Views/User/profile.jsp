<%-- 
    Document   : profile
    Created on : Jul 11, 2020, 4:35:38 AM
    Author     : TranCamTu
--%>

<%@page import="Beans.SessionBeanUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="userBean" value="${sessionScope.userBean}">
</c:set>

<c:url var="url" value="${pageContext.request.requestURL}">
    <c:param name="id" value="${userBean.userId}"/>
</c:url>

<t:layout>
    <jsp:attribute name="title">Profile</jsp:attribute>
    <jsp:body>
        <h1>Trang cá nhân</h1>        
        <p>Full name: <c:out value="${userBean.fullname}" /></p>        
    </jsp:body>
</t:layout>
