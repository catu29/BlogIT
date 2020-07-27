<%-- 
    Document   : seriesUpdate
    Created on : Jul 28, 2020, 3:32:15 AM
    Author     : TranCamTu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:set var="seriesDTO" value="${requestScope.seriesDTO}" />

<t:layout>
    <jsp:attribute name="title">Quản lý series</jsp:attribute>
    <jsp:body>
        <div class="row">
            <t:userInfo/>
            <div class="col-md-9">
                <h3 class="title">Cập nhật series</h3>
                <h4>${seriesDTO.seriesName}</h4>
                <form action="${pageContext.request.contextPath}/series/update" method="POST">
                    <input type="hiden" name="seriesId" id="seriesId" value="${seriesDTO.seriesId}">
                    <input type="text" name="seriesName" id="seriesName" value="${seriesDTO.seriesName}">
                    <input type="submit" value="Cập nhật">
                </form>              
            </div>
        </div>
    </jsp:body>
</t:layout>