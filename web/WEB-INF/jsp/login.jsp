<%-- 
    Document   : login
    Created on : 24 mai 2023, 20:35:16
    Author     : ASUS
--%>
<%
    String type = (String) request.getAttribute("type");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <div class="container-fluid page-body-wrapper full-page-wrapper">
                <div class="row w-100 m-0">
                    <div class="content-wrapper full-page-wrapper d-flex align-items-center auth login-bg">
                        <div class="card col-lg-4 mx-auto">
                            <div class="card-body px-5 py-5">
                                <h3 class="card-title text-left mb-3">Login</h3>
                                <form method="POST" action="<%=request.getContextPath() %>/logincontrol">
                                    <input type="hidden" name="type" value="<%=type%>" />
                                    <div class="form-group">
                                        <label>Username or email *</label>
                                        <input type="text" name="login" class="form-control p_input" required="">
                                    </div>
                                    <div class="form-group">
                                        <label>Password *</label>
                                        <input type="text" name="mdp" class="form-control p_input" required="">
                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <div class="form-check">
                                            <label class="form-check-label">
                                            <input type="checkbox" class="form-check-input"> Remember me </label>
                                        </div>
                                        <a href="#" class="forgot-pass">Forgot password</a>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary btn-block enter-btn">Login</button>
                                    </div>
                                    <div class="d-flex">
                                        <button class="btn btn-facebook mr-2 col">
                                        <i class="mdi mdi-facebook"></i> Facebook </button>
                                        <button class="btn btn-google col">
                                        <i class="mdi mdi-google-plus"></i> Google plus </button>
                                    </div>
                                    <p class="sign-up">Don't have an Account?<a href="<%=request.getContextPath()%>/inscription"> Sign Up</a></p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
