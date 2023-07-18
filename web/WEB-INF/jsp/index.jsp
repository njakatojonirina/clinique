<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Index</title>
        <%@include file="link.jsp" %> 
    </head>

    <body>
        <div class="container-scroller">
      <!-- partial:partials/_sidebar.html -->
            <nav class="sidebar sidebar-offcanvas" id="sidebar">
                <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
                    <a class="sidebar-brand brand-logo" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo.svg" alt="logo" /></a>
                    <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo-mini.svg" alt="logo" /></a>
                </div>
                <ul class="nav">
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="<%=request.getContextPath()%>/login?type=1" >
                            <span class="menu-icon">
                                <i class="mdi mdi-laptop"></i>
                            </span>
                          <span class="menu-title">Admin</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="<%=request.getContextPath()%>/login?type=2">
                            <span class="menu-icon">
                                <i class="mdi mdi-playlist-play"></i>
                            </span>
                            <span class="menu-title">User</span>
                        </a>
                    </li>
                </ul>
            </nav>
      <!-- partial -->
            <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
                <%@include file="navigateur.jsp" %>     
        <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <%@include file="Updatepro.jsp" %>     
                        </div>
                    </div>
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.html -->
                    <%@include file="footer.jsp" %>
          <!-- partial -->
                </div>
        <!-- main-panel ends -->
            </div>
      <!-- page-body-wrapper ends -->
        </div>
    </body>
</html>
