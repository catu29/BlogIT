<%-- 
    Document   : searchResult
    Created on : Jul 28, 2020, 7:06:44 AM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Tìm kiếm</jsp:attribute>
    <jsp:body>        
        <h1>Kết quả tìm kiếm</h1>
        <t:listPost>
            <jsp:attribute name="anotherInfo">Another info process here</jsp:attribute>
        </t:listPost>                  
    </jsp:body>    
</t:layout>
