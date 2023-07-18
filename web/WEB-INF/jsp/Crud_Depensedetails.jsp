<%@page import="modele.*"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Depensedetails> liste = (ArrayList<Depensedetails>) request.getAttribute("listeactepatientdep");
    String idutilisateur = (String) request.getAttribute("utilisateur");
    String m = "";
    String a = "";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud-Depensedetails</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <nav class="sidebar sidebar-offcanvas" id="sidebar">
                <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
                    <a class="sidebar-brand brand-logo" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo.svg" alt="logo" /></a>
                    <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="<%=request.getContextPath()%>/assets/images/logo-mini.svg" alt="logo" /></a>
                </div>
                <!-- partial:partials/_sidebar.html -->
                <ul class="nav">
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/filtre?Mois=<%=m%>&&Annee=<%=a%>&&user=<%=idutilisateur %>">
                            <span class="menu-icon">
                                <i class="mdi mdi-speedometer"></i>
                            </span>
                            <span class="menu-title">Tableau de Board</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/listerObject?modele=Actepatient&&param=idutilisateur&&idutilisateur=<%=idutilisateur%>">
                            <span class="menu-icon">
                                <i class="mdi mdi-hospital"></i>
                            </span>
                            <span class="menu-title">Acte</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/listerObject?modele=Depensedetails&&param=utilisateur&&utilisateur=<%=idutilisateur%>">
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
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_navbar.html -->
                <%@include file="navigateur.jsp" %> 
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <%@include file="Updatepro.jsp" %>
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title"> New depensedetails </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/newdepensedetailst">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Date</label>
                                                        <div class="col-sm-9">
                                                            <input type='date' name='Date' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <%
                                                    ArrayList<Depense> liste_Depense = (ArrayList<Depense>) request.getAttribute("listDepense");
                                                %>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Depense</label>
                                                        <div class="col-sm-9">
                                                            <select name='Depense' class="form-control" required="" >
                                                                <% for (int j = 0; j < liste_Depense.size(); j++) {%> 
                                                                <option  value='<%=liste_Depense.get(j).getId()%>'><%=liste_Depense.get(j).getNomdepense()%></option>
                                                                <% }%>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Tarif</label>
                                                        <div class="col-sm-9">
                                                            <input type='text' name='Tarif' class="form-control" required="" />
                                                            <input type='hidden' name='idutilisateur' value="<%=idutilisateur%>" class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                        <div class="col-md-6"></div>
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
                                        <h4 class="card-title">depensedetails</h4>
                                        <p class="card-description"> Add class <code>.table-striped</code>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th> Id </th>
                                                        <th> Tarif </th>
                                                        <th> Date </th>
                                                        <th> Depense </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < liste.size(); i++) {%>
                                                    <tr><td class="py-1">
                                                            <p><%=liste.get(i).getId()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getTarif()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getDate()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getDepense()%></p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-success btn-icon-text" data-toggle="modal" data-target="#updatemodal" onclick="Update_Depensedetails('<%=liste.get(i).getId()%>', '<%=liste.get(i).getTarif()%>', '<%=liste.get(i).getDate()%>', '<%=liste.get(i).getDepense()%>')">
                                                                    Update <i class="mdi mdi mdi-pencil-box-outline"></i>
                                                                </button>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-danger btn-icon-text" data-toggle="modal" data-target="#deletemodal" onclick="delete_Depensedetails('<%=liste.get(i).getId()%>')">
                                                                    Delete <i class="mdi mdi mdi-delete-forever"></i>
                                                                </button>
                                                            </p>
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
                            <!--/  entrer pagination   /-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-9"></div>
                                            <div class="col-md-3">
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/  sortie pagination   /-->
                            <!-------- entrer updatemodal --------->

                            <div class="modal fade" id="updatemodal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Update</h5>
                                        </div>
                                        <div class="modal-body">
                                            <div class="card">
                                                <div class="card-body">
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/UpdateDetailsdp">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">id</label>
                                                            <input type="text" class="form-control" name="Id" id="idUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">tarif</label>
                                                            <input type="text" class="form-control" name="Tarif" id="tarifUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">date</label>
                                                            <input type="text" class="form-control" name="Date" id="dateUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="hidden" class="form-control" name="idutilisateur" value="<%=idutilisateur%>">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">depense</label>
                                                            <input type="text" class="form-control" name="Depense" id="depenseUpdate">
                                                        </div>
                                                        <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="close" title="Fermer" style="font-size: 15px;" data-toggle="modal" data-target="#compte1">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-------- sortie updatemodal --------->
                            <!-------- entrer deletemodal --------->

                            <div class="modal fade" id="deletemodal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Delete</h5>
                                        </div>
                                        <div class="modal-body">
                                            <div class="card">
                                                <div class="card-body">
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/DeleteDetailsdpt">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">you are Sure??</label>
                                                            <input type="number" class="form-control" name="idDelete" id="idDelete">
                                                            <input type="hidden" class="form-control" name="idutilisateur" value="<%=idutilisateur%>">
                                                        </div>
                                                        <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="close" title="Fermer" style="font-size: 15px;" data-toggle="modal" data-target="#compte1">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-------- sortie deletemodal --------->
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
<script>
    function Update_Depensedetails(id, tarif, date, depense) {
        idUpdate.value = id
        tarifUpdate.value = tarif
        dateUpdate.value = date
        depenseUpdate.value = depense
    }
    function delete_Depensedetails(id) {
        idDelete.value = id
    }
    function genererPdf(modele, requete) {
        rechargerPage()
        var xhr;
        try {
            xhr = new ActiveXObject('Msxml2.XMLHTTP');
        } catch (e)
        {
            try {
                xhr = new ActiveXObject('Microsoft.XMLHTTP');
            } catch (e2)
            {
                try {
                    xhr = new XMLHttpRequest();
                } catch (e3) {
                    xhr = false;
                }
            }
        }
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    rechargerPage()
                }
            }
        };
        xhr.open("GET", "GenererPdfObject?modele=" + modele + "&&sql=" + requete, true);
        xhr.send(null);
    }
    function rechargerPage() {
        location.reload();
    }
</script>
