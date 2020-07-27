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

<t:layout>
    <jsp:attribute name="title">${userProfile.fullname}</jsp:attribute>
    <jsp:body>
        <div class="row">
            <t:userInfo/>
            <t:userListPost/>
        </div>
    </jsp:body>
</t:layout>
