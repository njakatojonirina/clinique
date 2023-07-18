<%@page import="modele.*"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Acte> liste = (ArrayList<Acte>) request.getAttribute("liste");
    String pagination = (String) request.getAttribute("pagination");
    String requete = (String) request.getAttribute("requete");
    String modele = (String) request.getAttribute("modele");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud-Acte</title>
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
                                        <h4 class="card-title"> New acte </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/newGeneraliser">
                                            <input type="hidden" name="modele" value="<%=modele%>" class="form-control" required=""/>
                                            <input type="hidden" name="sql" value="<%=requete%>" class="form-control" required=""/>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Nomacte</label>
                                                        <div class="col-sm-9">
                                                            <input type='text' name='Nomacte' class="form-control" required="" />
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
                                        <h4 class="card-title">acte</h4>
                                        <p class="card-description"> Add class <code>.table-striped</code>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th> Id </th>
                                                        <th> Nomacte </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < liste.size(); i++) {%>
                                                    <tr><td class="py-1">
                                                            <p><%=liste.get(i).getId()%></p>
                                                        </td>
                                                        <td class="py-1">
                                                            <p><%=liste.get(i).getNomacte()%></p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-success btn-icon-text" data-toggle="modal" data-target="#updatemodal" onclick="Update_Acte('<%=liste.get(i).getId()%>', '<%=liste.get(i).getNomacte()%>')">
                                                                    Update <i class="mdi mdi mdi-pencil-box-outline"></i>
                                                                </button>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <button type="button" class="btn btn-outline-danger btn-icon-text" data-toggle="modal" data-target="#deletemodal" onclick="delete_Acte('<%=liste.get(i).getId()%>')">
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
                                                            <label for="exampleInputUsername1">nomacte</label>
                                                            <input type="text" class="form-control" name="Nomacte" id="nomacteUpdate">
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
    function Update_Acte(id, nomacte) {
        idUpdate.value = id
        nomacteUpdate.value = nomacte
    }
    function delete_Acte(id) {
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
