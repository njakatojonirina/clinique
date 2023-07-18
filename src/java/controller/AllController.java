/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.DaoGeneric;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modele.Acte;
import modele.Actepatientdep;
import modele.Depense;
import modele.Depensedetails;
import modele.Tableau_de_board;
import modele.Utilisateur;
import modele.V_actepatientdep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pdf.Pdf;


/**
 *
 * @author Rabeasimbola
 */
@Controller
public class AllController {
    @Autowired
    private ServletContext servletContext;
    @RequestMapping(value="/")
    public String index(Model model) throws Exception{
        
        return "index";
    }
    @RequestMapping(value="/login")
    public String login(HttpServletRequest request,Model model){
        String type = request.getParameter("type");
        model.addAttribute("type", type);
        return "login";
    }
    @RequestMapping(value="/logincontrol")
    public String logincontrol(HttpServletRequest request,Model model) throws Exception{
        String type = request.getParameter("type");
        String login = request.getParameter("login");
        String mdp = request.getParameter("mdp");
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setLogin(login);
        utilisateur.setMotdepasse(mdp);
        utilisateur.setType(Integer.parseInt(type));
        DaoGeneric daoGeneric = new DaoGeneric();
        ArrayList list = daoGeneric.findWhere(utilisateur);
        model.addAttribute("type", type);
        Tableau_de_board tableau_de_board = new Tableau_de_board();
        ArrayList arrayList = daoGeneric.find("select * from Tableau_de_board", tableau_de_board);
        if (list.size() == 1) {
            if (type.equals("1")) {
                return "AcceuilAdmin";
            }else{
                model.addAttribute("user", ((Utilisateur) list.get(0)).getId());
                model.addAttribute("Tableau_de_board", arrayList);
                return "AcceuilUtilisateur";
            }
        }else{
            return "login";
        }
    }
    @RequestMapping(value="/inscription")
    public String inscription(){
        return "inscription";
    }
    @RequestMapping(value="/BackOffice")
    public String BackOffice(){
        return "BackOffice";
    }
    @RequestMapping(value="/Crud")
    public String Crud(){
        return "crud";
    }
    @RequestMapping(value="/CrudSexe")
    public String Crud_Sexe(){
        return "Crud_Sexe";
    }
    @RequestMapping(value="/listCard")
    public String listCard(){
        return "listCard";
    }
    @RequestMapping(value="/deconection")
    public String deconection(){
        return "index";
    }
    @RequestMapping(value="/DetailsActePatient")
    public String DetailsActePatient(HttpServletRequest request,Model model) throws Exception{
        String idactdep = request.getParameter("idactdep");
        V_actepatientdep actepatientdep = new V_actepatientdep();
        DaoGeneric dao = new DaoGeneric();
        try {
            ArrayList listActe = dao.find("select * from acte", new Acte());
            ArrayList list = dao.find("select * from v_actepatientdep where idactepatient = "+idactdep, actepatientdep);
            model.addAttribute("listeactepatientdep", list);
            model.addAttribute("listActe", listActe);
            model.addAttribute("idactdep", idactdep);
        } catch (Exception e) {
            throw e;
        }
        return "DetailsActePatient";
    }
    
    @RequestMapping(value="/newMvtActe")
    public String newMvtActe(HttpServletRequest request,Model model) throws Exception{
        String idacte = request.getParameter("idacte");
        String tarif = request.getParameter("Tarif");
        String idactdep = request.getParameter("idactdep");
        Actepatientdep actepatientdep = new Actepatientdep();
        DaoGeneric dao = new DaoGeneric();
        try {
            actepatientdep.setIdacte(Integer.parseInt(idacte));
            actepatientdep.setTarif(Double.parseDouble(tarif));
            actepatientdep.setIdactpt(Integer.parseInt(idactdep));
            ArrayList list = dao.findWhere(actepatientdep);
            if (list.size() == 0) {
                dao.save(actepatientdep);
            }
            DetailsActePatient(request, model);
        } catch (Exception e) {
            throw e;
        }
        return "DetailsActePatient";
    }
    @RequestMapping(value="/UpdateMvtActe")
    public String UpdateMvtActe(HttpServletRequest request,Model model) throws Exception{
        String idacte = request.getParameter("idact");
        String tarif = request.getParameter("tarif");
        String idactdep = request.getParameter("idactdep");
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = new connectBase.ConnectBase().getConnexion();
            String requete = "update actepatientdep set Idactpt="+idactdep+",Idacte="+idacte+",Tarif="+tarif+" where ";
            requete+="Idactpt="+idactdep+" and Idacte="+idacte;
            stmt = con.prepareStatement(requete);
            stmt.executeUpdate();
            System.out.println(requete);
            DetailsActePatient(request, model);
        } catch (Exception e) {
            throw e;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
        return "DetailsActePatient";
    }
    @RequestMapping(value="/PdfGenerer")
     public /*String*/ void PdfGenerer(HttpServletRequest request,Model model,HttpServletResponse response) throws Exception{
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        String date = "";
        date = request.getParameter("date");
        try {
            Pdf pdf = new Pdf();
            String contenue = pdf.genererFacturePDF(Integer.parseInt(id), date);
            out.print("ok");
            pdf.genererPdf(servletContext.getRealPath(""), "input", contenue);
        } catch (Exception e) {
        }
    }
     
