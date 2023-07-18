<%@page import="modele.*"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Patient> liste = (ArrayList<Patient>) request.getAttribute("liste");
    String pagination = (String) request.getAttribute("pagination");
    String requete = (String) request.getAttribute("requete");
    String modele = (String) request.getAttribute("modele");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud-Patient</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <!-- partial:partials/_sidebar.html -->
            <%@include file="navbarAdmin.jsp" %> 
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
                                        <h4 class="card-title"> New patient </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/newGeneraliser">
                                            <input type="hidden" name="modele" value="<%=modele%>" class="form-control" required=""/>
                                            <input type="hidden" name="sql" value="<%=requete%>" class="form-control" required=""/>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Remboursement</label>
                                                        <div class="col-sm-9">
                                                            <input type='number' name='Remboursement' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Nom</label>
                                                        <div class="col-sm-9">
                                                            <input type='text' name='Nom' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Datenaissance</label>
                                                        <div class="col-sm-9">
                                                            <input type='date' name='Datenaissance' class="form-control" required="" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <%
                                                    ArrayList<Sexe> liste_Sexe = (ArrayList<Sexe>) request.getAttribute("liste_Sexe");
                                                %>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Sexe</label>
                                                        <div class="col-sm-9">
                                                            <select name='Sexe' class="form-control" required="" >
                                                                <% for (int j = 0; j < liste_Sexe.size(); j++) {%> 
                                                                <option  value='<%=liste_Sexe.get(j).getId()%>'><%=liste_Sexe.get(j).getGenre()%></option>
                                                                <% }%>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>           
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
                                                <form method="POST" action="<%=request.getContextPath()%>/GenererPdfGeneraliser">
                                                    <input type="hidden" value="<%=requete%>" name="sql"/>
                                                    <input type="hidden" value="<%=modele%>" name="modele"/>
                                                    <button type="submit" class="btn btn-outline-secondary btn-icon-text" onclick="genererPdf('<%=modele%>', '<%=requete%>')" >Pdf <i class="mdi mdi mdi-file-pdf"></i>
                                                    </button>
                                                </form>
                                            </div>
                                            <div class="col-md-3"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-4">
                                                <form method="POST" action="<%=request.getContextPath()%>/RechercheSimpleGeneraliser">
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
                                        <h4 class="card-title">patient</h4>
                                        <p class="card-description"> Add class <code>.table-striped</code>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th> Id </th>
                                                        <th> Nom </th>
                                                        <th> Sexe </th>
                                                        <th> Datenaissance </th>
                                                        <th> Remboursement </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < liste.size(); i++) {%>
                                                    <tr><td class="py-1">
                                                            <p><%=liste.get(i).getId()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getNom()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getSexe()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getDatenaissance()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getRemboursement()%></p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-success btn-icon-text" data-toggle="modal" data-target="#updatemodal" onclick="Update_Patient('<%=liste.get(i).getId()%>', '<%=liste.get(i).getNom()%>', '<%=liste.get(i).getSexe()%>', '<%=liste.get(i).getDatenaissance()%>', '<%=liste.get(i).getRemboursement()%>')">
                                                                    Update <i class="mdi mdi mdi-pencil-box-outline"></i>
                                                                </button>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-danger btn-icon-text" data-toggle="modal" data-target="#deletemodal" onclick="delete_Patient('<%=liste.get(i).getId()%>')">
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/UpdateGeneraliser">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">id</label>
                                                            <input type="text" class="form-control" name="Id" id="idUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">nom</label>
                                                            <input type="text" class="form-control" name="Nom" id="nomUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">sexe</label>
                                                            <input type="text" class="form-control" name="Sexe" id="sexeUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">datenaissance</label>
                                                            <input type="text" class="form-control" name="Datenaissance" id="datenaissanceUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">remboursement</label>
                                                            <input type="text" class="form-control" name="Remboursement" id="remboursementUpdate">
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/DeleteGeneraliser">
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
    function Update_Patient(id, nom, sexe, datenaissance, remboursement) {
        idUpdate.value = id
        nomUpdate.value = nom
        sexeUpdate.value = sexe
        datenaissanceUpdate.value = datenaissance
        remboursementUpdate.value = remboursement
    }
    function delete_Patient(id) {
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
