<%-- 
    Document   : login
    Created on : Jun 2, 2020, 5:01:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Series ${mainName}</jsp:attribute>
    <jsp:body>
        <t:listPost>
            <jsp:attribute name="anotherInfo">Another info process here</jsp:attribute>
        </t:listPost>
    </jsp:body>    
</t:layout>
