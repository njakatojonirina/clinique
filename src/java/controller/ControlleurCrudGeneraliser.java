/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import annotation.ListeDeroulant;
import annotation.NomColonneRecherche;
import annotation.NomVue;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import dao.DaoGeneric;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modele.Ligne;
import modele.Pagination;
//import modele.object;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pdf.Pdf;
import utilitaire.Utilitaire;

/**
 *
 * @author Rabeasimbola
 */
@Controller
public class ControlleurCrudGeneraliser {
    @Autowired
    private ServletContext servletContext;
    
    @RequestMapping(value="/listerObject")
    public String listerObject(HttpServletRequest request,Model model,String liste) throws Exception{
        String vue = "";
        try {
            int depart = 0;
            String mot = null;
            String sql = null;
            String modele = null;
            String param = null;
            int id = 0;
            int etat = 0;
            if (request.getParameter("depart") != null) {
                depart = Integer.parseInt(request.getParameter("depart"));
            }
            if (request.getParameter("mot") != null) {
                mot = request.getParameter("mot");
            }
            if (request.getParameter("sql") != null) {
                sql = request.getParameter("sql");
            }
            if (request.getParameter("modele") != null) {
                modele = request.getParameter("modele");
            }
            if (request.getParameter("etat") != null) {
                etat = Integer.parseInt(request.getParameter("etat"));
            }
            if (request.getParameter("param") != null) {
                param = request.getParameter("param");
                System.out.println("aaaaaaa "+param);
                id = Integer.parseInt(request.getParameter(param));
                model.addAttribute(param, id);
                model.addAttribute("param",param);
            }
            String requete = ""; 
            Class cla = Class.forName("modele."+modele);
            model.addAttribute("modele", modele);
            Object object = cla.newInstance();
            DaoGeneric dao = new DaoGeneric();
            Utilitaire utilitaire = new Utilitaire();
            if (liste == null) {
                Pagination pagination = new Pagination();
                int ligne = pagination.get_nb_ligne(new Ligne());
                if (id == 0 && etat == 0) {
                    requete = "select * from "+modele+" ORDER by id asc offset "+depart+" limit "+ligne;
                }else if(id != 0 && etat == 0){
                    requete = "select * from "+modele+" where "+param+" = "+id+" ORDER by id asc offset "+depart+" limit "+ligne;
                    model.addAttribute("id", id);
                }else if(id == 0 && etat != 0){
                    requete = "select * from "+modele+" where etat = "+etat+" ORDER by id asc offset "+depart+" limit "+ligne;
                    model.addAttribute("id", id);
                }else{
                    requete = "select * from "+modele+" where etat = "+etat+" and "+param+" = "+id+" ORDER by id asc offset "+depart+" limit "+ligne;
                    model.addAttribute("id", id);
                }
                System.out.println("éééééééééé "+requete);
                ArrayList list = dao.find(requete, object);
                model.addAttribute("liste", list);
                model.addAttribute("requete", requete);
                String paginat = pagination.paginationgenerer(object, new Ligne(), 0, mot, null, "listerObject",sql,modele);
                model.addAttribute("pagination", paginat);
            }else{
                Gson gson =  new Gson();
                /*ArrayList<object> listepersonne = gson.fromJson(liste, new TypeToken<ArrayList<object>>(){}.getType());
                model.addAttribute("liste", listepersonne*/
            }
            String[] listeDeroulant = {""};
            int taille = 0;
            if (object.getClass().getAnnotation(ListeDeroulant.class) != null) {
                listeDeroulant = object.getClass().getAnnotation(ListeDeroulant.class).Deroulant();
                taille = listeDeroulant.length;
            }
            for (int i = 0; i < taille; i++) {
                Class clas = Class.forName("modele." + utilitaire.toUpper(listeDeroulant[i]));
                String send = "liste_"+utilitaire.toUpper(listeDeroulant[i]);
                ArrayList list = dao.find("select * from " + listeDeroulant[i], clas.newInstance());
                model.addAttribute(send, list);
            }
            if (object.getClass().getAnnotation(NomVue.class) != null) {
                vue = object.getClass().getAnnotation(NomVue.class).VueJsp();
            }
        } catch (Exception e) {
            throw e;
        }
        return vue;
    }
    @RequestMapping(value="/newObject")
    public String newObject(HttpServletRequest request,Model model) throws Exception{
        String vue = "";
        try {
            DaoGeneric dao = new DaoGeneric();
            Utilitaire utilitaire = new Utilitaire();
            String modele = request.getParameter("modele");
            String param = request.getParameter("param");
            String param_aa = request.getParameter(utilitaire.toUpper(param));
            System.out.println("yyyyyyyyy     "+param_aa);
            model.addAttribute("param", param);
            model.addAttribute(param, Integer.parseInt(param_aa)); 
            System.out.println("");
            Class cla = Class.forName("modele."+modele);
            Object object = cla.newInstance();
            String[] attribut = utilitaire.getAttribut(object);
            Object o = utilitaire.requestAuto(attribut,request, object);
            ArrayList liste = dao.findWhere(o);
            System.out.println("aaaaaaaa "+liste.size());
            if (liste.size() == 0) {
                dao.save(o);
            }
            String sql = "";
            if (request.getParameter("sql") != null) {
                sql = request.getParameter("sql");
            }
            listerObject(request, model, null);
            Pagination pagination = new Pagination();
            String paginat = pagination.paginationgenerer(o, new Ligne(), 0, null, null, "listerObject",sql,modele);
            model.addAttribute("pagination", paginat);
            if (object.getClass().getAnnotation(NomVue.class) != null) {
                vue = object.getClass().getAnnotation(NomVue.class).VueJsp();
            }
        } catch (Exception e) {
            throw e;
        }
        return vue;
    }
    @RequestMapping(value="/UpdateObject")
    public String UpdateObject(HttpServletRequest request,Model model,String liste) throws Exception{
        String vue = "";
        try {
            DaoGeneric dao = new DaoGeneric();
            String modele = request.getParameter("modele");
            Class cla = Class.forName("modele."+modele);
            Object object = cla.newInstance();
            Utilitaire utilitaire = new Utilitaire();
            String[] attribut = utilitaire.getAllAttribut(object);
            Object o = utilitaire.requestAuto(attribut,request, object);
            dao.update(o);
            listerObject(request, model, null);
            if (object.getClass().getAnnotation(NomVue.class) != null) {
                vue = object.getClass().getAnnotation(NomVue.class).VueJsp();
            }
        } catch (Exception e) {
            throw e;
        }
        return vue;
    }
    @RequestMapping(value="/DeleteObject")
    public String DeleteObject(HttpServletRequest request,Model model) throws Exception{
        String vue = "";
        try {
            String id = request.getParameter("idDelete");
            DaoGeneric dao = new DaoGeneric();
            String modele = request.getParameter("modele");
            Class cla = Class.forName("modele."+modele);
            Object object = cla.newInstance();
            object.getClass().getDeclaredMethod("setId", int.class).invoke(object, Integer.parseInt(id));
            dao.delete(object);
            listerObject(request, model, null);
            if (object.getClass().getAnnotation(NomVue.class) != null) {
                vue = object.getClass().getAnnotation(NomVue.class).VueJsp();
            }
        } catch (Exception e) {
            throw e;
        }
        return vue;
    }
    @RequestMapping(value="/RechercheSimpleObject")
    public String RechercheSimpleObject(HttpServletRequest request,Model model) throws Exception{
        String vue = "";
        String param = "";
        int id = 0;
        int etat = 0;
        try {
            Pagination pagination = new Pagination();
            String depart = "0";
            if (request.getParameter("depart") != null) {
                depart = request.getParameter("depart");
            }
            if (request.getParameter("param") != null) {
                param = request.getParameter("param");
                id = Integer.parseInt(request.getParameter(param));
            }
            if (request.getParameter("etat") != null) {
                etat = Integer.parseInt(request.getParameter("etat"));
            }
            String[] colonne = null;
            String mot = request.getParameter("rech");
            String modele = request.getParameter("modele");
            Class cla = Class.forName("modele."+modele);
            Object object = cla.newInstance();
            DaoGeneric dao = new DaoGeneric();
            if (object.getClass().getAnnotation(NomColonneRecherche.class) != null) {
                colonne = object.getClass().getAnnotation(NomColonneRecherche.class).ColonneRecherche();
            }
            String requete = pagination.requeteRecherche(object, new Ligne(), 5, mot, colonne,null);
            if (id == 0 && etat == 0) {
                requete+=" offset "+depart+" limit "+pagination.get_nb_ligne(new Ligne());
            }else if(id != 0 && etat == 0){
                requete+=" and "+param+" = "+id+" offset "+depart+" limit "+pagination.get_nb_ligne(new Ligne());
                model.addAttribute("id", id);
            }else if(id == 0 && etat != 0){
                requete+=" and etat = "+etat+" offset "+depart+" limit "+pagination.get_nb_ligne(new Ligne());
                model.addAttribute("id", id);
            }else{
                requete+=" and etat = "+etat+" and "+param+" = "+id+" offset "+depart+" limit "+pagination.get_nb_ligne(new Ligne());
                model.addAttribute("id", id);
            }
            System.out.println("&&&&&&&&&&&&& "+requete);
            ArrayList liste = dao.find(requete,object);
            String paginat = pagination.paginationgenerer(object, new Ligne(), 5, mot, colonne, "listerObject",null,modele);
            model.addAttribute("liste", liste);
            model.addAttribute("modele", modele);
            model.addAttribute("requete", requete);
            model.addAttribute("pagination", paginat);
            if (object.getClass().getAnnotation(NomVue.class) != null) {
                vue = object.getClass().getAnnotation(NomVue.class).VueJsp();
            }
            String[] listeDeroulant = {""};
            int taille = 0;
            Utilitaire utilitaire = new Utilitaire();
            if (object.getClass().getAnnotation(ListeDeroulant.class) != null) {
                listeDeroulant = object.getClass().getAnnotation(ListeDeroulant.class).Deroulant();
                taille = listeDeroulant.length;
            }
            for (int i = 0; i < taille; i++) {
                Class clas = Class.forName("modele." + utilitaire.toUpper(listeDeroulant[i]));
                String send = "liste_"+utilitaire.toUpper(listeDeroulant[i]);
                ArrayList list = dao.find("select * from " + listeDeroulant[i], clas.newInstance());
                model.addAttribute(send, list);
            }
        } catch (Exception e) {
            throw e;
        }
        return vue;
    }
    @RequestMapping(value="/GenererPdfObject")
     public /*String*/ void GenererPdf(HttpServletRequest request,Model model,HttpServletResponse response) throws Exception{
        PrintWriter out = response.getWriter();
        String modele = request.getParameter("modele");
        String requete = "";
        requete = request.getParameter("sql");
        Class cla = Class.forName("modele."+modele);
        Object object = cla.newInstance();
        System.out.println("modele : "+modele);
        System.out.println("requete : "+requete);
        try {
            Pdf pdf = new Pdf();
            String contenue = pdf.tablepdf(object, requete);
            out.print("ok");
            pdf.genererPdf(servletContext.getRealPath(""), "input", contenue);
        } catch (Exception e) {
        }
    }
     
}
