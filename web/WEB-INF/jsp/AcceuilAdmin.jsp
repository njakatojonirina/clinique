<%-- 
    Document   : BackOffice
    Created on : 31 mai 2023, 17:51:04
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <%@include file="navbarAdmin.jsp" %>
            <div class="container-fluid page-body-wrapper">
                <%@include file="navigateur.jsp" %>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <%@include file="Updatepro.jsp" %> 
                            <div class="col-12 grid-margin stretch-card">
                                
                            </div>
                        </div>
                    </div>
                    <%@include file="footer.jsp" %>
                </div>
             </div>
        </div>
    </body>
</html>
