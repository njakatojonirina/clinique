<%-- 
    Document   : BackOffice
    Created on : 31 mai 2023, 17:51:04
    Author     : ASUS
--%>
<%@page import="modele.Tableau_de_board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modele.Utilisateur"%>
<%
    Integer user = (Integer) request.getAttribute("user");
    session.setAttribute("utilisateur", user);
    ArrayList<Tableau_de_board> Tableau_de_board = (ArrayList<Tableau_de_board>) request.getAttribute("Tableau_de_board");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <nav class="sidebar sidebar-offcanvas" id="sidebar">
                <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
                    <a class="sidebar-brand brand-logo" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo.svg" alt="logo" /></a>
                    <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo-mini.svg" alt="logo" /></a>
                </div>
                <ul class="nav">
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="#">
                            <span class="menu-icon">
                                <i class="mdi mdi-speedometer"></i>
                            </span>
                            <span class="menu-title">Tableau de Board</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/listerObject?modele=Actepatient&&param=idutilisateur&&idutilisateur=<%=user%>">
                            <span class="menu-icon">
                                <i class="mdi mdi-hospital"></i>
                            </span>
                            <span class="menu-title">Acte</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/ListeDepensedetails?idutilisateur=<%=user%>">
                            <span class="menu-icon">
                                <i class="mdi mdi-coin"></i>
                            </span>
                            <span class="menu-title">Depense</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="<%=request.getContextPath()%>/deconection" >
                            <span class="menu-icon">
                                <i class="mdi mdi-exit-to-app"></i>
                            </span>
                            <span class="menu-title">Deconection</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="container-fluid page-body-wrapper">
                <%@include file="navigateur.jsp" %>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <%@include file="Updatepro.jsp" %> 
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title"> Filtre </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/filtre">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Mois</label>
                                                        <div class="col-sm-9">
                                                            <input type='text' name='Mois' class="form-control" />
                                                            <input type='hidden' name='user' value="<%=user%>" class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Annee</label>
                                                        <div class="col-sm-9">
                                                            <input type='text' name='Annee' class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!--/  entrer table   /-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-contextual">
                                                <thead>
                                                    <tr>
                                                        <th> Mois </th>
                                                        <th> Annee </th>
                                                        <th> Recette </th>
                                                        <th> Depence </th>
                                                        <th> Benefice </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < Tableau_de_board.size(); i++) {%>
                                                    <tr>
                                                        <td class="py-1">
                                                            <p><%=Tableau_de_board.get(i).getMois()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=Tableau_de_board.get(i).getAnnee()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=Tableau_de_board.get(i).getStrRec()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=Tableau_de_board.get(i).getStrDep()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=Tableau_de_board.get(i).getStrBen()%></p>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <!--/  sortie table   /-->
                        </div>
                    </div>
                    <%@include file="footer.jsp" %>
                </div>
            </div>
        </div>
    </body>
</html>