    @RequestMapping(value="/ListeDepensedetails")
    public String ListeDepensedetails(HttpServletRequest request,Model model) throws Exception{
        String utilisateur = request.getParameter("idutilisateur");
        System.out.println(utilisateur);
        Depensedetails depensedetails = new Depensedetails();
        DaoGeneric dao = new DaoGeneric();
        try {
            ArrayList listDepense = dao.find("select * from depense", new Depense());
            ArrayList list = dao.find("select * from depensedetails where utilisateur = "+utilisateur, depensedetails);
            model.addAttribute("listeactepatientdep", list);
            model.addAttribute("listDepense", listDepense);
            model.addAttribute("utilisateur", utilisateur);
        } catch (Exception e) {
            throw e;
        }
        return "Crud_Depensedetails";
    }
     
    @RequestMapping(value="/newdepensedetailst")
    public String newdepensedetailst(HttpServletRequest request,Model model) throws Exception{
        String idutilisateur = request.getParameter("idutilisateur");
        String tarif = request.getParameter("Tarif");
        String Depense = request.getParameter("Depense");
        String date = request.getParameter("Date");
        Depensedetails depensedetails = new Depensedetails();
        DaoGeneric dao = new DaoGeneric();
        try {
            depensedetails.setUtilisateur(Integer.parseInt(idutilisateur));
            depensedetails.setDepense(Integer.parseInt(Depense));
            depensedetails.setTarif(Double.parseDouble(tarif));
            depensedetails.setDate(Date.valueOf(date));
            ArrayList list = dao.findWhere(depensedetails);
            if (list.size() == 0) {
                dao.save(depensedetails);
            }
            ListeDepensedetails(request, model);
        } catch (Exception e) {
            throw e;
        }
        return "Crud_Depensedetails";
    }
    @RequestMapping(value="/UpdateDetailsdp")
    public String UpdateDetailsdp(HttpServletRequest request,Model model) throws Exception{
        String id = request.getParameter("Id");
        String Date = request.getParameter("Date");
        String tarif = request.getParameter("Tarif");
        String Depense = request.getParameter("Depense");
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = new connectBase.ConnectBase().getConnexion();
            String requete = "update depensedetails set id="+id+",tarif="+tarif+",date='"+Date+"',depense="+Depense+" where ";
            requete+="id="+id;
            stmt = con.prepareStatement(requete);
            stmt.executeUpdate();
            ListeDepensedetails(request, model);
        } catch (Exception e) {
            throw e;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
        return "Crud_Depensedetails";
    }
    @RequestMapping(value="/DeleteDetailsdpt")
    public String DeleteObject(HttpServletRequest request,Model model) throws Exception{
        String vue = "";
        try {
            String id = request.getParameter("idDelete");
            DaoGeneric dao = new DaoGeneric();
            Depensedetails depensedetails = new Depensedetails();
            depensedetails.setId(Integer.parseInt(id));
            dao.delete(depensedetails);
            ListeDepensedetails(request, model);
        } catch (Exception e) {
            throw e;
        }
        return "Crud_Depensedetails";
    }
    @RequestMapping(value="/filtre")
    public String filtre(HttpServletRequest request,Model model) throws Exception{
        String Mois = "2023";
        String annee = "07";
        try {
            if (request.getParameter("Mois").equals("") == false) {
                Mois = request.getParameter("Mois");
            }
            if (request.getParameter("Annee").equals("") == false) {
                annee = request.getParameter("Annee");
            }
            DaoGeneric dao = new DaoGeneric();
            Tableau_de_board tableau_de_board = new Tableau_de_board();
            String requete = "";
            if (request.getParameter("Mois").equals("") == false && request.getParameter("Annee").equals("")) {
                requete = "select * from Tableau_de_board where id = "+Mois;
            }
            else if (request.getParameter("Mois").equals("") && request.getParameter("Annee").equals("") == false) {
                requete = "select * from Tableau_de_board where annee = "+annee;
            }
            else if (request.getParameter("Mois").equals("") == false && request.getParameter("Annee").equals("") == false) {
                requete = "select * from Tableau_de_board where id = "+Mois+" and annee = "+annee;
            }
            else{
                requete = "select * from Tableau_de_board where id = "+Mois+" and annee = "+annee;
            }
            System.out.println(requete);
            ArrayList arrayList = dao.find(requete, tableau_de_board);
            int id = Integer.parseInt(request.getParameter("user"));
            model.addAttribute("user", id);
            model.addAttribute("Tableau_de_board", arrayList);
            return "AcceuilUtilisateur";
        } catch (Exception e) {
            throw e;
        }
    }
}
