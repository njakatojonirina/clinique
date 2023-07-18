<%@page import="modele.*"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Actepatient> liste = (ArrayList<Actepatient>) request.getAttribute("liste");
    String pagination = (String) request.getAttribute("pagination");
    String requete = (String) request.getAttribute("requete");
    String modele = (String) request.getAttribute("modele");
    String param = (String) request.getAttribute("param");
    Integer idutilisateur = (Integer) request.getAttribute("idutilisateur");
    String m = "";
    String a = "";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud-Actepatient</title>
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
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/filtre?Mois=<%=m%>&&Annee=<%=a%>&&user=<%=idutilisateur %>">
                            <span class="menu-icon">
                                <i class="mdi mdi-speedometer"></i>
                            </span>
                            <span class="menu-title">Tableau de Board</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/listerObject?modele=Actepatient&&param=idutilisateur&&idutilisateur=<%=idutilisateur %>">
                            <span class="menu-icon">
                                <i class="mdi mdi-hospital"></i>
                            </span>
                            <span class="menu-title">Acte</span>
                        </a>
                    </li>
                    <li class="nav-item menu-items" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/ListeDepensedetails?idutilisateur=<%=idutilisateur%>">
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
                                        <h4 class="card-title"> New actepatient </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/newObject">
                                            <input type="hidden" name="modele" value="<%=modele%>" class="form-control" required=""/>
                                            <input type="hidden" name="sql" value="<%=requete%>" class="form-control" required=""/>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Idutilisateur</label>
                                                        <div class="col-sm-9">
                                                            <input type='number' value="<%=idutilisateur%>" name='Idutilisateur' class="form-control" required="" />
                                                            <input type='hidden' value="<%=param%>" name='param' class="form-control" required="" />
                                                            <input type='hidden' value="<%=idutilisateur%>" name='idutilisateur' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Date</label>
                                                        <div class="col-sm-9">
                                                            <input type='date' name='Date' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <%
                                                    ArrayList<Patient> liste_Patient = (ArrayList<Patient>) request.getAttribute("liste_Patient");
                                                %>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Patient</label>
                                                        <div class="col-sm-9">
                                                            <select name='Patient' class="form-control" required="" >
                                                                <% for (int j = 0; j < liste_Patient.size(); j++) {%> 
                                                                <option  value='<%=liste_Patient.get(j).getId()%>'><%=liste_Patient.get(j).getNom()%></option>
                                                                <% }%>
                                                            </select>
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
                            <!--/  entrer recherche   /-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <form method="POST" action="<%=request.getContextPath()%>/GenererPdfObject">
                                                    <input type="hidden" value="<%=requete%>" name="sql"/>
                                                    <input type="hidden" value="<%=modele%>" name="modele"/>
                                                    <button type="submit" class="btn btn-outline-secondary btn-icon-text" onclick="genererPdf('<%=modele%>', '<%=requete%>')" >Pdf <i class="mdi mdi mdi-file-pdf"></i>
                                                    </button>
                                                </form>
                                            </div>
                                            <div class="col-md-3"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-4">
                                                <form method="POST" action="<%=request.getContextPath()%>/RechercheSimpleObject">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control"  name="rech"/>
                                                            <input type="hidden" class="form-control"  name="modele" value="<%=modele%>"/>
                                                            <input type="hidden" class="form-control"  name="sql" value="<%=requete%>"/>
                                                            <div class="input-group-append">
                                                                <button class="btn btn-sm btn-primary" type="submit">search</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--/  sortie recherche   /-->

                            <!--/  entrer table   /-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">actepatient</h4>
                                        <p class="card-description"> Add class <code>.table-striped</code>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th> Id </th>
                                                        <th> Date </th>
                                                        <th> Patient </th>
                                                        <th> Idutilisateur </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < liste.size(); i++) {%>
                                                    <tr><td class="py-1">
                                                            <p><%=liste.get(i).getId()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getDate()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getPatient()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getIdutilisateur()%></p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <a href="<%=request.getContextPath()%>/DetailsActePatient?idactdep=<%=liste.get(i).getId()%>" >
                                                                    <button type="button" class="btn btn-outline-info btn-icon-text">
                                                                        Details <i class="mdi mdi mdi-pencil-box-outline"></i>
                                                                    </button>
                                                                </a>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-success btn-icon-text" data-toggle="modal" data-target="#updatemodal" onclick="Update_Actepatient('<%=liste.get(i).getId()%>', '<%=liste.get(i).getDate()%>','<%=liste.get(i).getPatient()%>','<%=liste.get(i).getIdutilisateur()%>')">
                                                                    Update <i class="mdi mdi mdi-pencil-box-outline"></i>
                                                                </button>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-light btn-icon-text" onclick="Pdfgenerate('<%=liste.get(i).getId()%>', '<%=liste.get(i).getDate()%>')">
                                                                    pdf <i class="mdi mdi mdi-file-pdf"></i>
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
                                                <%=pagination%>
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/UpdateObject">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">id</label>
                                                            <input type="text" class="form-control" name="Id" id="idUpdate">
                                                            
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">date</label>
                                                            <input type="text" class="form-control" name="Date" id="dateUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">Patient</label>
                                                            <input type="text" class="form-control" name="Patient" id="PatientUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">Idutilisateur</label>
                                                            <input type="text" class="form-control" name="Idutilisateur" id="IdutilisateurUpdate">
                                                        </div>
                                                        <input type="hidden" class="form-control" name="modele" value="<%=modele%>">
                                                        <input type="hidden" class="form-control" name="sql" value="<%=requete%>">
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/DeleteObject">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">you are Sure??</label>
                                                            <input type="number" class="form-control" name="idDelete" id="idDelete">
                                                            <input type="hidden" class="form-control" name="modele" value="<%=modele%>">
                                                            <input type="hidden" class="form-control" name="sql" value="<%=requete%>">
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
    function Update_Actepatient(id, date,Patient,idutilisateur) {
        idUpdate.value = id
        dateUpdate.value = date
        PatientUpdate.value=Patient
        IdutilisateurUpdate.value=idutilisateur
    }
    function delete_Actepatient(id) {
        idDelete.value = id
    }
    function Pdfgenerate(id, date) {
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
        xhr.open("GET", "PdfGenerer?id=" + id + "&&date=" + date, true);
        xhr.send(null);
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
