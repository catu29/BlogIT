<%-- 
    Document   : authenticationModal
    Created on : Apr 28, 2020, 3:33:30 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="authenticationModal" class="modal fade modal-authentication" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Login</h4>
            </div>
            <div class="modal-body">
                <form action="LoginServlet" method="POST">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="input" id="email" name="email" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" class="input" id="password" name="password" placeholder="Password">
                    </div>
                    <div class="form-group">
                        <input type="checkbox" class="form-check-input" id="rememberCheck">
                        <label class="form-check-label" for="rememberCheck">Remember me</label>
                    </div>
                    <button type="submit" class="primary-button btn-block">Đăng nhập</button>
                </form>
                
            </div>
            <div class="modal-footer">
                <span class="pull-left">
                    <span>Chưa có tài khoản?&nbsp;</span>
                    <a href="${pageContext.request.contextPath}/user/register">Đăng ký ngay</a>
                </span>        
            </div>
        </div>
    </div>
</div>