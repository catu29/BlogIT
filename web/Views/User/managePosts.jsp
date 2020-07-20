<%-- 
    Document   : managePosts
    Created on : Jul 5, 2020, 12:01:14 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Manage Posts</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="title">My Posts</h3>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="post post-sm">
                                <a class="post-img" href=""><img src="${pageContext.request.contextPath}/Resources/img/post-13.jpg" alt=""></a>
                                <div class="post-body">
                                    <div class="post-category">
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <h3 class="post-title title-sm"><a href="">Post Name</a></h3>
                                    <ul class="post-meta">
                                        <li><a href="">John Doe</a></li>
                                        <li>20 April 2018</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="post post-sm">
                                <a class="post-img" href=""><img src="${pageContext.request.contextPath}/Resources/img/post-13.jpg" alt=""></a>
                                <div class="post-body">
                                    <div class="post-category">
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <h3 class="post-title title-sm"><a href="">Post Name</a></h3>
                                    <ul class="post-meta">
                                        <li>20 April 2018</li>
                                    </ul>
                                    <h3 class="post-title title-sm">
                                        <a href=""><i class="fas fa-edit"></i></a>&nbsp;
                                        <a href="">Disable</a>&nbsp;
                                    </h3>
                                </div>
                            </div>
                        </div>
                                
                        <div class="col-md-4">
                            <div class="post post-sm">
                                <a class="post-img" href=""><img src="${pageContext.request.contextPath}/Resources/img/post-13.jpg" alt=""></a>
                                <div class="post-body">
                                    <div class="post-category">
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <h3 class="post-title title-sm"><a href="">Post Name</a></h3>
                                    <ul class="post-meta">
                                        <li><a href="">John Doe</a></li>
                                        <li>20 April 2018</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-md-3">
                <!-- ad widget -->
                <div class="aside-widget text-center">
                    <a href="#" style="display: inline-block;margin: auto;">
                        <img class="img-responsive" src="" alt="">
                    </a>
                </div>
                <!-- /ad widget -->

                <!-- category widget -->
                <div class="aside-widget">
                    <div class="section-title">
                        <h2 class="title">Categories</h2>
                    </div>
                    <div class="category-widget">
                        <ul>
                            <li><a href="#">Lifestyle <span>451</span></a></li>
                            <li><a href="#">Fashion <span>230</span></a></li>
                            <li><a href="#">Technology <span>40</span></a></li>
                            <li><a href="#">Travel <span>38</span></a></li>
                            <li><a href="#">Health <span>24</span></a></li>
                        </ul>
                    </div>
                </div>
                <!-- /category widget -->

                <!-- post widget -->
                <div class="aside-widget">
                    <div class="section-title">
                        <h2 class="title">Popular Posts</h2>
                    </div>
                    <!-- post -->
                    <div class="post post-widget">
                        <a class="post-img" href="blog-post.html"><img src="" alt=""></a>
                        <div class="post-body">
                            <div class="post-category">
                                <a href="category.html">Lifestyle</a>
                            </div>
                            <h3 class="post-title"><a href="blog-post.html">Ne bonorum praesent cum, labitur persequeris definitionem quo cu?</a></h3>
                        </div>
                    </div>
                    <!-- /post -->
                </div>
                <!-- /post widget -->
            </div>
        </div>
    </jsp:body>
</t:layout>
