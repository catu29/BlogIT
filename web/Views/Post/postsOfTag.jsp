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
    <jsp:attribute name="title">Login</jsp:attribute>
    <jsp:body>
        Tag page
    </jsp:body>    
</t:layout>
