<%-- 
    Document   : layout
    Created on : Apr 28, 2020, 10:33:37 AM
    Author     : Tin Bui
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@tag description="main layout" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="title" required="true"%>
<%@attribute name="postHeader" fragment="true"%>
<%@attribute name="css" fragment="true"%>
<%@attribute name="js" fragment="true"%>

<c:set var="userBean" value="${sessionScope.userBean}" />

<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="asset-path" content="${pageContext.request.contextPath}/Resources/">

        <title>
            ${title}
        </title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700%7CMuli:400,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/bootstrap/bootstrap.min.css" />

        <!-- Font Awesome Icon -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/fontawesome-free/css/all.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/fullscreen-loader/css/jquery.loadingModal.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/lobibox/css/lobibox.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/select2/select2.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/select2/select2-bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/vendors/file-upload-with-preview/file-upload-with-preview.min.css"/>

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Root/style.css" />
        <!-- custom css -->
        <jsp:invoke fragment="css"></jsp:invoke>
        </head>
        <body>
            <div class="navbar sticky-top" style=" border-bottom: 1px solid #e8eaed">
                <a class="navbar-brand mx-auto" href="${pageContext.request.contextPath}">
                <img src="${pageContext.request.contextPath}/Resources/img/logo.png" alt="">
            </a>
        </div>
        <nav class="navbar navbar-expand-lg sticky-top shadow-sm" style="background: #fff;">
            <div class="container">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarText">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="${pageContext.request.contextPath}">Trang chủ <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/post/create">Tạo bài viết</a>
                        </li>
                    </ul>
                    <form class="form-inline mr-auto" id="searchForm" action="${pageContext.request.contextPath}/search" method="POST">
                        <div class="input-group">
                            <input class="form-control" name="search">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-secondary"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </form>
                    <form class="form-inline">
                        <c:choose>
                            <c:when test="${userBean != null}">
                                <div class="dropdown">
                                    <button class="dropdown-toggle btn btn-nav-user" type="button" id="userdropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                        <c:choose>
                                            <c:when test="${userBean.avatar != 'null' && userBean.avatar != null && not empty userBean.avatar}">
                                                <img src="${pageContext.request.contextPath}/Resources/img/${userBean.userId}/${userBean.avatar}" alt="">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/Resources/img/default-user.png" alt="">
                                            </c:otherwise>
                                        </c:choose>
                                        &nbsp;
                                        <span>${userBean.fullname}</span>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userdropdown">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile?id=${userBean.userId}">Thông tin cá nhân</a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/post/create">Tạo bài viết</a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <button class="btn primary-button" type="button" data-toggle="modal" data-target="#authenticationModal">
                                    Đăng nhập
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>
        </nav>

        <div id="nav-search">
            <form>
                <input class="input" name="search" placeholder="Enter your search...">
            </form>
            <button class="nav-close search-close">
                <span></span>
            </button>
        </div>

        <!-- HEADER -->
        <header id="header">
            <jsp:invoke fragment="postHeader"></jsp:invoke>
            </header>
            <!-- /HEADER -->
            <div class="section">
                <div class="container">
                <jsp:doBody/>
            </div>
        </div>
    </body>

    <!-- FOOTER -->
    <footer id="footer">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <img src="${pageContext.request.contextPath}/Resources/img/logo-alt.png"
                </div>
                <div class="col-md-4"></div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </footer>
    <!-- /FOOTER -->

    <jsp:include page="../../Views/Shared/authenticationModal.jsp" />
    <jsp:include page="../../Views/Shared/addNewSeriesModal.jsp" />

    <!-- libraries-->
    <script src="${pageContext.request.contextPath}/Resources/vendors/bootstrap/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/bootstrap/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/bootstrap/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/bootstrap/jquery.stellar.min.js"></script>

    <!-- custom js -->
    <script src="${pageContext.request.contextPath}/Resources/vendors/fullscreen-loader/js/jquery.loadingModal.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/lobibox/js/lobibox.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/select2/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/vendors/file-upload-with-preview/file-upload-with-preview.min.js"></script>

    <script src="${pageContext.request.contextPath}/Resources/Root/main.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/Root/helper.js"></script>
    <jsp:invoke fragment="js"></jsp:invoke>
</body>
</html>