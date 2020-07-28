<%-- 
    Document   : managePosts
    Created on : Jul 5, 2020, 12:01:14 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Quản lý người dùng</jsp:attribute>
    <jsp:body>
        <div class="row">
            <t:userInfo/>
            <div class="col-md-9">
                <div class="row">
                    <h3 class="title col-md-12">Danh sách người dùng</h3>
                    <br>
                    <table class="table col-md-12">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Email</th>
                                <th scope="col">Họ tên</th>
                                <th scope="col">Bio</th>
                                <th scope="col">Vai trò</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <body>
                            <tr>
                                <td scope="col"></td>
                                <td scope="col"></td>
                                <td scope="col"></td>
                                <td scope="col"></td>
                                <td scope="col"></td>
                                <td scope="col"></td>
                            </tr>
                        </body>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout>
