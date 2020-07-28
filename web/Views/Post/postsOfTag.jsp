<%-- 
    Document   : login
    Created on : Jun 2, 2020, 5:01:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="tagBean" value="${requestScope.tagBean}" />

<t:layout>
    <jsp:attribute name="title">Tag ${tagBean.tagName}</jsp:attribute>
    <jsp:body>
        <c:choose>
            <c:when test="${tagBean == null || empty tagBean}">
                <!--Tag không tồn tại-->
            </c:when>
            <c:otherwise>
                <h1>Các bài viết thuộc tag ${tagBean.tagName}</h1>
                <t:listPost>
                    <jsp:attribute name="anotherInfo"></jsp:attribute>
                </t:listPost>
            </c:otherwise>
        </c:choose>        
    </jsp:body>    
</t:layout>
