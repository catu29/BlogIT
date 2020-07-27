<%-- 
    Document   : userManageSeries
    Created on : Jul 28, 2020, 1:01:27 AM
    Author     : TranCamTu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:set var="seriesList" value="${requestScope.seriesList}" />
<c:set var="countPost" value="${requestScope.countPost}" />

<t:layout>
    <jsp:attribute name="title">Quản lý series</jsp:attribute>
    <jsp:body>
        <div class="row">
            <t:userInfo/>
            <div class="col-md-9">
                <h3 class="title">Danh sách series</h3>
                <c:choose>
                    <c:when test="${fn:length(seriesList) != 0 && not empty seriesList && seriesList != null}">
                        <c:forEach var="series" items="${seriesList}">
                            <div>
                                <c:url var="seriesURL" value="${contextPath}/series">
                                    <c:param name="id" value="${series.seriesId}"/>
                                </c:url>
                                <a href="${seriesURL}"><h4>${series.seriesName}</h4></a>
                                <c:out value="${countPost[series.seriesId]} bài viết"/>
                            </div>
                            <div>
                                <c:if test="${userBean != null}">
                                    <c:url var="seriesUpdateURL" value="${contextPath}/series/update">
                                        <c:param name="id" value="${series.seriesId}"/>
                                    </c:url>
                                    <a href="${seriesUpdateURL}" class="primary-button">Cập nhật</a>

                                    <c:url var="seriesDeleteURL" value="${contextPath}/series/delete">
                                        <c:param name="id" value="${series.seriesId}"/>
                                    </c:url>
                                    <a href="${seriesDeleteURL}" class="secondary-button">Xóa series</a>
                                </c:if>
                            </div>
                            <hr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        Chưa có series nào
                    </c:otherwise>
                </c:choose>                
            </div>
        </div>
    </jsp:body>
</t:layout>
