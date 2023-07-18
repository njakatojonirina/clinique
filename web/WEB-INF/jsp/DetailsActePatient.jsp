<%-- 
    Document   : DetailsActePatient
    Created on : 17 juil. 2023, 14:33:41
    Author     : Rabeasimbola
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="modele.*"%>
<%
    ArrayList<V_actepatientdep> liste = (ArrayList<V_actepatientdep>) request.getAttribute("listeactepatientdep");
    ArrayList<Acte> listActe = (ArrayList<Acte>) request.getAttribute("listActe");
    String idactdep = (String) request.getAttribute("idactdep");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details</title>
        <%@include file="link.jsp" %> 
    </head>
    <body>
        <div class="container-scroller">
            <%@include file="navbarUser.jsp" %>
            <div class="container-fluid page-body-wrapper">
                <%@include file="navigateur.jsp" %>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <%@include file="Updatepro.jsp" %> 
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title"> New acte </h4>
                                        <p class="card-description"></p>
                                        <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/newMvtActe">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Sexe</label>
                                                        <div class="col-sm-9">
                                                            <select name='idacte' class="form-control" required="" >
                                                                <% for (int j = 0; j < listActe.size(); j++) {%> 
                                                                <option  value='<%=listActe.get(j).getId()%>'><%=listActe.get(j).getNomacte()%></option>
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
                                                            <input type='hidden' name='idactdep' value="<%=idactdep%>" />
                                                        </div>
                                                    </div>
                                                </div> 
                                                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title"> Details </h4>
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
                                                                    <th> Acte </th>
                                                                    <th> Tarif </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (int i = 0; i < liste.size(); i++) {%>
                                                                <tr><td class="py-1">
                                                                        <p><%=liste.get(i).getNomacte()%></p>
                                                                    </td>
                                                                    <td class="py-1">
                                                                        <p><%=liste.get(i).getTarif()%></p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <button type="button" class="btn btn-outline-success btn-icon-text" data-toggle="modal" data-target="#updatemodal" onclick="Update_Acte('<%=liste.get(i).getIdactepatient()%>', '<%=liste.get(i).getIdacte()%>', '<%=liste.get(i).getTarif()%>')">
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
                                    </div>
                                </div>
                            </div>
                                                            
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/UpdateMvtActe">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">iddpact</label>
                                                            <input type="hidden" class="form-control" name="idactdep" id="iddpactUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">idact</label>
                                                            <input type="text" class="form-control" name="idact" id="idactUpdate">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">tarif</label>
                                                            <input type="text" class="form-control" name="tarif" id="tarifUpdate">
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
                                                    <form class="forms-sample" method="POST" action="<%=request.getContextPath()%>/DeleteObject">
                                                        <div class="form-group">
                                                            <label for="exampleInputUsername1">you are Sure??</label>
                                                            <input type="number" class="form-control" name="idDelete" id="idDelete">
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
                    <%@include file="footer.jsp" %>
                </div>
            </div>
        </div>
    </body>
</html>
<script>
    function Update_Acte(idactdp,idact,tarif) {
        iddpactUpdate.value = idactdp
        idactUpdate.value = idact
        tarifUpdate.value = tarif
    }
</script>
