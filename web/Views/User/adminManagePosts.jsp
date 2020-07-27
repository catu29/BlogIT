<%-- 
    Document   : managePosts
    Created on : Jul 5, 2020, 12:01:14 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Quản lý bài viết</jsp:attribute>
    <jsp:body>
        <div class="row">
            <t:userInfo/>
            <div class="col-md-9">
                <h3 class="title">Danh sách bài viết</h3>
                <t:userListPost/>
            </div>
        </div>
    </jsp:body>
</t:layout>
