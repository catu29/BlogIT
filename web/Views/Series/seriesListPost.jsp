<%-- 
    Document   : login
    Created on : Jun 2, 2020, 5:01:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="seriesBean" value="${requestScope.seriesBean}" />

<t:layout>
    <jsp:attribute name="title">Series ${seriesBean.seriesName}</jsp:attribute>
    <jsp:body>
        <c:choose>
            <c:when test="${seriesBean == null}">
                Series không tồn tại
            </c:when>
            <c:otherwise>
                <h1>Các bài viết thuộc series ${seriesBean.seriesName}</h1>
                <t:listPost>
                    <jsp:attribute name="anotherInfo">Another info process here</jsp:attribute>
                </t:listPost>
            </c:otherwise>
        </c:choose>        
    </jsp:body>    
</t:layout>
