<%-- 
    Document   : authenticationModal
    Created on : Jul 27, 2020
    Author     : Tin Bui
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:set var="currentURL" value="<%=request.getRequestURL()%>"/>
<c:set var="currentQueryString" value="<%=request.getQueryString()%>"/>


<div id="addNewSeriesModal" class="modal fade modal-authentication" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Thêm mới series</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/series/create" method="POST">
                    <div class="form-group">
                        <label for="seriesName">Tên Series</label>
                        <input type="text" class="input" id="seriesName" name="seriesName" required="true" oninvalid="this.setCustomValidity('Trường không được để trống.')">
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="curURL" value="${currentURL}">
                        <input type="hidden" id="curQueryString" value="${currentQueryString}">
                    </div>
                    <button type="submit" class="primary-button btn-block">Lưu</button>
                </form>
            </div>
        </div>
    </div>
</div>